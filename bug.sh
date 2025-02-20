#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Start two background processes that write to the files concurrently
(while true; do echo "Line from process 1" >> file1.txt; sleep 1; done) &
(while true; do echo "Line from process 2" >> file2.txt; sleep 1; done) &

# Wait for a few seconds
sleep 5

# Kill the background processes
kill %1
kill %2

# The bug: content of the files might be incomplete or interleaved unpredictably
cat file1.txt
cat file2.txt