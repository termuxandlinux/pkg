#!/data/data/com.termux/files/usr/bin/bash

# Terminal auf Deutsch einstellen
export LANG=de_DE.UTF-8

# Funktion zum Ausführen von Befehlen im Terminal
run_command() {
    command=$1
    $command
}

# Funktion zum Erstellen des Prompt
set_prompt() {
    prompt="termux{${PWD#${HOME}}}$ "
    export PS1="$prompt"
}

# Hauptfunktion, die das Terminal startet und Befehle ausführt
start_terminal() {
    echo "Willkommen im Termux-Terminal!"
    while true; do
        set_prompt
        read -p "$PS1" input
        case $input in
            exit)
                echo "Auf Wiedersehen!"
                break
                ;;
            *)
                run_command "$input"
                ;;
        esac
    done
}

start_terminal
