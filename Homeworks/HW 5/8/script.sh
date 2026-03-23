#!/usr/bin/bash


FRUITS=("apple" "banana" "pineapple" "strawberry" "raspberry" "watermelon" "apricot")

for fruit in ${FRUITS[*]}; do
    echo "$fruit"
done