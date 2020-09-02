#!/bin/sh

# Disable apt-get installation warning about vm being ephemeral
mkdir -p ~/.cloudshell/
touch ~/.cloudshell/no-apt-get-warning

echo "Init-welcome script, running as $LOGNAME"
# As installation is done asynchronously, we might not have zsh yet
which zsh > /dev/null && echo "Consider: chsh -s `which zsh` $LOGNAME" || echo "Zsh is not installed yet"

# To install slimzsh for the first time:
# git clone --recursive https://github.com/changs/slimzsh.git ~/.slimzsh
