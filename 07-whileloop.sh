#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" # /var/log/shell-script/07-whileloop.log

mkdir -p $LOGS_FOLDER
echo "Script started executed at: $(date)" | tee -a $LOG_FILE

SOURCE_DIR=/home/ec2-user/app-logs

if [ ! -d $SOURCE_DIR ]; then
    echo -e "$RERROR:: $SOURCE_DIR does not exist $N"
    exit 1
fi
# f --> file type and mtime +10 --> older than 10 days
# using touch -d 20260920 file.txt --> -d tells on which date the file should be created
FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f mtime +10)

while IFS= read -r filepath
do 
    echo -e"$RDeleting the file $N: $filepath"
    rm -rf $filepath
    echo -e "$R Deleted file $N : $filepath"
done <<< $FILES_TO_DELETE
