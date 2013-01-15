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

# Set network proxy

#!/bin/sh
export http_proxy="http://www-proxy.us.oracle.com:80"
export https_proxy=$http_proxy
export no_proxy="localhost, 127.0.0.1"
