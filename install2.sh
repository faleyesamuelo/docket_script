#!/bin/bash

# Backup current .bash_profile
cp ~/.bash_profile ~/.bash_profile.bak

# Modify the PS1 prompt
echo "Modifying PS1 to change terminal prompt appearance..."

# Set the new PS1 prompt with colors
echo "PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\[\033[00m\] $ '" >> ~/.bash_profile

# Reload .bash_profile to apply changes
source ~/.bash_profile

echo "Bash prompt has been updated!"
