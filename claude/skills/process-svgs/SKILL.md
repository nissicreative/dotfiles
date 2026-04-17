---
name: process-svgs
description: >
  Process SVG logo exports from Illustrator: copy color variants to ui variants,
  run SVGO optimization on all SVGs, and inject fill="currentColor" into ui files.
  Use when the user says "process my SVGs", "optimize my logo SVGs", "run process-svgs",
  or asks to prepare SVG exports after exporting from Illustrator.
---

# Process SVGs

This skill runs `process-svgs` — a script in `~/dotfiles/bin/` — against a folder
of SVG logo exports from Illustrator.

## What the script does

1. Copies every `*-color.svg` to a matching `*-ui.svg`
2. Runs SVGO (`--multipass`) on all SVGs in the directory
3. Injects `fill="currentColor"` into the root `<svg>` element of every `*-ui.svg`

The accent color (hardcoded hex on specific paths) is preserved unchanged.
The `currentColor` fill on the root means the main logo color inherits from
the parent element's CSS `color` property.

## Expected file naming convention

```
{brand}-{element}-color.svg    ← primary branded version
{brand}-{element}-reverse.svg  ← white text/mark with color accent, for dark backgrounds
{brand}-{element}-white.svg    ← fully white/monochromatic
{brand}-{element}-black.svg    ← fully black/monochromatic
```

After running, a `{brand}-{element}-ui.svg` will be generated for each element.

## How to run

Ask the user for the path to their SVG folder if not already known, then run:

```bash
process-svgs /path/to/SVG/folder
```

Or from within the SVG folder:

```bash
process-svgs
```

## Step-by-step

1. Confirm the SVG export folder location with the user
2. Check that files exist and follow the naming convention above
3. Run `process-svgs [path]` via bash
4. Show the user the output — file sizes before/after, files created
5. Spot-check one ui file to confirm `fill="currentColor"` was injected correctly
6. Let the user know the files are ready to review before moving them to their final location

## Notes

- The script requires `npx` (available via Herd/NVM in interactive shell sessions)
- SVGO is invoked via `npx svgo` — no global install required
- The script uses macOS `sed -i ''` syntax; it will not work on Linux without modification
- After processing, the user typically runs the files through a quick visual check,
  then moves them from an Exports folder to their final Logos folder structure
