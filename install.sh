#!/bin/bash

SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

ln -sf "$SCRIPT_DIR/nvim" ~/.config/
ln -sf "$SCRIPT_DIR/lf" ~/.config/
ln -sf "$SCRIPT_DIR/tmux/tmux.conf" ~/.tmux.conf
ln -sf "$SCRIPT_DIR/zsh/zshrc" ~/.zshrc.local

echo "add 'source $HOME/.zshrc.local' to your .zshrc!"
