#!/bin/bash

# File Backup Script

# Specify the source directory to be backed up
source_dir="/mnt1/test123"

# Specify the destination directory for the backup
backup_dir="/mnt"

# Create a timestamp for the backup file name
timestamp=$(date +"%Y%m%d%H%M%S")

# Generate the backup file name with the timestamp
backup_file="${backup_dir}/backup_${timestamp}.tar.gz"

# Perform the backup using the 'tar' command
tar -czf "${backup_file}" "${source_dir}"

# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Backup completed successfully. Backup file: ${backup_file}"
else
  echo "Backup failed. Please check the source and destination directories."
fi