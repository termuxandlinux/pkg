#!/bin/bash

# Check if the first argument is -i
if [ "$1" == "-i" ]; then
    # Define paths and variables
    url_file="$HOME/.url/url.txt"
    package_name="$2"
    url=$(head -n 1 "$url_file")

    # Check if the URL file exists
    if [ ! -f "$url_file" ]; then
        echo "Error: The URL file does not exist: $url_file"
        exit 1
    fi

    # Check if the package exists in the URL
    if wget --spider "$url/${package_name}/pip/requirements.txt" 2>/dev/null; then
        # Download the requirements.txt
        wget -q -O requirements.txt "$url/${package_name}/pip/requirements.txt"

        # Install the requirements
        pip install -r requirements.txt

        # Remove the temporary file
        rm requirements.txt
    else
        echo "Error: requirements.txt not found for package: $package_name"
        exit 1
    fi
else
    # If the first argument is not -i, simply execute pip with the given arguments
    pip "$@"
fi
