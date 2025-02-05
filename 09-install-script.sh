#!/bin/bash


USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "Error: You must have sudo access to execute this script"
fi 

dnf install mysql -y

 
