#!/bin/bash

# Generate a random password

# Define the character set to choose from
characters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&+="

# Length of the password
length=12

# Initialize an empty password variable
password=""

# Generate random password
for ((i=0; i<$length; i++)); do
    # Get a random character from the character set
    random_char=${characters:RANDOM%${#characters}:1}
    # Append the random character to the password
    password="${password}${random_char}"
done

echo "Generated password: $password"

