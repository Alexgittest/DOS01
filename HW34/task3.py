#!/usr/bin/python3.8
import math 
a=[None,None]
b=[None,None]

a[0]=int(input('Координата x1 '))
a[1]=int(input('Координата y1 '))


b[0]=int(input('Координата x2 '))
b[1]=int(input('Координата y2 '))

print("Расстояние между точками = "+str(math.sqrt((b[0]-a[0])**2+(b[1]-a[1])**2)))
