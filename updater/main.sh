#!/bin/bash

cd $HOME/.url/

rm -r -f url.txt

echo "search List"

wget https://termux-pk.netlify.app/updater/url/url.txt

cd $HOME

echo "Update Succesfull"

