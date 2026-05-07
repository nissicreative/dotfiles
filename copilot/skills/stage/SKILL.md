---
name: stage
description: >
    Prepares an atomic git commit by surveying all changes, grouping them into
    logical units, staging the right files, and drafting a commit message.
    Then asks the user to choose: copy message, commit, commit and push, or
    unstage. Trigger when the user runs `/stage`, asks to prep/stage changes,
    draft a commit message, or get work ready to commit.
---

# Stage

Prepare exactly one atomic commit. Survey changes, choose one coherent group,
stage only that group, draft commit text, and ask the user which action to run.
Do not choose an action automatically.

## Step 1 — Survey changes

Run these checks first:

- `git status`
- `git diff HEAD`
- `git diff --cached`

Build a complete picture of changed files and intent.

## Step 2 — Identify logical groups

Decide whether all changes tell one clear story.

Split when concerns are mixed, such as:

- unrelated files for unrelated reasons
- refactor mixed with feature/fix
- dependency update mixed with app code
- standalone changes that should land separately

If multiple groups exist, select the most coherent/self-contained group now.
Keep remaining groups unstaged and report them later.
Attempt to maintain migration order if applicable, but prioritize logical grouping over strict file order.

## Step 3 — Stage selected group

- Prefer `git add <file>` for whole-file staging.
- Use `git add -p <file>` only when the split is genuinely clean and the
  environment supports interactive patch staging.

Track exactly which files this skill staged in this run.

Never stage:

- `.env` files or anything that appears secret/credential-like
- build artifacts/generated files unless explicitly intended
- lock files unless paired with matching dependency changes

## Step 4 — Draft commit message

Draft a subject and body suitable for immediate commit use.

Subject rules:

- imperative mood
- under 72 characters
- focus on functional change/intent
- avoid mechanical file-list wording

Run `git log --oneline -10` and align with repository style.
Do not add ticket prefixes unless recent commits do.

Body rules:

- blank line after subject
- 2–5 bullets or short lines
- each line under 72 characters
- omit body only if subject is fully sufficient

## Step 5 — Present staged result

Show clearly:

1. **Staged files** using `git diff --cached --stat`
2. **Commit message** (subject + body) in one copyable code block
3. **Not staged** note (only if applicable), with brief reason

Do not commit yet.

## Step 6 — Ask user for next action

Use `vscode_askQuestions` with exactly these four options in this order:

1. **Copy message**
2. **Commit**
3. **Commit and push**
4. **Unstage**

### Option behavior

#### 1) Copy message

- Leave files staged.
- Copy the drafted message to macOS clipboard with `pbcopy`.
- Confirm: `Copied. Files remain staged.`

#### 2) Commit

- Commit using stdin to preserve multiline body exactly:
    - `git commit -F -` (provide drafted message through stdin/heredoc)
- On success, print resulting commit hash and subject.

#### 3) Commit and push

- Run commit as in option 2.
- Then run `git push`.
- If push fails due to missing upstream:
    - run `git push -u origin <current-branch>`
- Never force push.
- Report other push errors as-is.

#### 4) Unstage

- Unstage only files staged by this skill in Step 3:
    - `git reset HEAD -- <files-staged-by-skill>`
- Preserve anything that was already staged before this skill started.
- Confirm which files were unstaged.

After executing the selected action, stop.
Do not chain more actions unless the user asks.

---

Example output:

Staged (3 files):
app/Http/Controllers/CheckoutController.php | 5 +++++
app/Livewire/Checkout/GuestForm.php | 3 +++
resources/views/checkout/guest.blade.php | 1 +

Commit message:
Allow guests to check out without registering

- Add guest() and storeGuest() actions to CheckoutController
- Add GuestForm component for email/address capture
- Add guest checkout view wired to the new component

Not staged:
database/migrations/2026_04_15_add_guest_flag.php — separate concern
(schema change); commit separately when ready.
