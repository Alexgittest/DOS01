#!/usr/bin/python3.8


string1=input('Введите строку 1 ')
string2=input('Введите строку 2 ')
print("--------------------")
for i in  range(len(string1)):
 for j in range(len(string2)):
  if string1[i] == string2[j]:
   print(string1[i]+"-Первая строка = ",i+1)
   print(string2[j]+"-Вторая строка = ",j+1)
   print("-----------------------")

