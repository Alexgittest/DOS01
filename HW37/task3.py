#!/usr/bin/python3.8

import mysql.connector
from mysql.connector import errorcode
import json
import getpass



host_ip=input("Введите ip адрес DB сервера  ")
user_name=input("Введите имя пользователя ")
user_password=getpass.getpass(prompt="Введите пароль ")

#try:
#    mydb=mysql.connector.connect(host="127.0.0.1",port=3306,user="alex",password="alex",database='shop')
#    cursor=mydb.cursor()
#except mysql.connector.Error as e:
#    print(e)


with open('./userlist.json','r') as file:
    file_data=file.read()

data=json.loads(file_data)

try:
    mydb=mysql.connector.connect(host=host_ip,port=3306,user=user_name,password=user_password,database='shop',connection_timeout=10)
    cursor=mydb.cursor()
    print('{:10}{:>10}'.format("Name","Value"))
    print("--------------------")
    for i in data['userList']['users']:
        name=i['name']
        email=i['email']
        query=("SELECT customer.name, sum(product.price) as total "
               "from customer "
               "join cart on customer.id=cart.customer_id "
               "join product on cart.product_id=product.id "
               "where customer.name="+"'"+name+"'"+" and customer.email="+"'"+email+"'")
        cursor.execute(query)
        for i in cursor:
             print("{:10}{:10}".format(i[0],i[1]))
except mysql.connector.Error as e:
    print("!!!!Не удалось подключиться, проверьте правильноть введенных данных!!!!")
