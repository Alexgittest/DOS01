
**1.Можно ли указать в докерфайле на базе ubuntu entrypoint sleep 20 ?**

Можно задав:
FROM ubuntu:20.04
ENTRYPOINT ["sleep", "20"]

   или

FROM ubuntu:20.04
ENTRYPOINT sleep 20

**2.Создать два контейнера, с приложением и базой в разных подсетях, организовать взаимодействие. **

Добавить сети:
  docker network create --driver bridge my-net1
  docker network create --driver bridge my-net2


Посмотреть как называются сетевые адаптеры

  ifconfig | grep br- | cut -d : -f1
  br-59407388d1d7
  br-82e233cdbe5d


Добавить правило в iptables для интереконнекта между созданными сетями Docker т.к. по умолчанию взаимодейсиве запрещено

  sudo iptables -I DOCKER-ISOLATION-STAGE-2 -o br-59407388d1d7 -i br-82e233cdbe5d -j ACCEPT
  sudo iptables -I DOCKER-ISOLATION-STAGE-2 -o br-82e233cdbe5d -i br-59407388d1d7 -j ACCEPT


Создать два контейнера с базой MySQL и Adminer
  docker run --name mysql-test -e MYSQL_ROOT_PASSWORD=password1 --link adminer:adminer --network my-net1 -d mysql 
  docker run --link mysql-test:db --network my-net2 adminer

Затем 
  docker network inspect my-net1
  docker network inspect my-net2

Посмотреть какие адреса выдались контейнерам и зайти по web на adminer контейнер порт 8080 и
проверить подключение к базе 

**3.Написать Dockerfile с приложением и разместить его в изолированной сети. И можно ли в Dockerfile создать сеть**

---DOCKERFILE---
  FROM nginx:latest
  RUN apt update && apt install -y iputils-ping net-tools
  CMD ["ping","-c","5","www.google.com"]

Для сборки и запуска:
  docker build -t test1:v1  .

docker run --network=my-net2 test1:v1

В Docker файле нельзя задать сеть

**4.Развернуть через docker-compose example voting app, что разбирали на лекции. Сделать тоже самое без docker-compose**

  git clone https://github.com/dockersamples/example-voting-app.git

  docker-compose up

Если не использовать docker-compose то:
При этом используем созданные и скачанные образы. Если образы не созданы тогда в скаченном из git запустить Dockerfile.

--------
  vote container

docker run -d --name vote -p 5000:80 --mount type=bind,source=/TEST/docker/compose/example-voting-app/vote,target=/app example-voting-app_vote:latest python app.py

docker network connect example-voting-app_back-tier aaf1bf8e3dc9

docker network connect example-voting-app_front-tier aaf1bf8e3dc9

--------
  result container

docker run -d --name result -p 5001:80 -p 5858:5858 --mount type=bind,source=/TEST/docker/compose/example-voting-app/result,target=/app example-voting-app_result:latest nodemon server.js

docker network connect example-voting-app_back-tier result

docker network connect example-voting-app_front-tier result

--------
redis container

docker run -d --name redis -p 6379:6379 redis:alpine

docker network connect example-voting-app_back-tier redis


--------
db container

docker run -d --name db --mount source=example-voting-app_db-data,target=/var/lib/postgresql/data -e POSTGRES_USER:postgres -e POSTGRES_PASSWORD:postgres  postgres:9.4

docker network connect example-voting-app_back-tier db

---------
worker container

docker run -d --name worker example-voting-app_worker:latest

docker network connect example-voting-app_back-tier worker

--------


**5. Посмотреть, что такое multistaged docker containers. Показать реализацию**

Нужны в основном для того чтобы собирать приложение в одном контейнере а результаты сборки использовать в другом(их) контейнерах.
Или любые результаты работы первого контейнера использовать в других, при этом не нужно много DOCKERFILE для разных контейнеров
все этапы можно описать в одном


---СБОРКА:---
  docker build -t nginx-test:v1 .
  docker run -p 8080:80  nginx-test:v1

---DOCKERFILE---
  FROM ubuntu:20.04 AS builder
  COPY . /tmp
  RUN /tmp/1.sh >> /tmp/1.html

  FROM nginx:latest AS nginx-test
  COPY --from=builder /tmp/1.html /usr/share/nginx/html/index.html
  RUN nginx
















