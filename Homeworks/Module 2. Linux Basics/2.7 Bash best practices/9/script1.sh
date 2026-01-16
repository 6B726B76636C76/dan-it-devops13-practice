#!/usr/bin/bash

if [ $# -ne 1 ]; then
    echo "please input filename. for example - ./script.sh filename"
    exit 1
fi

FILENAME=$1

if [ -f "$FILENAME" ]; then

    if [ -r "$FILENAME" ]; then

        cat "$FILENAME" || {
            echo "Can't read the $FILENAME" >&2
            exit 4
        }
    else
        echo "You have no permissions for read this file."
        exit 3
    fi
else
    echo "File does not exist"
    exit 2
fi