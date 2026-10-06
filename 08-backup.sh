#!/bin/bash

R="/e[31m"
G="/e[32m"
Y="/e[33m"
N="/e[0m"

USER_ID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-10} # here days is considerd if the 3rd option/comment in provided while running script else default to 14 value.

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/backup.log"

mkdir -p $LOGS_FOLDER
echo "Script started at: $(date)" | tee -a $LOG_FILE

if [ $USER_ID -ne 0 ]; then
    echo -e "$R ERROR: Please run this script with root privilages"
fi

USAGE(){
    echo -e "$R USAGE:: sudo sh 08-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS>[optional, default 14 days] $N"
    exit 1
}

## check source_dir and dest_dir passed or not
if [ $# -lt 2 ]; then
    USAGE
fi

## check source_dir exist or not
if [ ! -d $SOURCE_DIR ]; then
    echo -e "$R ERROR:: $N source directory doesn't exist"
    exit 1
fi

## check dest_dir exist or not
if [ ! -d $DEST_DIR ]; then
    echo -e "$R ERROR:: $N destination directory doesn't exist"
    exit 1
fi

### find the files
FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

if [ ! -z "${FILES}"]; then
    echo "Files found: $FILES"
    TIMESTAMP=$(date +%F-%H-%M)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    echo "zip file name is $ZIP_FILE_NAME"
    find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS | zip -@ -j "$ZIP_FILE_NAME"

    # check archieval success
    if [ -f $ZIP_FILE_NAME ]; then
        echo -e " Archieval: ... $G SUCCESS $N"

        #Deleting the files in source dir as they zipped successfully to destination
        while IFS= read -r filepath
        do 
            echo -e "$R Deleting $N the file: $filepath"
            rm -rf $filepath
            echo -e "Deleted $filepath ... $G SUCCESS $N"
        done <<< $FILES
    else 
        echo -e "Archieval ... $R FAILED $N"
        exit 1
    fi
else 
    echo -e "No files to archieve ... $Y SKIPPING $N"
fi
