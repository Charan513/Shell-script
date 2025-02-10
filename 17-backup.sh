#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # Default to 14 days if not provided

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
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

mkdir -p "$LOGS_FOLDER"

if [ $# -lt 2 ]; then 
    USAGE
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "$SOURCE_DIR does not exist ... Please check"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
    echo -e "$DEST_DIR does not exist ... Creating it now..."
    mkdir -p "$DEST_DIR"
fi

echo "Script started executing at: $TIMESTAMP" &>>"$LOG_FILE_NAME"

# Fixing the 'find' command issue
echo "Finding files older than $DAYS days in $SOURCE_DIR..."
find "$SOURCE_DIR" -type f -mtime +"$DAYS" -exec mv {} "$DEST_DIR" \; &>>"$LOG_FILE_NAME"
VALIDATE $? "Moving old files"

echo "Backup completed at $(date +%Y-%m-%d-%H-%M-%S)" &>>"$LOG_FILE_NAME"
echo -e "Backup operation completed. Check logs at: $LOG_FILE_NAME"
