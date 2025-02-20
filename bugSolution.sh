#!/bin/bash

# This script demonstrates a solution to the race condition bug using flock.

# Create two files
touch file1.txt
touch file2.txt

# Function to write to a file safely
write_to_file() {
  local file=$1
  local message=$2
  flock -x "$file" || exit 1
  echo "$message" >> "$file"
  flock -u "$file"
}

# Start two processes that write to the files concurrently using flock for locking
(while true; do write_to_file file1.txt "Line from process 1"; sleep 1; done) &
(while true; do write_to_file file2.txt "Line from process 2"; sleep 1; done) &

# Wait for a few seconds
sleep 5

# Kill the background processes
kill %1
kill %2

# The output should be predictable now
cat file1.txt
cat file2.txt