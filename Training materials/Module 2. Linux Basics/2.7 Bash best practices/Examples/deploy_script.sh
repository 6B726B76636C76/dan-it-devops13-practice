#!/bin/bash

# Automated Deployment Script

# Set the target directory for deployment
target_dir="/mnt"

# Set the source directory for the files to be deployed
source_dir="/bin"

# Copy the files from the source directory to the target directory
cp -L -r "${source_dir}" "${target_dir}"

# Check if the copy was successful
if [ $? -eq 0 ]; then
  echo "Deployment completed successfully."
else
  echo "Deployment failed. Please check the source and target directories."
fi

