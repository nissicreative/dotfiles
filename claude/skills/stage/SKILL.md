---
name: stage
description: >
    Prepares an atomic git commit by surveying all changes, grouping them into
    logical units, staging the right files, and drafting a commit message —
    then pauses to let the user choose: copy the message, commit, commit and
    push, or unstage. Use this skill whenever the user runs `/stage`, asks to
    "prep a commit", "stage changes", "draft a commit message", or wants to
    get changes ready without committing yet. Also trigger when the user says
    things like "get this ready to commit" or "what should I commit here".
---

# Stage

Your job is to prepare a single, atomic git commit: survey what's changed,
decide what belongs together, stage it, draft a message, and then hand the
user a small menu of next steps. Do not pick an option on your own.

## Step 1 — Survey the changes

Run these in parallel:

- `git status` — see what's tracked, untracked, or already staged
- `git diff HEAD` — see all unstaged content changes
- `git diff --cached` — see anything already staged

Read the output carefully. Build a mental picture of every changed file and
why it likely changed.

## Step 2 — Identify logical groups

Ask yourself: if someone reviewed this as a single commit, would it tell one
clear story? If yes, all the changes belong together. If no, there are
multiple independent concerns mixed in.

Common reasons to split:

- Unrelated files changed for unrelated reasons
- A refactor mixed in with a feature or bug fix
- A dependency update bundled with application code changes
- Test changes that stand alone from the feature they cover (rare — usually
  tests belong with the feature)

If there are multiple groups, choose the most coherent or self-contained one
to stage now. You will tell the user about the rest.

## Step 3 — Stage the chosen group

Use `git add <file>` for whole files. Use `git add -p <file>` when only part
of a file belongs to this commit — but only if the split is genuinely clean.
Don't over-engineer it.

Never stage:

- `.env` files or anything that looks like secrets or credentials
- Build artifacts or generated files unless that's explicitly the point
- Lock files unless there's a corresponding dependency change in the same
  group

## Step 4 — Draft the commit message

Draft both a subject line and a body the user can copy, edit, and use
directly with `git commit`.

**Subject** (first line): imperative mood, under 72 characters. Focus on
_why_ or _what changed functionally_ — not the mechanical what. "Allow guests
to check out without registering" is good; "Update CheckoutController.php" is
not. Check `git log --oneline -10` to match the project's existing style.
Don't add a ticket number prefix unless the recent commits do.

**Body** (after a blank line): 2–5 bullet points or short sentences that
explain what was done and why. Each bullet under 72 characters. Omit the body
only if the subject truly says everything (e.g. "Fix typo in README").

## Step 5 — Present the result

Show three things, clearly separated:

1. **Staged files** — `git diff --cached --stat` output
2. **Commit message** — the full subject + body in a single copyable code
   block, exactly as it would appear in `git commit -m "..."`
3. **Not staged** (only if applicable) — a brief note for the user's
   awareness about what remains unstaged and why. This is informational
   only; it is not part of the commit message.

Then go to Step 6. Do not run `git commit` yet.

## Step 6 — Offer next-step options

Use the AskUserQuestion tool to ask which action to take. Present exactly
these four choices, **in this order**:

1. **Copy message** — Leave files staged; copy the commit message to the
   macOS clipboard via `pbcopy`. Confirm with "Copied. Files remain staged."
2. **Commit** — Run `git commit` with the drafted subject and body. Use
   stdin via `git commit -F -` (heredoc) so multi-line bodies are preserved
   exactly. Print the resulting commit hash and subject on success.
3. **Commit and push** — Run the commit as in option 2, then `git push`. If
   push fails because no upstream is set, run
   `git push -u origin <current-branch>` and report the result. Never force
   push. Other push failures (rejected non-fast-forward, auth errors) should
   be reported back as-is, not worked around.
4. **Unstage** — Run `git reset HEAD --` scoped to only the files this skill
   staged in Step 3 (track them during staging). Anything the user had
   pre-staged before running the skill must remain staged. Confirm what was
   unstaged.

After executing the chosen action, stop. Do not chain additional actions or
suggest follow-ups unless the user asks.

---

**Example output format:**

```
Staged (3 files):
  app/Http/Controllers/CheckoutController.php   | 5 +++++
  app/Livewire/Checkout/GuestForm.php           | 3 +++
  resources/views/checkout/guest.blade.php      | 1 +

Commit message:
  Allow guests to check out without registering

  - Add guest() and storeGuest() actions to CheckoutController
  - Add GuestForm Livewire component for email/address capture
  - Add guest checkout view wired to the new component

Not staged:
  database/migrations/2026_04_15_add_guest_flag.php — separate concern
  (schema change); commit on its own once you're ready.
```
