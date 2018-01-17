# set path
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/puppetlabs/bin:/opt/bin:${HOME}/bin


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

# If we're a bastion, but not root, set up fancy bastion stuff
if [ -f ~/.bastion -a "$UID" != '0' ] ; then
  . ~/.bastionrc
  . ~/.bashrc
fi


echo running .bash_profile
