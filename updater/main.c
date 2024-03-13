#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main() {
    // Wechseln zum Verzeichnis ~/.url/
    chdir(getenv("HOME"));
    chdir(".url");

    // Löschen der Datei url.txt
    system("rm -rf url.txt");

    // Ausgabe der Suchliste
    printf("search List\n");

    // Herunterladen der Datei url.txt von der angegebenen URL
    system("wget https://termux-pkg.netlify.app/updater/url/url.txt");

    // Wechseln zum Home-Verzeichnis
    chdir(getenv("HOME"));

    // Ausgabe der erfolgreichen Aktualisierung
    printf("Update Successful\n");

    return 0;
}
