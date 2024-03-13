#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Funktionen für die Installationen
void installX11() {
    system("pkg install x11-repo");
    system("pkg install termux-x11-nightly -y");
}

void installAPI() {
    system("pkg install termux-api");
}

void installGUI() {
    system("pkg install x11-repo");
    system("pkg install xfce4 -y");
    system("pkg install aterm -y");
    system("echo 'export DISPLAY=:1' >> $HOME/.bashrc");
    system("source $HOME/.bashrc");
}

// Funktion zur Anzeige des ASCII-Art-Logos und des Banners
void displayBanner() {
    printf("******************************************************\n");
    printf("*                                                    *\n");
    printf("*                Willkommen zum Menü                 *\n");
    printf("*                                                    *\n");
    printf("*             ______   __     __   _______            *\n");
    printf("*            |      \\ |  |   |  | |   ____|           *\n");
    printf("*            |  --  ||  |   |  | |  |__              *\n");
    printf("*            |  --  ||  |   |  | |   __|             *\n");
    printf("*            |______/ |__|   |__| |__|                *\n");
    printf("*                                                    *\n");
    printf("******************************************************\n");
    printf("\n");
}

int main(int argc, char *argv[]) {
    displayBanner(); // Anzeige des Banners

    // Menü anzeigen, falls keine Parameter übergeben wurden
    if (argc == 1) {
        printf("[1] Install x11\n");
        printf("[2] Install API\n");
        printf("[3] Install GUI\n");

        int choice;
        printf("Wähle eine Option: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                installX11();
                break;
            case 2:
                installAPI();
                break;
            case 3:
                installGUI();
                break;
            default:
                printf("Ungültige Auswahl\n");
                break;
        }
    } else { // Andernfalls Parameterverarbeitung
        if (strcmp(argv[1], "--gui") == 0) {
            system("termux-x11 : &");
        } else if (strcmp(argv[1], "--setup") == 0) {
            system("pkg install python3 -y");
        } else if (strcmp(argv[1], "--repo") == 0) {
            system("pkg install x11-repo");
        } else if (strcmp(argv[1], "--root") == 0) {
            system("pkg install root repo");
        } else if (strcmp(argv[1], "--delete") == 0) {
            system("rm /data/data/com.termux/files/usr/bin/termtool");
        } else {
            printf("Ungültiger Parameter\n");
            return 1;
        }
    }

    return 0;
}
