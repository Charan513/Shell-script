#!/bin/bash


USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"

VALIDATE(){
    if [ $? -ne 0 ]
    then
        echo -e "$2 ... $R Failure"
        exit 1
    else
        echo "$2 ... $G  Success"
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
    echo -e "MYSQL is already ... $Y Installed"
fi



dnf list installed git
if [ $? -ne 0 ]
then
dnf install git -y 
    VALIDATE $? "Installing Git" 
else
    echo -e "Git is already ... $Y Installed"
fi

