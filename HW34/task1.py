#!/usr/bin/python3.8


s=input('Введи строку английских символов ')

total=s.count('a')+s.count('e')+s.count('i')+s.count('o')+s.count('u')+s.count('y')

print("количества строчных гласных букв английского алфавита в фразе = "+str(total))
print("Из них символ 'a' встречается "+str(s.count('a'))+" раз")
print("Из них символ 'e' встречается "+str(s.count('e'))+" раз")
print("Из них символ 'i' встречается "+str(s.count('i'))+" раз")
print("Из них символ 'o' встречается "+str(s.count('o'))+" раз")
print("Из них символ 'u' встречается "+str(s.count('u'))+" раз")
print("Из них символ 'y' встречается "+str(s.count('y'))+" раз")

