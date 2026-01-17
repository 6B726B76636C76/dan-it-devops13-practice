#!/bin/bash

# Conditional statement example: Check if a file exists

filename="example.txt"

if [ -f $filename ]; then
    echo "The file exists."
else
    echo "The file does not exist."
fi

