#!/bin/bash 

CONDITION=1

while  [ $CONDITION -eq 1  ]
 do 
  echo "Введите имя пользователя"
  read user_name 
  if   
   cat /etc/passwd | cut -d : -f1 | grep $user_name
   then
    CONDITION=1
    echo "Введенный пользователь уже создан"
   else
    CONDITION=0
  fi 
done

echo "Введите домашний каталог"
read home_dir

sudo useradd -d /home/$home_dir -m $user_name
