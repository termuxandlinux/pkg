#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <option>"
    exit 1
fi

if [ "$1" = "--first" ]; then
    echo "Enter Github username:"
    read username
    echo "Enter Github email:"
    read usermail
    echo "Enter Github repository:"
    read repository
    echo "Enter Github token:"
    read token

    git init
    git remote set-url origin "https://$username:$token@github.com/$username/$repository"
    git config --global user.email "$usermail"
    git config --global user.name "$username"
    git branch -m main
    git checkout main

elif [ "$1" = "--setup" ]; then
    pkg -i auto-git

elif [ "$1" = "--auto" ]; then
    auto-git

elif [ "$1" = "--delete" ]; then
    rm /data/data/com.termux/files/usr/bin/gitcl

else
    echo "Invalid option: $1"
    exit 1
fi
