#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// ANSI escape codes for text color
#define GREEN_TEXT "\033[0;32m"
#define BLUE_TEXT "\033[0;34m"
#define RESET_COLOR "\033[0m"

// Function declarations
void show_main_menu();
void show_sub_menu();
void process_main_selection(int choice);
void process_sub_selection(char* action, int choice);
void process_sub_menu(char* action);

int main() {
    // Clear the screen
    system("clear");

    // Show main menu and process selection
    show_main_menu();
    return 0;
}

void show_main_menu() {
    printf("Menu\n");
    printf(GREEN_TEXT "[1] setup\n" RESET_COLOR);
    printf(GREEN_TEXT "[2] install\n" RESET_COLOR);
    printf(GREEN_TEXT "[3] login\n" RESET_COLOR);
    printf(GREEN_TEXT "[4] remove\n" RESET_COLOR);
    printf(GREEN_TEXT "[0] Exit\n" RESET_COLOR);

    int choice;
    printf("Choose an option: ");
    scanf("%d", &choice);
    process_main_selection(choice);
}

void show_sub_menu() {
    printf("Choose a distribution:\n");
    printf(BLUE_TEXT "[1] ubuntu\n" RESET_COLOR);
    printf(BLUE_TEXT "[2] debian\n" RESET_COLOR);
    printf(BLUE_TEXT "[3] arch\n" RESET_COLOR);
    printf(BLUE_TEXT "[4] fedora\n" RESET_COLOR);
    printf(GREEN_TEXT "[99] back\n" RESET_COLOR);
    printf(GREEN_TEXT "[0] exit\n" RESET_COLOR);
}

void process_main_selection(int choice) {
    switch (choice) {
        case 1:
            system("pkg install proot-distro -y");
            break;
        case 2:
            process_sub_menu("install");
            break;
        case 3:
            process_sub_menu("login");
            break;
        case 4:
            process_sub_menu("remove");
            break;
        case 0:
            exit(0);
        default:
            printf("Invalid selection!\n");
    }
}

void process_sub_selection(char* action, int choice) {
    char* distro = NULL;
    switch (choice) {
        case 1:
            distro = "ubuntu";
            break;
        case 2:
            distro = "debian";
            break;
        case 3:
            distro = "archlinux";
            break;
        case 4:
            distro = "fedora";
            break;
        case 99:
            show_main_menu();
            return;
        case 0:
            exit(0);
        default:
            printf("Invalid selection!\n");
            return;
    }

    char command[256];
    if (strcmp(action, "install") == 0) {
        snprintf(command, sizeof(command), "proot-distro install %s", distro);
    } else if (strcmp(action, "login") == 0) {
        snprintf(command, sizeof(command), "proot-distro login %s", distro);
    } else if (strcmp(action, "remove") == 0) {
        snprintf(command, sizeof(command), "proot-distro remove %s", distro);
    }
    system(command);
}

void process_sub_menu(char* action) {
    show_sub_menu();
    int choice;
    printf("Choose a distribution: ");
    scanf("%d", &choice);
    process_sub_selection(action, choice);
}