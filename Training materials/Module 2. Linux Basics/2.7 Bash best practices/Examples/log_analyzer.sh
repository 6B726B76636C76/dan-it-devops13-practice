#!/bin/bash

# Log Analyzer Script

# Specify the log file path
log_file="/var/log/secure"

# Specify the pattern to search for in the log file
search_pattern="fail"

# Search for the pattern in the log file
grep "${search_pattern}" "${log_file}"

