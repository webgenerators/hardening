#!/bin/bash

TESTFILES=$(find tests -type f -name "test_*.sh")
DIVIDER="========================================"

clear
echo "$DIVIDER"
echo "Welcome to Hardening Manager test cases!"

for file in $TESTFILES
do
    filebase=$(basename "$file")
    filename="${filebase%.*}"

    echo "$DIVIDER"
    echo "$filebase"
    echo "$DIVIDER"
    shunit2 $file
done;

echo "$DIVIDER"
