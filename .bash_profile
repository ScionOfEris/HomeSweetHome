# set path
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:${HOME}/bin


# WINDOWS does weird things... a new shell is not a login shell, so gets no profile
# so... to make stuff agnostic, doing this:

BASH_PROFILE=true
export BASH_PROFILE
if [ "$BASHRC" != 'true' ] ; then
  . ~/.bashrc
fi

# lets use vi style shell
# hmm... not sure....
#set -o vi


# tmux does odd stuff.  I thought this needed to be in bashrc, but apparently it
# needs to be here.

# If we're a bastion, set up fancy bastion stuff
if [ -f ~/.bastion ] ; then
  . ~/.bastionrc
  . ~/.bashrc
fi


echo running .bash_profile
