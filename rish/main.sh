#!/bin/bash

wget https://termux-pkg.netlify.app/rish/files/rish
wget https://termux-pkg.netlify.app/rish/files/rish_shizuku.dex
mv rish $HOME
mv rish_shizuku.dex $HOME
pkgo -i shizuku
adb --setup
