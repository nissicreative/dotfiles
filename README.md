# dotfiles

Personal dotfiles for macOS, managing zsh, git, Claude CLI, and Tinkerwell configuration via symlinks.

## Prerequisites

Before running the install script, make sure the following are installed:

- [Homebrew](https://brew.sh)
- [oh-my-zsh](https://ohmyz.sh)
- [Herd](https://herd.laravel.com) — manages PHP versions and NVM
- [1Password](https://1password.com) with the SSH agent enabled — used for commit signing

## Installation

```bash
git clone git@github.com:nissicreative/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script creates symlinks from your home directory into the repo, so any edits you make inside `~/dotfiles` take effect immediately without re-running the script.

### What gets symlinked

| Symlink                               | Source                             |
| ------------------------------------- | ---------------------------------- |
| `~/.zshrc`                            | `zsh/zshrc`                        |
| `~/.oh-my-zsh/custom/aliases.zsh`     | `zsh/aliases.zsh`                  |
| `~/.gitconfig`                        | `git/gitconfig`                    |
| `~/.gitignore_global`                 | `git/gitignore_global`             |
| `~/.claude/CLAUDE.md`                 | `claude/CLAUDE.md`                 |
| `~/.claude/laravel-php-guidelines.md` | `claude/laravel-php-guidelines.md` |
| `~/.claude/settings.json`             | `claude/settings.json`             |
| `~/.claude/skills`                    | `claude/skills/`                   |
| `~/.config/tinkerwell/themes/*.json`  | `tinkerwell/themes/*.json`         |

## Local Overrides

Machine-specific config (name, email, signing key, etc.) belongs in `~/.gitconfig.local`. This file is included by `git/gitconfig` but is gitignored so it never ends up in the repo.

Example `~/.gitconfig.local`:

```ini
[user]
    name = Mike Folsom
    email = mike@example.com
    signingkey = ssh-ed25519 AAAA...
```

Any file matching `*.local` is gitignored at the repo level for the same reason.

## Adding New Dotfiles

1. Create a directory for the app if one doesn't exist (e.g. `ssh/`)
2. Add the config file to that directory
3. Add a `ln -sf` line to `install.sh`
4. Re-run `./install.sh`

## Alias Reference

### System

| Alias        | Command                                  |
| ------------ | ---------------------------------------- |
| `cpwd`       | Copy current directory path to clipboard |
| `flushdns`   | Flush DNS cache                          |
| `dskill`     | Delete all `.DS_Store` files recursively |
| `dockspacer` | Add a spacer to the Dock                 |
| `brewup`     | Update, upgrade, and clean Homebrew      |

### PHP / Composer

| Alias  | Command                         |
| ------ | ------------------------------- |
| `pu`   | `herd php ./vendor/bin/phpunit` |
| `pest` | `herd php ./vendor/bin/pest`    |
| `hp`   | `herd php`                      |
| `cr`   | `herd composer require`         |
| `ci`   | `herd composer install`         |
| `cu`   | `herd composer update`          |
| `cgu`  | `herd composer global update`   |
| `cda`  | `herd composer dump-autoload`   |

### Laravel / Artisan

| Alias  | Command                                  |
| ------ | ---------------------------------------- |
| `a`    | `herd php artisan`                       |
| `pint` | `herd php ./vendor/bin/pint`             |
| `aoc`  | `herd php artisan optimize:clear`        |
| `avp`  | `herd php artisan vendor:publish`        |
| `mfs`  | `herd php artisan migrate:fresh --seed`  |

### NPM

| Alias      | Command                                                 |
| ---------- | ------------------------------------------------------- |
| `nrd`      | `npm run dev`                                           |
| `nrw`      | `npm run watch`                                         |
| `nrb`      | `npm run build`                                         |
| `nrp`      | `npm run prod`                                          |
| `nrh`      | `npm run hot`                                           |
| `npmclear` | Remove `node_modules`, `package-lock.json`, clear cache |

### Git

| Alias  | Command                                         |
| ------ | ----------------------------------------------- |
| `gnew` | Init repo, stage all, prompt for commit message |
| `gt`   | Open in Tower                                   |
| `nah`  | Hard reset + clean untracked files              |

### Navigation

| Alias | Destination |
| ----- | ----------- |
| `si`  | `~/Sites`   |
| `co`  | `~/Code`    |
| `db`  | `~/Dropbox` |

## Claude CLI

The `claude/` directory manages configuration for [Claude Code](https://claude.ai/code).

| File                        | Purpose                                                                    |
| --------------------------- | -------------------------------------------------------------------------- |
| `CLAUDE.md`                 | Global instructions for Claude — personal preferences, development context |
| `laravel-php-guidelines.md` | Laravel/PHP-specific coding standards, included by `CLAUDE.md`             |
| `settings.json`             | Allowed commands, MCP servers, and other Claude CLI settings               |
| `skills/`                   | Custom slash command skills (e.g. `/stage`)                                |

To update Claude's behavior, edit the files in `claude/` directly — they're symlinked so changes apply immediately.

## Tinkerwell

The `tinkerwell/themes/` directory stores custom themes for [Tinkerwell](https://tinkerwell.app). Each `.json` file is symlinked into `~/.config/tinkerwell/themes/` by `install.sh`.

To add a new theme, drop the `.json` file into `tinkerwell/themes/` and re-run `./install.sh` — or symlink it manually:

```bash
ln -sf ~/dotfiles/tinkerwell/themes/mytheme.json ~/.config/tinkerwell/themes/mytheme.json
```

Themes appear in Tinkerwell under **Settings → Themes** after restarting the app.
