# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# not sure if I want this, but leaving for now
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# swilson edits:
# (although I did cut a bunch of stuff out of above this....)

umask 022
EDITOR=/usr/bin/vim ; export EDITOR
PAGER=less ; export PAGER


# HISTORY STUFF

# this makes bash act like zsh for multi-line stuff in history:
shopt -s lithist

# append to the history file, don't overwrite it
shopt -s histappend

HISTSIZE=100000
HISTFILESIZE=100000

if [ ! -d ~/.histories ] ; then
  mkdir ~/.histories
fi

# root gets special history files
if [ "$UID" == '0' ] ; then
  HISTFILE=/home/swilson/.histories/ROOT-`date '+%Y-%m-%d'`-$$
else
  HISTFILE=/home/swilson/.histories/`date '+%Y-%m-%d'`-$$
fi


# WINDOWS does weird things... a new shell is not a login shell, so gets no profile
# so... to make stuff agnostic, doing this:

BASHRC=true
export BASHRC
if [ "$BASH_PROFILE" != 'true' ] ; then
  # this is only needed on Windows boxes, as otherwise new shells don't run it
  if [ -n "`uname -a | grep -i microsoft`" ] ; then
    . ~/.bash_profile
    # also, move me to my homedir, since MS starts me somewehre odd
    cd ~

    # and cuz this works:
    DISPLAY=:0  ; export DISPLAY
    # needs Xming running to work though
  fi
fi


# Prompts:
if [ "$UID" == '0' ] ; then
  PS1='< \[\e[1m\]\h \[\e[0m\]\[\e[7m\]ROOT\[\e[27m\] \W \[\e[7m\]>>\[\e[27m\]'
else
  PS1='< \[\e[1m\]\h \[\e[0m\]\W \[\e[7m\]>>\[\e[27m\] '
fi


# aliases
. ~/.bash_aliases

# If we're a bastion, set up fancy bastion stuff
if [ -f ~/.bastion ] ; then
  . ~/.bastionrc
fi

echo running .bashrc


