#! /usr/bin/bash

[ $# -ne 3 ] && { echo "Need 3 arguments" >&2; exit 1; }

shopt -s nullglob #чтоб шаблон поиска мог развернуться, даже если пустая директория
set -euo pipefail #скрипт падает при ошибках во время выполнения, для перестраховки

FROM_DIR=$1
TO_DIR=$2
FILE=$3

#exit-коды добавил разные для удобства дебага

if [ -d "$FROM_DIR" ]; then

    FILE_FOUND=0

    if [ -d "$TO_DIR" ]; then

        for file in "$FROM_DIR"/*; do
            if [ -f "$file" ] && [ "$(basename "$file")" = "$FILE" ]; then
                FILE_FOUND=1
                break
            fi
        done
    else
        echo "Destination dir is not found"
        exit 3
    fi

    if [ $FILE_FOUND -eq 1 ]; then
        cp "$FROM_DIR/$FILE" "$TO_DIR"
    else
        echo "File not found"
        exit 4
    fi
else
    echo "Source dir not found"
    exit 2
fi