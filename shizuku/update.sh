#!/bin/bash

# Function to display help
show_help() {
    echo "Usage: $0 [shell|--setup|--help|--delete]"
    echo "  shell       Start the file 'rish' located in \$HOME/.rish/"
    echo "  --setup     Create a folder '.rish' in \$HOME directory, move the 'rish' file there, and give it execution permissions."
    echo "  --help      Display this help message."
    echo "  --delete    Delete the '.rish' folder and 'adb' (only created by --setup)."
}

# Function to run 'rish' in $HOME/.rish/ directory
run_rish() {
    if [ -f "$HOME/.rish/rish" ]; then
        cd "$HOME/.rish/" || exit
        ./rish
    else
        echo "File 'rish' not found in $HOME/.rish/"
    fi
}

# Main script
case "$1" in
    shell)
        if [ -n "$2" ]; then
            $SHELL -c "$2"
        else
            run_rish
        fi
        ;;
    --setup)
        # Create the .rish folder and move the 'rish' file
        mkdir -p "$HOME/.rish"
        mv "$HOME/rish"* "$HOME/.rish/"
        # Give execution permissions to the 'rish' file
        chmod +x "$HOME/.rish/"*
        ;;
    --help)
        show_help
        ;;
    --delete)
        # Delete the .rish folder and adb
        rm -r -f "$HOME/.rish" /data/data/com.termux/files/usr/bin/adb
        ;;
    *)
        echo "Unknown argument: $1"
        show_help
        ;;
esac
