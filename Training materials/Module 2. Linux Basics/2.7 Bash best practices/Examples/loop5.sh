#!/bin/bash

# Looping statement example: Find even numbers between 1 and 10 using while loop

number=1

while [ $number -le 10 ]
do
    if [ $((number % 2)) -eq 0 ]; then
        echo $number
    fi

    ((number++))
done

