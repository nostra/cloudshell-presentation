#!/bin/sh

# Disable apt-get installation warning about vm being ephemeral
touch ~/.cloudshell/no-apt-get-warning

echo "Init-welcome script, running as $LOGNAME"
