# Oh My Zsh
zstyle ':omz:update' mode reminder
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git history-substring-search rails bundler)
source $ZSH/oh-my-zsh.sh

# Personal shell setup for Apple Silicon

# PATH and toolchains. Resolve Homebrew dynamically so this works with the
# native /opt/homebrew installation on Apple Silicon.
if (( $+commands[brew] )); then
  brew_prefix="$(brew --prefix)"
  path=("$brew_prefix/bin" "$brew_prefix/sbin" $path)
  unset brew_prefix
fi

path=(
  "$HOME/.bin"
  "$HOME/.cargo/bin"
  "$HOME/.bun/bin"
  "$HOME/.bum/bin"
  "$HOME/.local/bin"
  "$HOME/.kimi-code/bin"
  $path
)
export PATH

export GOPATH="$HOME/.go"
export home_bin_path="$HOME/.bin"
export BUN_INSTALL="$HOME/.bun"
export BUM_INSTALL="$HOME/.bum"
export GOTMPDIR="$HOME/.cache/go-build-tmp"
export TMPDIR="$HOME/.cache/tmp"
mkdir -p "$GOTMPDIR" "$TMPDIR"
export EDITOR='nvim'
export CLICOLOR=1
export LSCOLORS='ExFxBxDxCxegedabagacad'
export LANG='en_US.UTF-8'
export LC_CTYPE='UTF-8'
unset LC_ALL
export GREP_OPTIONS='--color=auto'
export STORM_HOME="$HOME/.bin/apache-storm-0.9.3"
export DISABLE_SPRING=true

# Runtime manager. mise reads .tool-versions, .ruby-version and .node-version
# while preserving the existing per-project version files.
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

# Search shell history interactively and optionally sync it between machines.
if (( $+commands[atuin] )); then
  eval "$(atuin init zsh)"
fi

if [[ -t 1 ]]; then
  export GPG_TTY="$(tty)"
fi

# Existing aliases.
alias gp='cd ~/Projects'
alias gpw='cd ~/Projects/wasp'
alias chrome='/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome'
alias ff='/Applications/Firefox.app/Contents/MacOS/firefox -p default-profile --browser &'
alias vi='nvim'
alias vim='nvim'
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias dbe='dotenv bundle exec'

timer() {
  echo 'Timer started. Stop with Ctrl-D.'
  date
  time cat
  date
}

path() {
  print -l ${(s.:.)PATH}
}

for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done

# -----------------------------------------------------------------------------
# Fish-like conveniences
# -----------------------------------------------------------------------------

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

if [[ -n "$TMUX_PANE" ]]; then
  HISTFILE="$HOME/.zsh_history_tmux_${TMUX_PANE//[^A-Za-z0-9_-]/_}"
else
  HISTFILE="$HOME/.zsh_history"
fi
HISTSIZE=100000
SAVEHIST=100000

# Case-insensitive and menu-based completion.
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

autoload -Uz compinit
compinit
zmodload -i zsh/complist

# Reuse Oh My Zsh's static Rails completion for the local application binstub.
# This avoids booting Rails every time completion is triggered.
compdef _rails bin/rails

# Complete SSH aliases from ~/.ssh/config before falling back to known_hosts.
_ssh_hosts() {
  local -a config_hosts known_hosts

  config_hosts=("${(@f)$(awk '
    tolower($1) == "host" {
      for (i = 2; i <= NF; i++)
        if ($i !~ /[*?]/) print $i
    }
  ' "$HOME/.ssh/config" 2>/dev/null)}")

  known_hosts=("${(@f)$(awk '
    {
      count = split($1, names, ",")
      for (i = 1; i <= count; i++)
        if (names[i] !~ /^\|/ && names[i] !~ /^\[/) print names[i]
    }
  ' "$HOME/.ssh/known_hosts" 2>/dev/null)}")

  config_hosts+=("${known_hosts[@]}")
  config_hosts=(${(u)config_hosts})

  compadd -M 'm:{a-zA-Z}={A-Za-z} r:|.=* r:|=*' "$@" $config_hosts
}

# Keep Heroku completion, using its zsh setup when available.
HEROKU_AC_ZSH_SETUP_PATH="$HOME/Library/Caches/heroku/autocomplete/zsh_setup"
if [[ -r "$HEROKU_AC_ZSH_SETUP_PATH" ]]; then
  source "$HEROKU_AC_ZSH_SETUP_PATH"
fi
unset HEROKU_AC_ZSH_SETUP_PATH

# fzf gives fish-like history/file/directory pickers:
# Ctrl-R = history, Ctrl-T = files, Alt-C = directories.
# Interactive helpers
if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"

  # Keep fzf widgets, but let zsh handle normal Tab completion.
  bindkey -M emacs '^I' expand-or-complete
  bindkey -M viins '^I' expand-or-complete
  bindkey -M vicmd '^I' expand-or-complete
fi

mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}

alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias reload-zsh='source ~/.zshrc'

# Prompt: keep the project path, omit git status, and show a runtime
# only when the current project declares that runtime.
prompt_theme_color() {
  local theme_file="$1"
  local section="$2"
  local key="$3"
  local value

  value="$(awk -v section="[colors.$section]" -v key="$key" '
    $0 == section { inside = 1; next }
    /^\[/ { inside = 0 }
    inside && $1 == key { gsub(/"/, "", $3); print $3; exit }
  ' "$theme_file")"

  [[ "$value" == \#?????? ]] && print -r -- "$value"
}

prompt_refresh_theme() {
  local config="$HOME/.config/alacritty/alacritty.toml"
  local theme_file

  theme_file="$(awk -F'"' '/^import[[:space:]]*=/ { print $2; exit }' "$config")"
  [[ -n "$theme_file" ]] || return
  theme_file="${theme_file/#\~/$HOME}"
  [[ -r "$theme_file" ]] || return

  PROMPT_THEME_PATH="$(prompt_theme_color "$theme_file" normal blue)"
  PROMPT_THEME_BRANCH="$(prompt_theme_color "$theme_file" normal green)"
  PROMPT_THEME_RUNTIME="$(prompt_theme_color "$theme_file" normal yellow)"
  PROMPT_THEME_ERROR="$(prompt_theme_color "$theme_file" bright red)"
  PROMPT_THEME_FOREGROUND="$(prompt_theme_color "$theme_file" primary foreground)"

  : ${PROMPT_THEME_PATH:=#03a9f4}
  : ${PROMPT_THEME_BRANCH:=#8bc34a}
  : ${PROMPT_THEME_RUNTIME:=#ffc107}
  : ${PROMPT_THEME_ERROR:=#ffa74d}
  : ${PROMPT_THEME_FOREGROUND:=#eceff1}

  PROMPT='$(prompt_runtime_versions)%F{'"$PROMPT_THEME_PATH"'}%1~%f$(prompt_git_branch) %(?..%F{'"$PROMPT_THEME_ERROR"'}✗%f )%F{'"$PROMPT_THEME_FOREGROUND"'}%(!.#.$)%f '
}

prompt_project_file() {
  local directory="$PWD"
  local filename="$1"

  while true; do
    if [[ -e "$directory/$filename" ]]; then
      print -r -- "$directory/$filename"
      return 0
    fi
    [[ "$directory" == "/" ]] && break
    directory="${directory:h}"
  done

  return 1
}

prompt_runtime_versions() {
  local version marker

  if marker="$(prompt_project_file .ruby-version)"; then
    if (( $+commands[ruby] )); then
      version="$(ruby -e 'print RUBY_VERSION' 2>/dev/null)"
    fi
    if [[ -n "$version" && "$version" != system ]]; then
      print -n "%F{$PROMPT_THEME_RUNTIME}[ $version]%f "
      return
    fi
  fi

  version=''
  if marker="$(prompt_project_file mix.exs 2>/dev/null)"; then
    if (( $+commands[elixir] )); then
      version="$(elixir --short-version 2>/dev/null)"
    fi
    if [[ -n "$version" ]]; then
      print -n "%F{$PROMPT_THEME_RUNTIME}[ $version]%f "
      return
    fi
  fi

  version=''
  if marker="$(prompt_project_file .node-version 2>/dev/null)" || marker="$(prompt_project_file .nvmrc 2>/dev/null)"; then
    if (( $+commands[node] )); then
      version="$(node --version 2>/dev/null)"
    fi
    version="${version#v}"
    [[ -n "$version" && "$version" != system ]] && print -n "%F{$PROMPT_THEME_RUNTIME}[ $version]%f "
  fi
}

prompt_git_branch() {
  local branch

  (( $+commands[git] )) || return
  git rev-parse --is-inside-work-tree &>/dev/null || return

  branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)"
  [[ -n "$branch" ]] && print -n " %F{$PROMPT_THEME_BRANCH}($branch)%f"
}

setopt PROMPT_SUBST
precmd_functions+=(prompt_refresh_theme)
prompt_refresh_theme

# Keep Up/Down history local to the current tmux pane, while Ctrl-R searches
# every zsh history file (the shared history file and all tmux-pane files).
unsetopt SHARE_HISTORY

global_history_widget() {
  local selected
  local -a history_files

  history_files=(
    "$HOME"/.zsh_history(N)
    "$HOME"/.zsh_history_tmux_*(N)
  )

  (( ${#history_files} )) || return

  selected="$({
    for history_file in $history_files; do
      sed -E 's/^: [0-9]+:[0-9]+;//' "$history_file"
    done
  } | awk 'NF' | sort -u | fzf --height=40% --reverse --no-sort --query="$BUFFER")"

  [[ -n "$selected" ]] || return
  BUFFER="$selected"
  CURSOR=${#BUFFER}
  zle redisplay
}

zle -N global_history_widget
bindkey -M emacs '^R' global_history_widget
bindkey -M viins '^R' global_history_widget
