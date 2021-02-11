#!/usr/bin/python3.8

def odd_or_even(x,y):
    if (x%2==0) and (y%2==0):
        print("Числа четные")
    elif (x%2!=0) and (y%2!=0):
        print("Числа нечетные")
    else:
        print("a - b = ",x-y)


digit=False
while digit==False:
    a=input("Число a - ")
    b=input("Число b - ")
    if a.isdigit() and b.isdigit():
        digit=True
    else:
        print("Введены не числа.Еще раз.")  

odd_or_even(int(a),int(b))

