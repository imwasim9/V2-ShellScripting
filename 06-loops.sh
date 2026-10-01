#!/bin/bash

for i in {1..20}
do
    echo $i
done

# color codes
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log" # /var/log/shell-script/installations.log

mkdir -p $LOGS_FOLDER
echo "Script started at: $(date)" | tee -a $LOG_FILE

# getting the user id id -u, sudo id -u
USER_ID=$(id -u) # running the command using $()

if [ $USER_ID -ne 0 ]; then
   echo -e "$R ERROR$N:: Please run this script with root privelege" | tee -a $LOG_FILE
   # failure code is 1 and success code is 0 for exit status
   # 0 - sucess, 1-127 failure codes   
   exit 1 
fi

VALIDATE() {  #functions will recieve input via cmd line arguments just like shell script args
   if [ $1 -ne 0 ]; then
       echo -e "$R ERROR$N:: Installing $2 failed please check logs" | tee -a $LOG_FILE
       exit 1 
   else 
       echo -e "$2 installation is $G successful$N" | tee -a $LOG_FILE
   fi 
}

for package in $@
do 
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]; then
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? $package
    else
        echo -e "$package is already installed .... $Y SKIPPING $N" | tee -a $LOG_FILE
    fi

done 
