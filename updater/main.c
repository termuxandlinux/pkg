#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main() {
    // URL-Datei herunterladen und verschieben
    system("wget -O url.txt https://termux-pkg.netlify.app/ubdater/url/url.txt");
    // Überprüfen, ob die Datei erfolgreich heruntergeladen wurde
    struct stat buffer;
    if (stat("url.txt", &buffer) == 0) {
        // Zielverzeichnis erstellen, falls es nicht existiert
        system("mkdir -p $HOME/.url/");
        // Überprüfen, ob bereits eine url.txt im Zielverzeichnis existiert
        if (access("$HOME/.url/url.txt", F_OK) == 0) {
            // Falls vorhanden, löschen
            remove("$HOME/.url/url.txt");
        }
        // Datei verschieben
        if (rename("url.txt", "$HOME/.url/url.txt") == 0) {
            printf("Die Datei wurde erfolgreich verschoben.\n");
        } else {
            printf("Fehler beim Verschieben der Datei.\n");
        }
    } else {
        printf("Fehler beim Herunterladen der Datei.\n");
    }
    return 0;
}
