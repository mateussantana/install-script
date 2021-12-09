#!/usr/bin/env bash

# ref: https://github.com/freekmurze/dotfiles/blob/main/installscript
# ref: https://github.com/freekmurze/dotfiles/blob/main/bootstrap
# ref: https://github.com/laravel/sail/blob/1.x/bin/sail
# ref: https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

# Setup colors
RED=`printf '\033[31m'`
GREEN=`printf '\033[32m'`
YELLOW=`printf '\033[33m'`
BLUE=`printf '\033[34m'`
BOLD=`printf '\033[1m'`
RESET=`printf '\033[m'`

# Setup emojis
EMOJI_SUCCESS=`printf '\U2705\n'`
EMOJI_ERROR=`printf '\U1F6A8\n'`
EMOJI_WARNING=`printf '\U26A0\n'`
EMOJI_MAGIC_WAND=`printf '\U1FA84\n'`
EMOJI_GIT=`printf '\U1F500\n'`
EMOJI_DOCKER=`printf '\U1F433\n'`
EMOJI_NGROK=`printf '\U1F196\n'`
EMOJI_ZSH=`printf '\U1F5A5\n'`
EMOJI_OMZ=`printf '\U1F9B8\n'`

# Verify OS
if  [[ ! "$(uname -s)" =~ "Linux" ]]; then
    echo "$EMOJI_ERROR ${RED}Seems like you are not in a Linux environment.${RESET}"
    echo "Aborted!"
    exit 1
fi

# Verify Ubuntu distribution
if  [[ ! "$(uname -v)" =~ "Ubuntu" ]]; then
    echo "$EMOJI_WARNING ${BLUE}Seems like you are not using a Ubuntu distribution. This script just was tested on Ubuntu.${RESET}"
    echo -n "${YELLOW}Are you want to proceed anyway? ${RESET}(y/n) "
    read ANSWER
    if [[ ! $ANSWER =~ ^[yY]$ ]]; then
        echo "Aborted!"
        exit 0
    fi

    echo -n "${YELLOW}Are you really sure? ${RESET}(y/n) "
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
    echo "$EMOJI_ERROR ${RED}You need sudo privileges.${RESET}"
    echo "Aborted!"
    exit 1
fi

# Confirm to proceed
echo ""
echo "+-----------------------------------------------------+"
echo "|       $EMOJI_MAGIC_WAND  WELCOME TO MY INSTALLATION SCRIPT $EMOJI_MAGIC_WAND        |"
echo "|                                                     |"
echo "| This script will do the following tasks:            |"
echo "|  $EMOJI_GIT Install Git                                     |"
echo "|  $EMOJI_DOCKER Install Docker & docker-compose                 |"
echo "|  $EMOJI_NGROK Install Ngrok                                   |"
echo "|  $EMOJI_ZSH  Install ZSH                                     |"
echo "|  $EMOJI_OMZ Install OhMyZsh                                 |"
echo "|  @ Install OhMyZsh theme                            |"
echo "|  @ Install OhMyZsh plugins                          |"
echo "+-----------------------------------------------------+"

# Git
if $(gits --version > /dev/null 2>&1); then
    echo "$EMOJI_SUCCESS Git is already installed"
else
    echo "$EMOJI_GIT Git is not installed!"
fi

echo "$EMOJI_GIT Executing..."
exit 0;

# Install dependencies
sudo apt-get update