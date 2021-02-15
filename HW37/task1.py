#!/usr/bin/python3.8

class calculator1:
    def __init__(self,x,y):
        self.x=int(x)
        self.y=int(y)
        print("x=",self.x)
        print("y=",self.y)
    def sum(self):
        print("x+y=",self.x+self.y)
    def dif(self):
        print("x-y=",self.x-self.y)
    def multiple(self):
        print("x*y=",self.x*self.y)
    def devide(self):
        try:
            print("x/y=",self.x/self.y)
        except ZeroDivisionError as error:
            print("Деление на 0")

a=calculator1(3,5)
a.sum()
a.dif()
a.multiple()
a.devide()



class calculator2:
    def __init__(self,x=1,y=1,operation="None"):
        self.x=int(input("Введите X "))
        self.y=int(input("Введите Y "))
        self.operation=input("Выберите операцию\n 1:сумма \n 2:вычитание\n 3:умножение\n 4:деление \n ")
        print("x=",self.x)
        print("y=",self.y)
        if self.operation == 'сумма' or self.operation == '1':
            print("x+y=",self.x+self.y)
        elif self.operation == 'вычитание' or self.operation == '2':
            print("x-y=",self.x-self.y)
        elif self.operation == 'умножение' or self.operation == '3':
            print("x*y=",self.x*self.y)
        elif self.operation == 'деление' or self.operation == '4':
            try:
                print("x/y=",self.x/self.y)
            except ZeroDivisionError as error:
                print("Деление на 0")
        else:
            print("Операция не выбрана")


b=calculator2()