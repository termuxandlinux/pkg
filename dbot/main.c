#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NAME_LENGTH 50
#define MAX_COMMAND_LENGTH 100
#define MAX_OUTPUT_LENGTH 100
#define MAX_TOKEN_LENGTH 100

void create_bot_file(const char *botname, const char *prefix);
void add_command(const char *input, const char *output);
void add_bot_token(const char *token);

int main(int argc, char *argv[]) {
    if (argc > 1) {
        if (strcmp(argv[1], "--setup") == 0) {
            system("pkg install python3 -y");
            system("pip install discord.py");
            system("mkdir $HOME/bots/");
            return 0;
        } else if (strcmp(argv[1], "--list") == 0) {
            system("ls $HOME/bots");
            return 0;
        } else if (strcmp(argv[1], "--delete") == 0) {
            system("rm /data/data/com.termux/files/usr/bin/dbot");
            return 0;
        } else if (strcmp(argv[1], "--help") == 0) {
            printf("Usage: dbot\n");
            printf("--setup\t\tInstalls Python and Discord.py, creates bot directory\n");
            printf("--list\t\tLists all bot files\n");
            printf("--delete\tDeletes dbot executable\n");
            return 0;
        }
    }

    char botname[MAX_NAME_LENGTH];
    printf("Enter your Discord bot name: ");
    scanf("%s", botname);

    create_bot_file(botname, "$");
    
    char prefix[10];
    printf("Enter the bot prefix: ");
    scanf("%s", prefix);

    char command[MAX_COMMAND_LENGTH];
    char output[MAX_OUTPUT_LENGTH];
    char choice;
    do {
        printf("Enter the command: ");
        scanf("%s", command);
        printf("Enter the output: ");
        scanf("%s", output);
        add_command(command, output);
        printf("Do you want to add another command? (y/n): ");
        scanf(" %c", &choice);
    } while (choice == 'y' || choice == 'Y');

    char token[MAX_TOKEN_LENGTH];
    printf("Enter your bot token: ");
    scanf("%s", token);
    add_bot_token(token);

    return 0;
}

void create_bot_file(const char *botname, const char *prefix) {
    char filepath[MAX_NAME_LENGTH + 10];
    sprintf(filepath, "$HOME/bots/%s.py", botname);
    FILE *file = fopen(filepath, "w");
    if (file != NULL) {
        fprintf(file, "import discord\n");
        fprintf(file, "from discord.ext import commands\n\n");
        fprintf(file, "intents = discord.Intents.default()\n");
        fprintf(file, "intents.message_content = True\n\n");
        fprintf(file, "bot = commands.Bot(command_prefix='%s', intents=intents)\n\n", prefix);
        fclose(file);
        printf("Bot file created successfully!\n");
    } else {
        printf("Error creating bot file.\n");
    }
}

void add_command(const char *input, const char *output) {
    char filepath[MAX_NAME_LENGTH + 10];
    sprintf(filepath, "$HOME/bots/%s.py", input);
    FILE *file = fopen(filepath, "a");
    if (file != NULL) {
        fprintf(file, "\n@bot.command()\n");
        fprintf(file, "async def %s(ctx):\n", input);
        fprintf(file, "    await ctx.send('%s')\n", output);
        fclose(file);
        printf("Command added successfully!\n");
    } else {
        printf("Error adding command.\n");
    }
}

void add_bot_token(const char *token) {
    char filepath[MAX_NAME_LENGTH + 10];
    sprintf(filepath, "$HOME/bots/%s.py", token);
    FILE *file = fopen(filepath, "a");
    if (file != NULL) {
        fprintf(file, "\nbot.run('%s')\n", token);
        fclose(file);
        printf("Bot token added successfully!\n");
    } else {
        printf("Error adding bot token.\n");
    }
}
