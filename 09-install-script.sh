#!/bin/bash


USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "Error: You must have sudo access to execute this script"
    exit 1 # other than 0
fi 


dnf install mysql -y
if [ $? -ne 0 ]
then
    echo "Installing MYSQL ... Failure"
    exit 1
else
    echo "Installing MYSQL ... Success"
fi


dnf install git -y
if [ $? -ne 0 ]
then 
    echo "Installing Git ... Failure"
else
    echo "Installing Git ... Success"
fi

