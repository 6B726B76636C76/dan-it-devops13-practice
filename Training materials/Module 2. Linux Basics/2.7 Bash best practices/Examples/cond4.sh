#!/bin/bash

# Conditional statement example: Check if a number is even or odd

number=7

if [ $((number % 2)) -eq 0 ]; then
    echo "The number is even."
else
    echo "The number is odd."
fi

