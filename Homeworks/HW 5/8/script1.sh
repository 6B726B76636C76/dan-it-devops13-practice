#!/usr/bin/bash

if [ $# -ne 1 ]; then
    echo "please input data. for example - ./script.sh \"banana, apple, watermelon\""
    exit 1
fi

FRUITS=$1
IFS=', ' read -ra fruits <<< "$FRUITS"

for ((i=0; i<${#fruits[@]}; i++)); do
    echo -n "${fruits[i]} "
    echo
done