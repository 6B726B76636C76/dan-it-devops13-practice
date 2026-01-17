#!/bin/bash

# Looping statement example: Iterate over array elements using for loop

fruits=("Apple" "Banana" "Orange" "Mango" "Pineapple")

for fruit in "${fruits[@]}"
do
    echo $fruit
done

