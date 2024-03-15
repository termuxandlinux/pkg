#!/bin/bash

if [ "$1" == "--setup" ]; then
    mkdir -p ~/sdk
    cd ~/sdk || exit
    wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
    unzip commandlinetools-linux-6858069_latest.zip
    echo 'export PATH="$HOME/sdk/tools/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
elif [ "$1" == "--project" ]; then
    read -p "Enter project name: " project
    read -p "Enter SDK version: " sdk
    read -p "Enter app name: " appname
    read -p "Enter package name: " packagename

    mkdir -p ~/"${project}"
    cd ~/"${project}" || exit
    android create project --target android-"${sdk}" --name "${appname}" --path . --activity MainActivity --package "${packagename}"
else
    echo "Usage: android-studio [--setup|--project]"
fi
