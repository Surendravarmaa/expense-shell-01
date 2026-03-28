#!/bin/bash

source ./common.sh

check_root

echo "Please enter DB password:"
read -s mysql_root_password

dnf install mysql-server -y  &>> $LOGFILE

systemctl enable mysqld &>> $LOGFILE

systemctl start mysqld &>> $LOGFILE

#Below code will be useful for idempotent nature
mysql -h 172.31.15.21  -uroot -p${mysql_root_password} -e 'show databases;' &>> $LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installationnmnm --set-root-pass ${mysql_root_password} &>> $LOGFILE
else
    echo -e "MySQL root password is already setup...$Y SKIPPING $N" 
fi