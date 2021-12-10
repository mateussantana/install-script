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
EMOJI_REFRESH=`printf '\U1F504\n'`
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

# Script information
printf "\n"
printf "╔═════════════════════════════════════════════════════╗\n"
printf "║        %s♣%s WELCOME TO MY INSTALLATION SCRIPT %s♣%s        ║\n" ${BOLD}${RED} ${RESET}${BOLD} ${RED} $RESET
printf "║                                                     ║\n"
printf "║ This script will do the following tasks:            ║\n"
printf "║  → Install %sGit%s                                      ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sDocker%s & %sdocker-compose%s                  ║\n" ${BOLD}${GREEN} $RESET ${BOLD}${GREEN} $RESET
printf "║  → Install %sNgrok%s                                    ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sZSH%s                                      ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sOhMyZsh%s                                  ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sOhMyZsh theme%s                            ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sOhMyZsh plugins%s                          ║\n" ${BOLD}${GREEN} $RESET
printf "╚═════════════════════════════════════════════════════╝\n"

# Confirm to proceed
echo -n "${YELLOW}Are you want to proceed? ${RESET}(y/n) "
read ANSWER
if [[ ! $ANSWER =~ ^[yY]$ ]]; then
    echo "Ok. Aborted!"
    exit 0
else
    echo ""
fi

# Confirm sudo privileges
sudo -v
if [ $? -ne 0 ]; then
    echo "$EMOJI_ERROR ${RED}You need sudo privileges.${RESET}"
    echo "Aborted!"
    exit 1
else
    echo ""
fi

# Update and install dependencies
CMD='sudo apt-get update && sudo apt-get install curl -y'
echo "${GREEN}${CMD}${RESET}"
eval $CMD || exit 2
echo ""

# Git
if  $(git --version > /dev/null 2>&1); then
    printf "%s Git is already installed\n" $EMOJI_SUCCESS
else
    printf "%s Installing %sGit%s...\n" $EMOJI_GIT $GREEN $RESET
    CMD='sudo apt-get install git -y'
    echo "${GREEN}${CMD}${RESET}"
    $CMD || exit 2
    echo ""
fi

# Docker & Docker-compose
if  $(docker --version > /dev/null 2>&1); then
    printf "%s Docker is already installed\n" $EMOJI_DOCKER
else
    printf "%s Installing %sDocker%s...\n" $EMOJI_DOCKER $GREEN $RESET
    CMD='curl -fsSL https://get.docker.com -o /tmp/get-docker.sh'
    echo "${GREEN}${CMD}${RESET}"
    $CMD || exit 2
    CMD='sudo sh /tmp/get-docker.sh'
    echo "${GREEN}${CMD}${RESET}"
    $CMD || exit 2
    CMD='sudo groupadd docker && sudo usermod -aG docker $USER'
    echo "${GREEN}${CMD}${RESET}"
    #$CMD || exit 2
    CMD='sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose'
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD || exit 2
    CMD='sudo chmod +x /usr/local/bin/docker-compose'
    echo "${GREEN}${CMD}${RESET}"
    $CMD || exit 2
fi

# Ngrok
if  $(ngrok --version > /dev/null 2>&1); then
    printf "%s Ngrok is already installed\n" $EMOJI_NGROK
else
    printf "%s Installing %sNgrok%s...\n" $EMOJI_NGROK $GREEN $RESET
    CMD='curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null &&
              echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list &&
              sudo apt update && sudo apt install ngrok'
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD || exit 2
    echo ""
fi

# Final warnings
printf "%s%s Some final advices: ngrok authtoken <token>...\n" $EMOJI_WARNING $YELLOW $RESET

exit 0;
