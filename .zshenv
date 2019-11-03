if [ "$ZDOTDIR" != "$HOME/.zsh" ]; then
  export ZDOTDIR="$HOME/.zsh"
  . $ZDOTDIR/.zshenv
fi
