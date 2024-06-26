this bash script runs frequently in your machine (every 5min for ex), makes system ressources checking (RAM, CPU, DISK), then compares them with thresholds that you set, if any of the ressources is higher than the normal state, you will recieve an alert instantly via email,

first you need to configure an external SMPT, i'm using Gmail,

###.step 1 : install ssmtp and mailutils 

Debian/Ubuntu : 
# sudo apt-get install ssmtp mailutils

CentOS/RHEL :
# sudo yum install mailx

###.step 2 : configure ssmpt file : 

# sudo nano /etc/ssmtp/ssmtp.conf

root=postmaster
mailhub=smtp.gmail.com:587
AuthUser=your-email@gmail.com
AuthPass=password
UseTLS=YES
UseSTARTTLS=YES
rewriteDomain=gmail.com
hostname=$hostname
FromLineOverride=YES

then we test by sending a simple mail : 
# echo "email body" | mail -s "Testing" destination-mail@gmail.com

probably you will face an authentication issue, so is recommended to make this change in ssmtp.conf
instead of using the real gmail password (AuthPass=password)
go to google account > security > App passowrd > give it a name and you will get an app password 
like this one "aynz jelw zdfk oxgp", remove spaces and place it in AuthPass=

###.step 3 : execute the script

give the necesery permissions for main.sh and setup.sh
# chmod +x main.sh setup.sh

The setup script will:

. Prompt you to set thresholds for CPU, RAM, and Disk usage.
. Ask for the periodic execution interval (e.g., every 5 minutes).
. Automatically create a cron job to execute main.sh , that will create automaticaly a cron job to execute main.sh , you can cancel it after by opening Crontab file using this command :
# crontabe -e 
then delete the line that schedules the main.sh script



