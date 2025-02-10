#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # Default to 14 days if not provided

LOGS_FOLDER="/home/ec2-user/shellscript-logs"  # Changed to a writable directory
LOG_FILE=$(basename "$0" | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

USAGE(){
    echo -e "$R USAGE:: $N sh 17-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>"
    exit 1
}

mkdir -p "$LOGS_FOLDER"  # Ensure log directory exists

if [ $# -lt 2 ]; then 
    USAGE
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "$SOURCE_DIR does not exist ... Please check"
    exit 1
fi

echo "Script started executing at: $TIMESTAMP" &>>"$LOG_FILE_NAME"


FILES=$(find $SOURCE_DIR -name "*.log" +mtime $DAYS)
echo "Files are: $FILES
