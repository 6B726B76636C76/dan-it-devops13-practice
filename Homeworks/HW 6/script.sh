#!/usr/bin/bash

NUMBER=$((RANDOM % 100 + 1))
MAX_ATTEMPTS=5

for((i=0; i<MAX_ATTEMPTS; i++)); do

    read -p "Please input number : " number

    if ! [[ "$number" =~ ^[0-9]+$ ]]; then
        echo "Incorrect input. Please enter a number."
        continue
    fi

    if (( number < 1 || number > 100 )); then
        echo "Incorrect value. Value should be a number from 1 to 100."
        continue
    fi

    if (( number == NUMBER )); then
        echo "Congratulations! You win!."
        exit 0
    elif (( number > NUMBER )); then
        echo "Too high"
    else
        echo "Too low"
    fi
done

echo "Sorry, you've run out of attempts. The correct number was $NUMBER."
exit 0