#! /usr/bin/bash
set -euo pipefail

INPUT_STRING=$1
IFS=',;:?! ' read -ra data <<< "$INPUT_STRING"

for ((i=${#data[@]}-1; i>=0; --i)); do
    echo -n "${data[i]} "
done
echo