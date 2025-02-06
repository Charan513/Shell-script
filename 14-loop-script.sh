
#!/bin/bash


USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-logscripts"
LOG_FILE=$(echo $0 | cut -d "." -f1)
TIMESTSMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTSMP.log"

VALIDATE(){
    if [ $? -ne 0 ]
    then
        echo -e "$2 ... $R Failure $N"
        exit 1
    else
        echo -e "$2 ... $G  Success $N"
    fi

}

echo "Script started executing at: $TIMESTSMP" &>>$LOG_FILE_NAME


if [ $USERID -ne 0 ]
then 
    echo "Error: You must have sudo access to execute this script"
    exit 1 # other than 0
fi 



for package in $@
do
    dnf list $package &>>
    if [ $? -ne 0 ]
    then
        dnf install $package -y &>>
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is already $Y ... INSTALLED $N"
    fi
done