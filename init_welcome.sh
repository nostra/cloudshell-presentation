#!/bin/sh

# Disable apt-get installation warning about vm being ephemeral
mkdir -p ~/.cloudshell/
touch ~/.cloudshell/no-apt-get-warning

echo "Init-welcome script, running as $LOGNAME"
echo "Consider: chsh -s `which zsh` $LOGNAME"
