# my .bin directory  -----------------------------------------------------------
export PATH="$HOME/.bin:$PATH";
# macports ---------------------------------------------------------------------
export PATH="/opt/local/bin:/opt/local/sbin:/opt/local/lib:$PATH";
# MySQL ------------------------------------------------------------------------
export PATH="/usr/local/mysql/bin:/usr/local/bin:$PATH:$HOME/.src/RDSCli-1.15.001/bin"
#export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"
#unset LD_LIBRARY_PATH    #fix for sudo warning with _dyld not defined
#unset DYLD_LIBRARY_PATH  #fix for sudo warning with _dyld not defined
# Added by the Heroku Toolbelt -------------------------------------------------
export PATH="/usr/local/heroku/bin:$PATH"
# macports: postgres 9.3 -------------------------------------------------------
export PATH="/opt/local/lib/postgresql95/bin:$PATH";
export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/";
# Load the shell dotfiles, and then some: --------------------------------------
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
export PATH="$PATH:/opt/local/libexec/qt5/bin/";
# Fixing not found ncursesw while ncmpcpp compiling.
export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"
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
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\][$(~/.rvm/bin/rvm-prompt)] \u\[\033[00m\]:\[\033[01;34m\]\W$(__git_ps1 " (%s)")\[\033[00m\]\$ '
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
#[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
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
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
# add nodenv to path
eval "$(nodenv init -)"
# add rvm to path -------------------------------------------------------------
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
