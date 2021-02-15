#!/usr/bin/python3.8

class Student:
    def __init__(self,text:str):
        all=text.split(":")
        self.name=all[0]
        self.surname=all[1]
        self.class_num=all[2]
        self.result=all[3]
        print("Name=",self.name)
        print("Surname=",self.surname)
        print("Class=",self.class_num)
        print("Result=",self.result)

student1=Student("Alex:King:10:10")
