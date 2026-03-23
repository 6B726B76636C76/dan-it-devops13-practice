#! /usr/bin/bash


if [ $# -ne 1 ]; then
    echo "please input filename. for example - ./script.sh file.txt"
    exit 1
fi

FILENAME=$1

if [ -f "$FILENAME" ]; then

    if [ -r "$FILENAME" ]; then

        mime_type=$(file -b --mime-type "$FILENAME")

        if [[ "$mime_type" == text/* ]]; then

            COUNT=$(wc -l < "$FILENAME")
            echo $COUNT
        else
            echo "error. incorrect type of the file. only text file needed"
        fi
    else
        echo "cannot read filr"
    fi
else
    echo "the file does not exist"
fi