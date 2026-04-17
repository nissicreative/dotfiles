#!/bin/bash

DOTFILES="$HOME/dotfiles"

echo "Creating symlinks..."

# ZSH
ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/aliases.zsh" "$HOME/.oh-my-zsh/custom/aliases.zsh"

# Git
ln -sf "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES/git/gitignore_global" "$HOME/.gitignore_global"

# Claude
ln -sf "$DOTFILES/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
ln -sf "$DOTFILES/claude/laravel-php-guidelines.md" "$HOME/.claude/laravel-php-guidelines.md"
ln -sf "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"
ln -sf "$DOTFILES/claude/skills" "$HOME/.claude/skills"

# Make personal scripts executable
chmod +x "$DOTFILES/bin/"*

echo "Done!"
