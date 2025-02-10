#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # If user is not providing number of days, we are taking 14 as default 


LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

USAGE(){
    echo -e "$R USAGE:: $N sh 17-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>
    exit 1
}

mkdir -p /home/ec2-user/shellscrit-logs/

if [ $# -lt 2 ]
then 
    USAGE
fi

if [ ! -d $SOURCE_DIR ]
then
    echo -e "$SOURCE_DIR Does not exist ... Please check"
    exit 1
fi

if [ ! -d $SOURCE_DIR ]
then
    echo -e "$SOURCE_DIR Does not exist ... Please check"
    exit 1
fi

echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME




