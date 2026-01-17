#!/bin/bash

# Conditional statement example: Check if a number is positive, negative, or zero

number=0

if [ $number -eq 0 ]; then
    echo "The number is zero."
elif [ $number -gt 0 ]; then
    echo "The number is positive."
else
    echo "The number is negative."
fi