#!/bin/bash

SRCFILES=$(find src -type f -name "*")
LIBFILES=$(find lib -type f -name "*.sh")

DIVIDER="========================================"

clear
echo "$DIVIDER"
echo "Welcome to Hardening Manager test cases!"

for file in $SRCFILES
do
    echo "$DIVIDER"
    echo "$file"
    echo "$DIVIDER"
    shellcheck $file
done;

for file in $LIBFILES
do
    echo "$DIVIDER"
    echo "$file"
    echo "$DIVIDER"
    shellcheck $file
done;

echo "$DIVIDER"
