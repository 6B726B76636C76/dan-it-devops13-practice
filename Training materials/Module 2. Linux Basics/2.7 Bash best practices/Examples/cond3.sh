#!/bin/bash

# Conditional statement example: Check if a user is an administrator

username="admin"

if [ $username == "admin" ]; then
    echo "User is an administrator."
else
    echo "User is not an administrator."
fi

