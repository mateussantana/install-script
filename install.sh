#!/usr/bin/env bash

# Check if is in a interactive mode
# If not, assumes yes for all confirmations
tty -s && TTY='yes'
[[ -z $TTY ]] && ANSWER='y'

# Setup colors
RED=`printf '\033[31m'`
GREEN=`printf '\033[32m'`
YELLOW=`printf '\033[33m'`
BLUE=`printf '\033[34m'`
BOLD=`printf '\033[1m'`
RESET=`printf '\033[m'`

# Setup emojis
EMOJI_SUCCESS=✅
EMOJI_ERROR=🔴
EMOJI_WARNING=🟡
EMOJI_WELCOME=🚀
EMOJI_DRACULA=🧛
EMOJI_REFRESH=🔄
EMOJI_GIT=🔀
EMOJI_DOCKER=🐳
EMOJI_NGROK=🆖
EMOJI_ZSH=🐚
EMOJI_TERMINATOR=🖥
EMOJI_OMZ=🧙
EMOJI_OMZ_THEME=🎭
EMOJI_OMZ_PLUGIN=🔌
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
    [[ -n $TTY ]] && read ANSWER
    if [[ ! $ANSWER =~ ^[yY]$ ]]; then
        echo "Aborted!"
        exit 0
    fi

    echo -n "${YELLOW}Are you really sure? ${RESET}(y/n) "
    [[ -n $TTY ]] && read ANSWER
    if [[ ! $ANSWER =~ ^[yY]$ ]]; then
        echo "Aborted!"
        exit 0
    fi
fi

# Script information
printf "\n"
printf "╔═════════════════════════════════════════════════════╗\n"
printf "║        %s %sWELCOME TO MY INSTALLATION SCRIPT%s %s      ║\n" $EMOJI_WELCOME $BOLD $RESET $EMOJI_WELCOME
printf "║                                                     ║\n"
printf "║ This script will do the following tasks:            ║\n"
printf "║  → Install some %ssystem dependencies%s                 ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sGit%s                                      ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sTerminator%s (with dracula theme)          ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sDocker%s & %sdocker-compose%s                  ║\n" ${BOLD}${GREEN} $RESET ${BOLD}${GREEN} $RESET
printf "║  → Install %sNgrok%s                                    ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sZSH%s                                      ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sOhMyZsh%s and %sspaceship theme%s              ║\n" ${BOLD}${GREEN} $RESET ${BOLD}${GREEN} $RESET
printf "║  → Install %sOhMyZsh plugins%s                          ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sPHP 8.1%s                                  ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Install %sComposer%s                                 ║\n" ${BOLD}${GREEN} $RESET
printf "║  → Set your default shell to %szsh%s                    ║\n" ${BOLD}${GREEN} $RESET
printf "╚═════════════════════════════════════════════════════╝\n"

# Confirm to proceed
echo -n "${YELLOW}Are you want to proceed? ${RESET}(y/n) "
[[ -n $TTY ]] && read ANSWER
if [[ ! $ANSWER =~ ^[yY]$ ]]; then
    echo "Ok. Aborted!"
    exit 0
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
CMD='sudo apt-get install -y software-properties-common curl fonts-firacode'
## Dependencies for Vitals gnome extension: https://github.com/corecoding/Vitals#installation
CMD+=' gir1.2-gtop-2.0 lm-sensors'
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

# Terminator
if which terminator > /dev/null 2>&1; then
    printf "%s Terminator is already installed\n" $EMOJI_SUCCESS
else
    printf "%s Installing %sTerminator%s...\n" $EMOJI_TERMINATOR $GREEN $RESET
    [[ -n $TTY ]] && CMD='sudo apt-get install terminator -y'
    [[ -z $TTY ]] && CMD='sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends terminator'
    echo "${GREEN}${CMD}${RESET}"
    $CMD || exit 2
    # Terminator custom config with dracula theme
    CMD='mkdir -p ~/.config/terminator && '
    if [ -f "terminator.config" ]; then
        CMD+='cp -rf terminator.config ~/.config/terminator/config'
    else
        CMD+='curl -fsSL https://raw.githubusercontent.com/mateussantana/install-script/master/terminator.config -o ~/.config/terminator/config'
    fi
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD || exit 2
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
    CMD='sudo groupadd docker; sudo usermod -aG docker $USER'
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD
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
ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"
ZSH_CUSTOM_THEME="${ZSH_CUSTOM}/themes/spaceship-prompt"
if [ -d $ZSH_CUSTOM_THEME ]; then
    printf "%s OhMyZsh custom theme is already installed\n" $EMOJI_SUCCESS
else
    printf "%s Installing OhMyZsh %sspaceship custom theme%s...\n" $EMOJI_OMZ_THEME $GREEN $RESET
    CMD="git clone https://github.com/denysdovhan/spaceship-prompt.git \"$ZSH_CUSTOM_THEME\""
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD || exit 2
    CMD="ln -s \"${ZSH_CUSTOM_THEME}/spaceship.zsh-theme\" \"$ZSH_CUSTOM/themes/spaceship.zsh-theme\""
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD
    CMD="sed -i '/^ZSH_THEME=/c\ZSH_THEME=\"spaceship\"' ~/.zshrc"
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD
    echo ""
fi

# Oh-My-Zsh plugins
if [ -d $HOME/.local/share/zinit/zinit.git ]; then
    printf "%s OhMyZsh zinit plugin is already installed\n" $EMOJI_SUCCESS
else
    # Setting up enabled plugins in .zshrc
    CMD="sed -i '/^plugins=/c\plugins=(git composer docker docker-compose mateussantana)' ~/.zshrc"
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD || exit 2
    # Zinit
    printf "%s Installing OhMyZsh %szinit plugin%s...\n" $EMOJI_OMZ_PLUGIN $GREEN $RESET
    CMD='sh -c "export NO_INPUT=yes; $(curl -fsSL https://git.io/zinit-install)"'
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD || exit 2
    # Syntax highlighting plugin
    echo "" >> $HOME/.zshrc
    CMD="echo 'zinit light zdharma-continuum/fast-syntax-highlighting' >> $HOME/.zshrc"
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD
    # Autosuggestions plugin
    CMD="echo 'zinit light zsh-users/zsh-autosuggestions' >> $HOME/.zshrc"
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD
    # Completions plugin
    CMD="echo 'zinit light zsh-users/zsh-completions' >> $HOME/.zshrc"
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD
    # My custom aliases plugin
    CMD="echo 'zinit light mateussantana/ohmyzsh-custom-funcalias' >> $HOME/.zshrc"
    echo "${GREEN}${CMD}${RESET}"
    eval $CMD
    echo ""
fi

# PHP 8.1
if $(php --version > /dev/null 2>&1); then
    printf "%s PHP is already installed\n" $EMOJI_SUCCESS
else
    printf "%s Installing %sPHP%s...\n" $EMOJI_PHP $GREEN $RESET
    CMD='sudo add-apt-repository ppa:ondrej/php -y'
    echo "${GREEN}${CMD}${RESET}" 
    $CMD || exit 2
    CMD='sudo apt-get install php8.1-cli php8.1-dom php8.1-curl php8.1-mbstring php8.1-zip -y'
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
if [[ $(which zsh) == $SHELL ]]; then
    printf "%s ZSH is already your default shell\n" $EMOJI_SUCCESS
else
    echo -n "${EMOJI_WARNING} ${YELLOW}Do you want to change your default shell to zsh? ${RESET}(y/n) "
    [[ -n $TTY ]] && read ANSWER
    if [[ $ANSWER =~ ^[yY]$ ]]; then
        CMD='chsh -s $(which zsh)'
        echo "${GREEN}${CMD}${RESET}"
        if eval $CMD; then
            echo "$EMOJI_SUCCESS Default shell changed successfully!"
        else
            echo "$EMOJI_ERROR ${RED}I can't change your default shell automatically. You will need to do it manually!${RESET}"
        fi
    fi
fi

# Finishing
printf "\n"
printf "╔═══════════════════════════════════════════════════════════════════╗\n"
printf "║                   🥳 🎉  %sCONGRATULATIONS%s  🎉 🥳                   ║\n" $BOLD $RESET
printf "║                    All tasks ran successfully                     ║\n"
printf "║                                                                   ║\n"
printf "║ → In order to use ngrok properly consider to execute:             ║\n"
printf "║   • %sngrok authtoken <your-personal-token>%s                         ║\n" $YELLOW $RESET
printf "║                                                                   ║\n"
printf "║ → To know more about OMZ spaceship theme:                         ║\n"
printf "║   • %shttps://github.com/spaceship-prompt/spaceship-prompt%s          ║\n" $BLUE $RESET
printf "║                                                                   ║\n"
printf "║ → To know more about OMZ plugins installed:                       ║\n"
printf "║   • %shttps://github.com/zdharma-continuum/zinit%s                    ║\n" $BLUE $RESET
printf "║   • %shttps://github.com/zdharma-continuum/fast-syntax-highlighting%s ║\n" $BLUE $RESET
printf "║   • %shttps://github.com/zsh-users/zsh-autosuggestions%s              ║\n" $BLUE $RESET
printf "║   • %shttps://github.com/zsh-users/zsh-completions%s                  ║\n" $BLUE $RESET
printf "║   • %shttps://github.com/mateussantana/ohmyzsh-custom-funcalias%s     ║\n" $BLUE $RESET
printf "║                                                                   ║\n"
printf "║ → To know more about Dracula themes:                              ║\n"
printf "║   %s %shttps://draculatheme.com/terminator%s                          ║\n" $EMOJI_DRACULA $BLUE $RESET
printf "║                                                                   ║\n"
printf "╚═══════════════════════════════════════════════════════════════════╝\n"
printf "\n"

echo "$EMOJI_WARNING To some changes take effect you'll need to restart computer!"
if [[ -n $TTY ]]; then
    echo -n "${YELLOW}Restart now? ${RESET}(y/n) ";
    read ANSWER;
    if [[ $ANSWER =~ ^[yY]$ ]]; then
        sudo shutdown -r now
    fi
fi

exit 0;
