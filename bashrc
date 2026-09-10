# Keep Bash usable for scripts and compatibility; zsh is the primary shell.

if command -v brew >/dev/null 2>&1; then
  brew_prefix="$(brew --prefix)"
  export PATH="$brew_prefix/bin:$brew_prefix/sbin:$PATH"
  unset brew_prefix
fi

export PATH="$HOME/.bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export GOPATH="$HOME/.go"
export EDITOR='nvim'
export DISABLE_SPRING=true

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi

[[ -r "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"
