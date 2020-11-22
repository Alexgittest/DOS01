#!/bin/bash

echo "Тип ОС"
echo `uname -o`
echo "Имя ОС"
echo `uname -n`
echo "Версия ядра"
echo `uname -v`
echo "Ip адрес"
echo `ifconfig | grep 192.168.226 | tr -s [:blank:] : | cut -d : -f  3`
echo "LA за последние 15 минут"
echo `cat /proc/loadavg | cut -d ' ' -f 3 `
echo "Время работы системы"
echo `uptime| cut -d, -f 1`
echo "Информацию об использованной RAM"
echo `free --si -h | grep Mem | tr -s [:blank:] : | cut -d : -f3`
echo "Информацию об авторизованных пользователях"
echo `who | cut -d ' ' -f1`

