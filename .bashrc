#
# Bash initialization
#
# Rajesh Raheja
#

# Set git prompt
source ~/.git-completion.sh

# Switch to readable colors - bolden current directory path
# PS1='\[\033]0;$MSYSTEM:\w\007\033[32m\]\u@\h \[\033[33m\w$(__git_ps1)\033[0m\] $ '

PS1='\[\033]0;$MSYSTEM:\w\007\033[32m\]\u@\h \[\033[1;32m\w$(__git_ps1)\033[0m\] $ '

GIT_PS1_SHOWDIRTYSTATE="true"
GIT_PS1_SHOWSTASHSTATE="true"
GIT_PS1_SHOWUNTRACKEDFILES="true"
# GIT_PS1_SHOWUPSTREAM="auto"
# GIT_PS1_SHOWUPSTREAM="verbose"
