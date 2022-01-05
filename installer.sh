#!/bin/bash

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
NOCOLOR="\033[0m"

function ohmyposh() {
    # Oh My Posh - App Install
    echo -e "${BLUE}Downloading oh-my-posh from GitHub to /usr/local/bin${NOCOLOR}"
    sudo wget -q --show-progress https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
    sudo chmod +x /usr/local/bin/oh-my-posh
    # Oh My Posh - Theme Install
    echo -e "${BLUE}Creating theme folder ~/.poshthemes${NOCOLOR}"
    mkdir -p ~/.poshthemes
    echo "Done"
    echo -e "${BLUE}Downloading myterminal.omp.json from GitHub${NOCOLOR}"
    wget -q --show-progress https://raw.githubusercontent.com/gsbn/popos/main/poshthemes/myterminal.omp.json -O ~/.poshthemes/myterminal.omp.json
    # Update Bash shell
    echo -e "${BLUE}Enabling oh-my-posh in ~/.bashrc${NOCOLOR}"
    update_file="$HOME/.bashrc"
    bash_header="#OhMyPosh-Config"
    bash_footer="#OhMyPosh-Config-End"
    bash_text='eval "$(oh-my-posh --init --shell bash --config ~/.poshthemes/myterminal.omp.json)"'
    bash_full="$bash_header\n$bash_text\n$bash_footer"
    sed -i "/$bash_header/,/$bash_footer/d" $update_file
    echo -e $bash_full >> $update_file
    source ~/.bashrc
    echo "Done"
}

function ohmyposhfonts() {
    # Fonts Install
    echo -e "${BLUE}Downloading Meslo fonts from GitHub${NOCOLOR}"
    wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip -O ~/MesloInstall.zip
    echo -e "${BLUE}Installing fonts${NOCOLOR}"
    sudo apt-get install unzip
    unzip -o -q ~/MesloInstall.zip -d ~/MesloInstall
    rm ~/MesloInstall.zip
    font_dir="/usr/share/fonts/truetype/meslo"
    sudo mkdir -p $font_dir
    sudo mv ~/MesloInstall/*.ttf $font_dir
    rm -r ~/MesloInstall
    sudo apt-get install fontconfig
    fc-cache -f
}

function bashaliases() {
    echo -e "${BLUE}Downloading .bash_aliases from GitHub${NOCOLOR}"
    wget -q --show-progress https://raw.githubusercontent.com/gsbn/popos/main/home/.bash_aliases -O ~/.bash_aliases
    source ~/.bash_aliases
}

function pressanykey() {
    echo -e "${GREEN}COMPLETE - press any key${NOCOLOR}"
    read -n 1 -s -r -p ""
}

function advancedMenu() {
    ADVSEL=$(whiptail --title "Advanced Menu" --nocancel --menu "Choose an option" 15 60 4 \
        "1)" "Bash Prompt (Oh-My-Posh)" \
        "2)" "Bash Prompt Fonts (Meslo)" \
        "3)" "Bash Aliases (Custom .bash_aliases)" \
        "4)" "Exit" 3>&1 1>&2 2>&3)

    case $ADVSEL in
        "1)")
            ohmyposh
            pressanykey
            ;;
        "2)")
            ohmyposhfonts
            pressanykey
            ;;
        "3)")
            bashaliases
            pressanykey
            ;;
        "4)")
            exit 1
            ;;
    esac
}

# Main
while [ 1 ]
do
    advancedMenu
done

exit