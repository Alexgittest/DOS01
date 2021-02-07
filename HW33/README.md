1)Развернуть mysql и подкинуть нужную конфигурацию через ansible
        db_install_role.yml
	mysql-db-role/ - директория с ролью
2)Посмотреть файл my.cnf, как его тюнить.
3)Дополнить таблицу с корзиной в базе данных shop, с которой работали на уроке
4)Посчитать суммарную корзину покупок для каждого из пользователей и отсортировать по порядку
select customer.name, sum(product.price) as total  from customer join cart on customer.id=cart.customer_id join product on cart.product_id=product.id GROUP BY customer.name ORDER BY customer.name ; 

5)*Развернуть через ansible mysql master и слейву с репликацией(1 мастер и 2 слейва)
        db_install.yml - ansible playbook для разворачивания 3 mysql в docker конетйнерах
	db_create.yml - ansible playbook для создание БД shop на master и создание репликации на slave DB 
	docker-compose.yml - файл docker-compose для создание 3 контейнеров mysql в отдельной сети. 
	                     Для репликации по паролю нужно использовать default-authentication-plugin=mysql_native_password
        Dockerfile_* - dockerfiles для mysql master/slave 
	my.cnf_* - конфига для mysql master/slave серверов
	shop.sql - дамп базы shop 
