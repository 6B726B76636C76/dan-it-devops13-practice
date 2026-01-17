#!/bin/bash

# Looping statement example: Read file line by line using while loop

filename="example.txt"

while read line
do
    echo $line
done < $filename

