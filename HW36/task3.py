#!/usr/bin/python3.8


def string_split(str):
    sub_str_start=0
    l=0
    for i in range(len(str)):
        if (str[i]=='\\'):
            l=l+1
            print("Подстрока ",l," ",str[sub_str_start:i])
            sub_str_start=i+1
print("-----------------------------------------------")
str="qqwweerrgrg\\eee\\ee\\ewefwg\\koi656u\\"
print("Строка - ",str)
string_split(str)

print("------------------------------------------------")
str="qqwweerrgrg\\e\\ee9609486@#$%^&\\ewefwg\\koi656u\\"
print("Строка - ",str)
string_split(str)

print("------------------------------------------------")
str="\e\\ee9609486@#$%^&\\ewefwg\\koi656u\\"
print("Строка - ",str)
string_split(str)
