#!/usr/bin/bash

BASE_DIR_NAME="$HOME/watch"
CACHED_FILES_DIR=".cache"
CHANGELOG_DIR=".log"
CACHED_FILE_FORMAT=".back"


date_time() {
    date "+%d-%m-%Y %H:%M:%S"
}

echo "$(date_time) Checking required dirs..."

if [ -d "$BASE_DIR_NAME/$CHANGELOG_DIR" ]; then
    echo "$(date_time) The log-files directory is available"
else
    echo "$(date_time) The log-files directory is not available. Creating folder..."
    if mkdir -p "$BASE_DIR_NAME/$CHANGELOG_DIR"; then
        echo "$(date_time) The log-files directory was successfully created!"
    else
        echo "$(date_time) Can't create the log-files directory"
        exit 1
    fi
fi


if [ -d "$BASE_DIR_NAME/$CACHED_FILES_DIR" ]; then
    echo "$(date_time) The cached-files directory is available"
else
    echo "$(date_time) The cached-files directory is not available. Creating folder..."
    if mkdir -p "$BASE_DIR_NAME/$CACHED_FILES_DIR"; then
        echo "$(date_time) The cached-files directory was successfully created!"
    else
        echo "$(date_time) Can't create the cached-files directory"
        exit 1
    fi
fi

CURRENT_FILES_IN_DIR=("$BASE_DIR_NAME"/*)
CURRENT_BACK_FILES=("$BASE_DIR_NAME"/*.back)

for file in "${CURRENT_BACK_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "$(date_time) The file $file is not moved to the cache folder! Moving..."
        if mv "$file" "$BASE_DIR_NAME/$CACHED_FILES_DIR"; then
            echo "$(date_time) $file successfully moved!"
        else
            echo "$(date_time) Error moving $file!"
        fi
    fi
done

logfile="$BASE_DIR_NAME/$CHANGELOG_DIR/changelog.log"
processedlog="$BASE_DIR_NAME/$CHANGELOG_DIR/processed.log"

touch "$processedlog" 2>/dev/null || echo "$(date_time) Cannot create $processedlog!"

echo "$(date_time) Current files with content:"
for file in "${CURRENT_FILES_IN_DIR[@]}"; do

    if [[ -f "$file" && ! $file =~ \.back$ ]]; then

        filename=$(basename "$file")
        if grep -Fxq "$filename" "$processedlog"; then
            continue
        fi
        echo "$file - $(cat "$file")"
        echo "$filename" >> "$processedlog"
    fi
done

for file in "${CURRENT_FILES_IN_DIR[@]}"; do

    if [ ! -f "$file" ]; then
        continue
    fi

    new_name="$file$CACHED_FILE_FORMAT"
    
    if mv "$file" "$new_name"; then
        echo "$(date_time) The file $file cached as $new_name."
        if mv "$new_name" "$BASE_DIR_NAME/$CACHED_FILES_DIR"; then
            echo "$(date_time) The file $new_name moved to the $CACHED_FILES_DIR directory"
        else
            echo "$(date_time) Error! Can't move $new_name to cache!"
        fi
    else
        echo "$(date_time) Error! Can't cache $file!"
    fi
done
