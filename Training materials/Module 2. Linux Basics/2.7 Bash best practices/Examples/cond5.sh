#!/bin/bash

# Conditional statement example: Check if a user input is a valid password

read -p "Enter your password: " password

# Regular expression pattern for password validation
pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#%^&+=]).{8,}$" # HELLO: this does not work, anyone wants to fix this?

if [[ $password =~ $pattern ]]; then
    echo "Valid password."
else
    echo "Invalid password. The password should meet the criteria: at least 8 characters long, contain at least one lowercase letter, one uppercase letter, one digit, and one special character."
fi
