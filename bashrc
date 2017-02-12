# my .bin directory  -----------------------------------------------------------
export PATH="$HOME/.bin:$PATH";
# macports ---------------------------------------------------------------------
export PATH="/opt/local/bin:/opt/local/sbin:$PATH";
# MySQL ------------------------------------------------------------------------
export PATH="/usr/local/mysql/bin:/usr/local/bin:$PATH:$HOME/.src/RDSCli-1.15.001/bin"
export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"
#unset LD_LIBRARY_PATH    #fix for sudo warning with _dyld not defined
#unset DYLD_LIBRARY_PATH  #fix for sudo warning with _dyld not defined
# Added by the Heroku Toolbelt -------------------------------------------------
export PATH="/usr/local/heroku/bin:$PATH"
# macports: postgres 9.3 -------------------------------------------------------
export PATH="/opt/local/lib/postgresql93/bin:$PATH";
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
# macports: bash-completion ---------------------------------------------------
if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
fi
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi
# git compleatoin -------------------------------------------------------------
export home_bin_path="$HOME/.bin"
[[ -r $home_bin_path/git-completion.bash ]] && . $home_bin_path/git-completion.bash
# heroku completion -----------------------------------------------------------
[[ -r $home_bin_path/heroku_bash_completion.sh ]] && . $home_bin_path/heroku_bash_completion.sh
# etc -------------------------------------------------------------------------
export EDITOR='mvim'
export CLICOLOR=1;
export LSCOLORS=GxFxCxDxBxegedabagaced;
export LC_ALL=$LANG
export LC_CTYPE="UTF-8"
export LANG="en_US.UTF-8"
export GREP_OPTIONS='--color=auto'
export STORM_HOME="$HOME/.bin/apache-storm-0.9.3"
# add rvm to path -------------------------------------------------------------
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
