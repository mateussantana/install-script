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
EMOJI_SUCCESS=✅
EMOJI_ERROR=🚫
EMOJI_WARNING=⚠
EMOJI_REFRESH=🔄
EMOJI_GIT=🔀
EMOJI_DOCKER=🐳
EMOJI_NGROK=🆖
EMOJI_ZSH=🖥
EMOJI_OMZ=🧙
EMOJI_PHP=🐘
EMOJI_COMPOSER=🪄

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
printf "║  → Install %sPHP 8%s                                    ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sComposer%s                                 ║\n" ${BOLD}${GREEN} $RESET
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
fi

# Update and install dependencies
echo ""
CMD='sudo apt-get update'
echo "${GREEN}${CMD}${RESET}"
$CMD || exit 2
CMD='sudo apt-get install software-properties-common curl fonts-firacode -y'
echo "${GREEN}${CMD}${RESET}"
$CMD || exit 2
echo ""

# Git
if $(git --version > /dev/null 2>&1); then
    printf "%s Git is already installed\n" $EMOJI_SUCCESS
else
    printf "%s Installing %sGit%s...\n" $EMOJI_GIT $GREEN $RESET
    CMD='sudo apt-get install git -y'
    echo "${GREEN}${CMD}${RESET}"
    $CMD || exit 2
    echo ""
fi

# Docker & Docker-compose
if $(docker --version > /dev/null 2>&1); then
    printf "%s Docker is already installed\n" $EMOJI_SUCCESS
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
    echo ""
fi

# Ngrok
if $(ngrok --version > /dev/null 2>&1); then
    printf "%s Ngrok is already installed\n" $EMOJI_SUCCESS
else
    printf "%s Installing %sNgrok%s...\n" $EMOJI_NGROK $GREEN $RESET
    CMD='curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && '
    CMD+='echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && '
    CMD+='sudo apt update && sudo apt install ngrok'
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD || exit 2
    echo ""
fi

# ZSH
if $(zsh --version > /dev/null 2>&1); then
    printf "%s ZSH is already installed\n" $EMOJI_SUCCESS
else
    printf "%s Installing %sZSH%s...\n" $EMOJI_ZSH $GREEN $RESET
    CMD='sudo apt-get install zsh -y'
    echo "${GREEN}${CMD}${RESET}"
    $CMD || exit 2
    echo ""
fi

# Oh-My-Zsh
if [ -d $HOME/.oh-my-zsh ]; then
    printf "%s OhMyZsh is already installed\n" $EMOJI_SUCCESS
else
    printf "%s Installing %sOhMyZsh%s...\n" $EMOJI_OMZ $GREEN $RESET
    CMD='sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD || exit 2
    echo ""
fi

# Oh-My-Zsh theme

# Oh-My-Zsh plugins

# PHP 8.1
if $(php --version > /dev/null 2>&1); then
    printf "%s PHP is already installed\n" $EMOJI_SUCCESS
else
    printf "%s Installing %sPHP%s...\n" $EMOJI_PHP $GREEN $RESET
    CMD='sudo add-apt-repository ppa:ondrej/php -y'
    echo "${GREEN}${CMD}${RESET}" 
    $CMD || exit 2
    CMD='sudo apt-get install php8.1-cli -y'
    echo "${GREEN}${CMD}${RESET}" 
    $CMD || exit 2
    echo ""
fi

# Composer
if $(composer -V > /dev/null 2>&1); then
    printf "%s Composer is already installed\n" $EMOJI_SUCCESS
else
    printf "%s Installing %sComposer%s...\n" $EMOJI_COMPOSER $GREEN $RESET
    CMD="php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\""
    echo "${GREEN}${CMD}${RESET}" 
    eval $CMD || exit 2
    EXPECTED_CHECKSUM=$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')
    ACTUAL_CHECKSUM=$(php -r "echo hash_file('sha384', 'composer-setup.php');")
    if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
        >&2 echo 'ERROR: Invalid installer checksum'
        rm composer-setup.php
        exit 3
    fi
    CMD='sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer'
    echo "${GREEN}${CMD}${RESET}" 
    $CMD || (rm composer-setup.php && exit 2)
    rm composer-setup.php
    echo ""
fi

# Final adjustments
echo -n "${YELLOW}Do you want to change your default shell to zsh? ${RESET}(y/n) "
read ANSWER
if [[ $ANSWER =~ ^[yY]$ ]]; then
    CMD='chsh -s $(which zsh)'
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD || echo "$EMOJI_ERROR ${RED}I can't change your default shell automatically. You will need to do it manually!${RESET}"
    echo ""
fi

# Final warnings
printf "%s%s Some final advices: ngrok authtoken <token>...%s\n" $EMOJI_WARNING $YELLOW $RESET

exit 0;
