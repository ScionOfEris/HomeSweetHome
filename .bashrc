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


# color stuff went wonky again.
# I got tmux happy by putting in .tmux.conf:
# set -g default-terminal "screen-256color"
# but ls colors are still a bit tough, so....

LS_COLORS='rs=0:di=1;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

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
  fi
fi

# other windows specific stuff
if [ -n "`uname -a | grep -i microsoft`" ] ; then
  DISPLAY=:0  ; export DISPLAY
  # needs Xming running to work though

  # also, move me to my homedir, since MS starts me somewehre odd
  cd ~
fi

# Prompts:
if [ "$UID" == '0' ] ; then
  PS1='< \[\e[1m\]\h\[\e[0m\] \[\e[7m\]ROOT\[\e(B\e[m\] \W \[\e[7m\]>>\[\e(B\e[m\] '
else
  PS1='< \[\e[1m\]\h\[\e[0m\] \W \[\e[7m\]>>\[\e(B\e[m\] '
fi

# AWS
AWS_REGION='us-east-1'
export AWS_REGION

# load up aliases, if any
if [ -f ~/.bash_aliases ] ; then
  . ~/.bash_aliases
fi

# except this alias... I always want this
alias susu='sudo -s HOME=$HOME'

# not getting my .bash_profile doing that.. so....
if [ "$UID" == '0' ] ; then
  if [ -z "$BASH_PROFILE" ] ; then
    . ~/.bash_profile
  fi
fi


echo running .bashrc


