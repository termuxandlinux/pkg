#!/bin/bash

# Function to create bot file
create_bot_file() {
    botname=$1
    prefix=$2
    filepath="$HOME/bots/$botname.py"

    # Check if bot file already exists
    if [ -e "$filepath" ]; then
        echo "Bot file already exists."
        return 1
    fi

    # Create bot file
    echo "import discord
from discord.ext import commands

intents = discord.Intents.default()
intents.message_content = True

bot = commands.Bot(command_prefix='$prefix', intents=intents)
" > "$filepath"
    echo "Bot file created successfully!"
}

# Function to add command to bot file
add_command() {
    botname=$1
    input=$2
    output=$3
    filepath="$HOME/bots/$botname.py"

    # Check if bot file exists
    if [ ! -e "$filepath" ]; then
        echo "Bot file does not exist."
        return 1
    fi

    # Add command to bot file
    echo "
@bot.command()
async def $input(ctx):
    await ctx.send('$output')
" >> "$filepath"
    echo "Command added successfully!"
}

# Function to add bot token to bot file
add_bot_token() {
    botname=$1
    token=$2
    filepath="$HOME/bots/$botname.py"

    # Check if bot file exists
    if [ ! -e "$filepath" ]; then
        echo "Bot file does not exist."
        return 1
    fi

    # Add bot token to bot file
    echo "
bot.run('$token')
" >> "$filepath"
    echo "Bot token added successfully!"
}

# Main script
echo "Enter your Discord bot name:"
read botname
echo "Enter the bot prefix:"
read prefix

create_bot_file "$botname" "$prefix"

while true; do
    echo "Enter the command:"
    read input
    echo "Enter the output:"
    read output
    add_command "$botname" "$input" "$output"
    echo "Do you want to add another command? (y/n):"
    read choice
    if [ "$choice" != "y" ]; then
        break
    fi
done

echo "Enter your bot token:"
read token
add_bot_token "$botname" "$token"
