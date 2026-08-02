# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Just offer a reminder every few days, if there are updates available:
zstyle ':omz:update' mode reminder

# Path to your oh-my-zsh installation.
export ZSH="/Users/gv1d/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git history-substring-search rails bundler)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# -----------------------------------------------------------------------------
# Personal shell setup (ported from ~/.dotfiles/bashrc)
# -----------------------------------------------------------------------------

# Keep existing toolchains available in zsh.
path=(
  "$HOME/.bin"
  "/usr/local/opt/tomcat@7/bin"
  "/usr/local/opt/qt@5.5/bin"
  "/usr/local/opt/icu4c/bin"
  "/usr/local/opt/icu4c/sbin"
  "$HOME/Library/Python/2.7/bin"
  "/usr/local/opt/ruby/bin"
  "$HOME/.cargo/bin"
  "/usr/local/sbin"
  "$HOME/.rbenv/bin"
  "/usr/local/opt/redis@6.2/bin"
  "$HOME/.bun/bin"
  "$HOME/.bum/bin"
  "$HOME/.local/bin"
  "/Users/gv1d/.kimi-code/bin"
  $path
)
export PATH

export GOPATH="$HOME/.go"
export home_bin_path="$HOME/.bin"
export BUN_INSTALL="$HOME/.bun"
export BUM_INSTALL="$HOME/.bum"
export GOTMPDIR="$HOME/.cache/go-build-tmp"
export YVM_DIR="/usr/local/opt/yvm"
export EDITOR='nvim'
export CLICOLOR=1
export LSCOLORS='ExFxBxDxCxegedabagacad'
export LANG='en_US.UTF-8'
export LC_CTYPE='UTF-8'
unset LC_ALL
export GREP_OPTIONS='--color=auto'
export STORM_HOME="$HOME/.bin/apache-storm-0.9.3"
export DISABLE_SPRING=true

if (( $+commands[brew] )) && brew list openssl@1.1 &>/dev/null; then
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
fi

# Environment managers. Initialize only when installed.
if (( $+commands[nodenv] )); then
  eval "$(nodenv init - zsh)"
fi

if [[ -x /usr/local/bin/rbenv ]]; then
  eval "$(rbenv init - zsh)"
fi

if [[ -r "$YVM_DIR/yvm.sh" ]]; then
  source "$YVM_DIR/yvm.sh"
fi

if (( $+commands[npm] )); then
  npm_bin="$(npm config get prefix 2>/dev/null)/bin"
  [[ -d "$npm_bin" ]] && path=("$npm_bin" $path)
  export PATH
  unset npm_bin
fi

if [[ -t 1 ]]; then
  export GPG_TTY="$(tty)"
fi

# Existing aliases.
alias gp='cd ~/Projects'
alias gpw='cd ~/Projects/wasp'
alias chrome='/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome'
alias ff='/Applications/Firefox.app/Contents/MacOS/firefox -p default-profile --browser &'
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
setopt SHARE_HISTORY

HISTFILE="$HOME/.zsh_history"
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

# Compact prompt: keep the project path, omit git status, and show a runtime
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
    if (( $+commands[rbenv] )); then
      version="$(rbenv version-name 2>/dev/null)"
    elif (( $+commands[ruby] )); then
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
    if (( $+commands[nodenv] )); then
      version="$(nodenv version-name 2>/dev/null)"
    elif (( $+commands[node] )); then
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
