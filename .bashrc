alias ls='ls --color=auto'
alias open='gnome-open'
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/:\1/'
}

PS1='[\u@\h \W$(parse_git_branch)]\$ '
PS1='\[\033[01;34m\][\[\033[01;32m\]\u@\h\[\033[01;34m\] \W$(parse_git_branch)\[\033[01;34m\]]\$\[\033[00m\] '
export EDITOR="vim"
export PATH="$PATH:$HOME/bin"
export PYTHONPATH="."
. /etc/bash_completion
#export MANPATH="/usr/share/man:$MANPATH"
