#!/bin/bash


USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"

LOGS_FOLDER="/var/log/shell-logscripts"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTSMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTSMP.log"

VALIDATE(){
    if [ $? -ne 0 ]
    then
        echo -e "$2 ... $R Failure"
        exit 1
    else
        echo -e "$2 ... $G  Success"
    fi

}

echo "Script started executing at: $TIMESTSMP" &>>$LOG_FILE



if [ $USERID -ne 0 ]
then 
    echo "Error: You must have sudo access to execute this script"
    exit 1 # other than 0
fi 


dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]
then
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "Installing MYSQL"
else
    echo -e "MYSQL is already ... $Y Installed"
fi


 
dnf list installed git &>>$LOG_FILE
if [ $? -ne 0 ]
then
    dnf install git -y &>>$LOG_FILE
    VALIDATE $? "Installing Git" 
else
    echo -e "Git is already ... $Y Installed"
fi

