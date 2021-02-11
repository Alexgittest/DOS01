#!/usr/bin/python3.8
import random


def game():
    print("R - камень, S - ножницы, P - бумага")
    man_choice=input('Ваш выбор ')
    sequence=['R','S','P']
    pc_choice=random.choice(sequence)
    print("Компьютер выбрал ",pc_choice)
    if (man_choice=='R' and pc_choice=='S') or (man_choice=='S' and pc_choice=='P') or (man_choice=='P' and pc_choice=='R'):
        print("-------------------")
        print("   Вы победили!!")
        print("-------------------")
    elif (man_choice=='R' and pc_choice=='R') or (man_choice=='S' and pc_choice=='S') or (man_choice=='P' and pc_choice=='P'):
        print("-----------------")
        print("     Ничья") 
        print("-----------------")
    else:
        print("----------------------")
        print("   Компьютер победил") 
        print("----------------------")

AGAIN=True
while AGAIN :
     game()
     while AGAIN!=True or AGAIN!=False:
         AGAIN=input("Повторить - Y-да, N-нет ")
         if AGAIN=='Y' or AGAIN=='y':
             AGAIN=True
             break
         elif AGAIN=='N' or AGAIN=='n':
             AGAIN=False
             break
         else:
             print("Неверный выбор.Сделайте выбор еще раз.")
             AGAIN=None

