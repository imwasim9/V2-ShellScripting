#!/bin/bash

# These are special variables and can be helpful in scripting and interviews

echo "Printing all variables passed to the script using $@: $@"
echo "Printing all variables passed to the script using $*: $*"
echo "Script name: $0"
echo "Current directory usage in the script: $PWD"
echo "Who is running this script: $USER"
echo "Home directory of the user: $HOME"
echo "PID of the script: $$"
sleep 10 &
echo "PID of the last command: $!"