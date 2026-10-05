#!/bin/bash

# color codes
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo -e "$G Hello World $N"
echo -e "$R Hello World $N"
echo -e "$Y Hello World $N"
echo "Check this color"

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

# below & represents either sucess or fail 
# whereas 1 represents log only when you see no errors, 
# 2 represents log only when you see error

dnf install mysql -y &>>$LOG_FILE 

if [ $? -ne 0 ]; then
   echo -e "$R ERROR$N:: Installing MySQL failed please check logs" | tee -a $LOG_FILE
   exit 1
else 
   echo -e "MySQL installation is $G successful $N" | tee -a $LOG_FILE
fi

VALIDATE() {  #functions will recieve input via cmd line arguments just like shell script args
   if [ $1 -ne 0 ]; then
       echo -e "$R ERROR$N:: Installing $2 failed please check logs" | tee -a $LOG_FILE
       exit 1 
   else 
       echo -e "$2 installation is $G successful$N" | tee -a $LOG_FILE
   fi 
}

dnf list installed mysql &>>$LOG_FILE
# Install only if it is not installed earlier
if [ $? -ne 0 ]; then
   dnf install mysql -y &>>$LOG_FILE
   VALIDATE $? "MySql"
else
   echo -e "MySql is already installed .... $Y SKIPPING $N" | tee -a $LOG_FILE
fi

dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]; then
   dnf install nginx -y &>>$LOG_FILE
   VALIDATE $? "Nginx"
else 
   echo -e "Nginx is already installed .... $Y SKIPPING $N" | tee -a $LOG_FILE
fi

dnf list installed python3 &>>$LOG_FILE 
if [ $? -ne 0 ]; then
   dnf install python3 -y &>>$LOG_FILE
   VALIDATE $? "Python3"
else 
  echo -e "Python3 is already installed .... $Y SKIPPING $N" | tee -a $LOG_FILE
fi  
