#!/bin/bash

# Höhe und Breite des Terminals abrufen
R=$(tput lines)
C=$(tput cols)

# Wenn die Terminalgröße nicht abgerufen werden kann, Standardwerte verwenden
if [[ -z "$R" || -z "$C" ]]; then
    R=25  # Standardhöhe
    C=80  # Standardbreite
fi

# Das Terminal löschen und den Cursor ausblenden
echo -e "\033[2J\033[?25l"

# Dateiname für die Ausgabedatei
output_file="target.txt"

while true; do
    (
        e=echo\ -e
        s=sleep
        j=$((RANDOM % C))
        d=$((RANDOM % 6))

        # Array für die zufälligen Zahlen in den 5er-Blöcken
        random_numbers=()

        for ((i=1; i<=$R; i++)); do
            c=$(printf '\\\\0%o' $((RANDOM % 57 + 33)))
            random_number=$((RANDOM % 10))  # Zufällige Zahl von 0 bis 9

            # Zufällige Zahl zum Array hinzufügen
            random_numbers+=("$random_number")

            $e "\033[$((i-1));${j}H\033[32m$c\033[$i;${j}H\033[39m"
            $s 0.01
            if [ $i -ge $d ]; then
                $e "\033[$((i-d));${j}H "
            fi
        done

        # Zufällige Zahlen in die Ausgabedatei schreiben
        for ((i=0; i<${#random_numbers[@]}; i+=6)); do
            echo "${random_numbers[@]:$i:6}" >> "$output_file"
        done
    ) & sleep 0.05
done
