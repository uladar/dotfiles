# my .bin directory  -----------------------------------------------------------
export PATH="$HOME/.bin:$PATH";
export GOPATH="$HOME/.go";
# MySQL ------------------------------------------------------------------------
#export PATH="/usr/local/mysql/bin:/usr/local/bin:$PATH:$HOME/.src/RDSCli-1.15.001/bin"
# Load the shell dotfiles, and then some: --------------------------------------
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
# Fixing not found ncursesw while ncmpcpp compiling ----------------------------
#export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
# set a fancy prompt (non-color, unless we know we "want" color) ---------------
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi
if [ "$color_prompt" = yes ]; then
  # TODO: check rvm and rbenv version
  # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\][$(~/.rvm/bin/rvm-prompt)] \u\[\033[00m\]:\[\033[01;34m\]\W$(__git_ps1 " (%s)")\[\033[00m\]\$ '
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\][$(rbenv version-name)] \u\[\033[00m\]:\[\033[01;34m\]\W$(__git_ps1 " (%s)")\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
# COMPLETION ------------------------------------------------------------------
export home_bin_path="$HOME/.bin"
# git-completion -------------------------------------------------------------
[[ -r $home_bin_path/git-completion.bash ]] && . $home_bin_path/git-completion.bash
# heroku completion -----------------------------------------------------------
#[[ -r $home_bin_path/generate_heroku_commands_and_options.sh ]] && . $home_bin_path/generate_heroku_commands_and_options.sh
#[[ -r $home_bin_path/generate_heroku_aliases.sh ]] && . $home_bin_path/generate_heroku_aliases.sh
#[[ -r $home_bin_path/heroku_bash_completion.sh ]] && . $home_bin_path/heroku_bash_completion.sh
# bash-completion
[[ -r $home_bin_path/bash-completion.bash ]] && . $home_bin_path/bash-completion.bash
# brew bash-completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
# etc -------------------------------------------------------------------------
export EDITOR='vim'
export CLICOLOR=1;
#export LSCOLORS=GxFxCxDxBxegedabagaced;
export LSCOLORS=ExFxBxDxCxegedabagacad
export LC_ALL=$LANG
export LC_CTYPE="UTF-8"
export LANG="en_US.UTF-8"
export GREP_OPTIONS='--color=auto'
export STORM_HOME="$HOME/.bin/apache-storm-0.9.3"
GPG_TTY=$(tty)
export GPG_TTY
# aliases ---------------------------------------------------------------------
alias gp="cd ~/Projects"
alias gpw="cd ~/Projects/wasp"
# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
# Google Chrome
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias ff='/Applications/Firefox28.app/Contents/MacOS/firefox -p default-profile --browser &'
# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "$method"="lwp-request -m '$method'"
done
# Print each PATH entry on a separate line ------------------------------------
alias path='echo -e ${PATH//:/\\n}'
# add nodenv to path ----------------------------------------------------------
eval "$(nodenv init -)"
# Installing Qt and compiling capybara webkit ---------------------------------
# https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit#macos-high-sierra-1013-macos-sierra-1012-el-capitan-1011-and-yosemite-1010
#export PATH="$(brew --prefix qt@5.5)/bin:$PATH"
# export missing brew directory
export PATH="/usr/local/sbin:$PATH"

#docker env
#export DOCKER_TLS_VERIFY="1"
#export DOCKER_HOST="tcp://192.168.99.100:2376"
#export DOCKER_CERT_PATH="/Users/vladi/.docker/machine/machines/default"
#export DOCKER_MACHINE_NAME="default"
# Run this command to configure your shell:
#eval $(docker-machine env)

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/Users/vladi/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;
export PATH="/usr/local/opt/tomcat@7/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
