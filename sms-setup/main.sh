#!/bin/bash

mkdir $HOME/.sms
wget https://termux-pkg.netlify.app/sms/token/log.txt
wget https://termux-pkg.netlify.app/sms/token/_token.txt
mv _token.txt $HOME/.sms
mv log.txt $HOME/.sms

if [[ "$1" == "--delete" ]]; then
    rm /data/data/com.termux/files/usr/bin/
elif [[ "$1" == "--help" ]]; then
    echo "We can not help you guy"
elif [[ "$1" == "--sms-i" ]]; then
    pkgo -i sms
elif [[ "$1" == "--sms-s" ]]; then
    sms
fi
