#! /usr/bin/bash

for ((i=1; i<=10; i++));
do
    mkdir "$i"
done

for dir in *
do
    if [ -d "$dir" ]; then
        touch "$dir/script.sh"
    fi

done
