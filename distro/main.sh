#!/bin/bash

# ASCII banner
echo "Place your ASCII art banner here"

# Function to display the main menu
show_main_menu() {
    echo -e "\e[34mMenu1\e[0m"
    echo -e "\e[32m[1]\e[34m setup\e[0m"
    echo -e "\e[32m[2]\e[34m install\e[0m"
    echo -e "\e[32m[3]\e[34m login\e[0m"
    echo -e "\e[32m[4]\e[34m remove\e[0m"
    echo -e "\e[32m[0]\e[34m Exit\e[0m"
}

# Function to display the submenu
show_sub_menu() {
    echo -e "\e[34mChoose a distribution:\e[0m"
    echo -e "\e[32m[1]\e[34m ubuntu\e[0m"
    echo -e "\e[32m[2]\e[34m debian\e[0m"
    echo -e "\e[32m[3]\e[34m arch\e[0m"
    echo -e "\e[32m[4]\e[34m fedora\e[0m"
    echo -e "\e[32m[99]\e[34m back\e[0m"
    echo -e "\e[32m[0]\e[34m exit\e[0m"
}

# Function to process the selection in the main menu
process_main_selection() {
    case $1 in
        1)
            pkg install proot-distro -y
            ;;
        2) 
            process_sub_menu "install"
            ;;
        3) 
            process_sub_menu "login"
            ;;
        4)
            process_sub_menu "remove"
            ;;
        0) 
            exit 0
            ;;
        *) 
            echo "Invalid selection!"
            ;;
    esac
}

# Function to process the selection in the submenu
process_sub_selection() {
    action=$1
    distro=""
    case $2 in
        1) 
            distro="ubuntu"
            ;;
        2) 
            distro="debian"
            ;;
        3) 
            distro="archlinux"  # Change for arch
            ;;
        4) 
            distro="fedora"
            ;;
        99)
            show_main_menu
            read_main_selection
            return
            ;;
        0)
            exit 0
            ;;
        *)
            echo "Invalid selection!"
            return
            ;;
    esac
    
    if [ "$action" == "install" ]; then
        proot-distro install $distro
    elif [ "$action" == "login" ]; then
        proot-distro login $distro
    elif [ "$action" == "remove" ]; then
        proot-distro remove $distro
    fi
}

# Function to read the selection in the main menu
read_main_selection() {
    local choice
    read -p "Choose an option: " choice
    process_main_selection $choice
}

# Function to process the submenu
process_sub_menu() {
    show_sub_menu
    local choice
    read -p "Choose a distribution: " choice
    process_sub_selection $1 $choice
}

# Main script
clear
show_main_menu
read_main_selection
