#!/bin/bash
CONDITION=1
while  (( $CONDITION == 1 ))
do
echo "Введите ip адрес удаленного сервера"
read IP
NUM=`echo $IP | awk -F "." '{print NF}'`
if (($NUM==4))
then
 NUM1=`echo $IP | awk -F "." '{print $1}'`
 NUM2=`echo $IP | awk -F "." '{print $2}'`
 NUM3=`echo $IP | awk -F "." '{print $3}'`
 NUM4=`echo $IP | awk -F "." '{print $4}'`
  if (( $NUM1<1 || $NUM1>223 )) || ((  $NUM2<0 || $NUM2>255 )) || ((  $NUM3<0 || $NUM3>255 )) || ((  $NUM4<0 || $NUM4>255 ))
   then
    echo "Неправилные числа в ip адресе"
    CONDITION=1
   else
    CONDITION=0
   fi
else 
 echo "Неправильно введен ip"
 CONDITION=1
fi
done

if [ -f /home/alex/test/file.tar.gz ]
 then
  echo "Have file"
  tar -xvf /home/alex/test/file.tar.gz -C /home/alex/test/
   if [ -f /home/alex/test/file3.txt ]
    then
     scp -i /home/alex/.ssh/id_rsa /home/alex/test23/file3.txt alex@$IP:/tmp
    else 
     echo "Данного файла нет"
    fi
 else 
  echo "Архива нет"
fi
RESULT=`ssh -i /home/alex/.ssh/id_rsa alex@$IP 'ls -l /tmp/file3.txt'`

echo $RESULT
