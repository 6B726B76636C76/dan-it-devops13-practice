#!/usr/bin/bash

if [ $# -ne 1 ]; then
    echo "please input filename. for example - ./script.sh filename"
    exit 1
fi

FILENAME=$1

if [ -f "$FILENAME" ]; then

    if [ -r "$FILENAME" ]; then

        if file "$FILENAME" | grep -q text; then
            cat "$FILENAME"
        else
            echo "Error: file is not a text file"
            exit 4
        fi
    else
        echo "You have no permissions for read this file."
        exit 3
    fi
else
    echo "File does not exist"
    exit 2
fi