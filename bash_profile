# Source .bashrc if exists
[[ -r $HOME/.bashrc ]] && . $HOME/.bashrc

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init -)"
