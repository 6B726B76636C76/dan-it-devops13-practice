#! /usr/bin/bash 

FILE=$1
IS_FOUND=0

for file in *
do
    if [ -f "$file" ] && [ "$file" = "$FILE" ]; then
    IS_FOUND=1
        echo "file is exist"
        break
    fi
done

if [ $IS_FOUND -eq 0 ]; then
    echo "file does not exist"
fi