---
name: copilot-handoff
description: >
    Formats a Claude plan file as a self-contained GitHub Copilot Chat prompt
    and copies it to the clipboard. Use when the user wants to hand a plan off
    to Copilot for execution — typically to save Claude usage for higher-value
    work. Trigger on: "hand off to Copilot", "send this to Copilot", "copilot-handoff",
    "/copilot-handoff", "let Copilot execute this", "have Copilot implement the plan".
---

# Copilot Handoff

Your job is to take a Claude plan file, wrap it in a Copilot-targeted prompt,
and put it on the user's clipboard. Do not execute the plan yourself.

## Step 1 — Find plan files

Run:

```
ls -t ~/.claude/plans/*.md 2>/dev/null
```

If no files are found, tell the user no plan files exist and suggest running
`/plan` first. Stop here.

## Step 2 — Select a plan

If only one plan file exists, use it and tell the user which one you're using.

If multiple exist, use the AskUserQuestion tool to present them by filename
(newest first, since the list is already sorted by `-t`) and ask which to hand
off. Wait for the user's selection before continuing.

## Step 3 — Read the plan

Read the selected plan file in full. Note whether it includes a Verification
section — you'll need this in the next step.

## Step 4 — Format the Copilot prompt

Construct the prompt as follows:

```
You are acting as a junior developer executing a detailed implementation plan
created by another engineer. Your job is to implement it exactly as specified.

Rules:
- Follow each step precisely. Do not deviate or make design decisions beyond
  what is written.
- Use @workspace to read relevant files before making changes so you have
  full context.
- If any step is ambiguous, a file referenced doesn't exist, or you encounter
  an unexpected state, stop and ask for clarification rather than guessing.
- After completing all changes, run the verification steps at the end.

---

[PASTE THE FULL PLAN FILE CONTENT HERE, VERBATIM]
```

If the plan has no Verification section, append this after the plan content:

```
---

No verification steps were specified. Run the project's test suite (if one
exists) after completing the implementation.
```

## Step 5 — Copy to clipboard

Pipe the full formatted prompt through `pbcopy`:

```bash
printf '%s' "<prompt>" | pbcopy
```

Use `printf '%s'` rather than `echo` to avoid adding an extra newline.

## Step 6 — Confirm to the user

Tell the user:
- Which plan file was used
- That the prompt is on their clipboard
- To open Copilot Chat in VS Code (Ctrl+Shift+I / Cmd+Shift+I), type `@workspace`,
  paste, and send
- One reminder: Copilot won't have Claude's exploration context, so the plan
  should be self-contained — plan files are designed to be, but flag if the
  selected plan looked thin on detail

Do not suggest follow-up actions beyond this. Stop after confirming.

---

**Example confirmation:**

```
Prompt copied to clipboard.

Plan used: ~/.claude/plans/add-guest-checkout-flow.md

Open Copilot Chat (Cmd+Shift+I), type @workspace, paste, and send.

Note: the plan's Verification section includes specific routes to test —
make sure Copilot runs those steps before you mark it done.
```
