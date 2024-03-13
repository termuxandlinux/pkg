#!/bin/bash


# Speichere den Namen der Datei, die als Argument übergeben wurde
filename="$1"

# Vollständiger Pfad zur Datei im .termux/custom/ Verzeichnis
fullpath="${HOME}/.termux/custom/${filename}"

# Überprüfe, ob die Datei existiert und im richtigen Verzeichnis liegt
if [[ -f "$fullpath" ]]; then
    # Führe die Datei aus, wenn sie existiert
    bash "$fullpath"
else
    # Gebe eine Fehlermeldung aus, wenn die Datei nicht existiert
    echo "Fehler: Datei '${filename}' nicht im Verzeichnis .termux/custom/ gefunden."
fi
