t#!/bin/bash

>settings.txt
read -p "enter your cpu threshold % : " cpu_threshold && echo "cpu_threshold=$cpu_threshold" >> settings.txt
read -p "enter your memory threshold % : " ram_threshold && echo "ram_threshold=$ram_threshold" >> settings.txt
read -p "enter your disk threshold % : " disk_threshold && echo "disk_threshold=$disk_threshold" >> settings.txt
read -p "enter your recieving mail : " email && echo "email=$email" >> settings.txt
read -p "executing the script every (min) : " min && echo "min=$min" >> settings.txt

echo "*/$min * * * * $PWD/main.sh" | crontab -
