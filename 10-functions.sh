#!/bin/bash


USERID=$(id -u)

VALIDATE(){
    if [ $? -ne 0 ]
    then
        echo "$2 ... Failure"
        exit 1
    else
        echo "$2 ... Success"
    fi

}

if [ $USERID -ne 0 ]
then 
    echo "Error: You must have sudo access to execute this script"
    exit 1 # other than 0
fi 


dnf list installed mysql
if [ $? -ne 0 ]
then
    dnf install mysql -y
    if [ $? -ne 0 ]
    then
        echo "Installing MYSQL ... Failure"
        exit 1
    else
        echo "Installing MYSQL ... Success"
    fi
else
    echo "MYSQL is already ... Installed"
fi



dnf list installed git
if [ $? -ne 0 ]
then
dnf install git -y 
    VALIDATE $? "Installing Git" 
else
    echo "Git is already ... Installed"
fi

