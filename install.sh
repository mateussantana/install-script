#!/usr/bin/env bash

# ref: https://github.com/freekmurze/dotfiles/blob/main/installscript
# ref: https://github.com/freekmurze/dotfiles/blob/main/bootstrap
# ref: https://github.com/laravel/sail/blob/1.x/bin/sail

# Verify OS
if  [[ ! "$(uname -s)" =~ "Linux" ]]; then
    echo "Seems like you are not in a Linux environment."
    echo -n "Are you want to proceed anyway? (y/n) "
    read ANSWER
    echo ""

    if [[ ! $ANSWER =~ ^[yY]$ ]]; then
        echo "Aborted!"
        exit 0
    fi
fi

# Verify Ubuntu distribution
if  [[ ! "$(uname -v)" =~ "Ubuntu" ]]; then
    echo "Seems like you are not using a Ubuntu distribution. This script just was tested on Ubuntu."
    echo -n "Are you want to proceed anyway? (y/n) "
    read ANSWER
    if [[ ! $ANSWER =~ ^[yY]$ ]]; then
        echo "Aborted!"
        exit 0
    fi

    echo -n "Are you really sure? (y/n) "
    read ANSWER
    if [[ ! $ANSWER =~ ^[yY]$ ]]; then
        echo "Aborted!"
        exit 0
    fi

    echo ""
fi

# Confirm sudo privileges
sudo -v
if [ $? -ne 0 ]; then
    echo "You need sudo privileges. Aborted!"
    exit 1
fi

echo "Executing..."

# Confirm to proceed 
sudo apt-get update

# Install dependencies
