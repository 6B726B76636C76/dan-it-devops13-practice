#!/bin/bash

# Data Processing Script

# Set the input file path
input_file="/path/to/input_file.csv"

# Set the output file path
output_file="/path/to/output_file.txt"

# Process the data from the input file and generate the output
awk -F',' '{ print $1, $3 }' "${input_file}" > "${output_file}"

# Check if the data processing was successful
if [ $? -eq 0 ]; then
  echo "Data processing completed successfully. Output file: ${output_file}"
else
  echo "Data processing failed. Please check the input and output file paths."
fi

