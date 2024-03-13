#!/bin/bash

# Speichere den übergebenen Argumentenbefehl
command="$1"

# Funktion zum Setzen der Umgebung
set_environment() {
    mkdir -p "$HOME/.termux/custom"
}

# Funktion zum Einrichten der Berechtigungen
setup_permissions() {
    chmod +x "$HOME/.termux/custom"/*
}

# Funktion zum Löschen des Ordners
delete_folder() {
    rm -rf "$HOME/.termux/custom"
}

# Funktion zum Löschen des Befehls
delete_command() {
    rm /data/data/com.termux/files/usr/bin/termux-custom
}

# Führe den Befehl basierend auf dem übergebenen Argument aus
case "$command" in
    --set)
        set_environment
        ;;
    --setup)
        setup_permissions
        ;;
    --delete)
        delete_folder
        ;;
    --dlt-cmd)
        delete_command
        ;;
    *)
        echo "Ungültiges Argument: $command"
        exit 1
        ;;
esac
