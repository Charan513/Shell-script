#!/bin/bash


echo "All variables passed: $@"
echo "Number of variables: $#"
echo "Script name: $0"
echo "Present working directory: $PWD"
echo "Which user is running this script:$USER"
echo "Home drectory of current user: $HOME"
echo "process id of current script: $$"
sleep 60 &
echo "process id of last commmand in background: $!"
