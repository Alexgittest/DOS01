#### Описание файлов

1. HW31/ansible.cfg - конфига ansible
2. HW31/hosts - интвентори файл
3. HW31/docker_install_ubuntu.yml - Ansible плейбук для утановки docker
4. HW31/start_tmp_nginx_cont - Ansible плейбук для развертывания временых контейнеров nginx-tmp и certbot
5. HW31/index.html - index.html для nginx
6. HW31/nginx.conf - nginx.conf для временого контейнера nginx-tmp
7. HW31/start_nginx_lb.yml - Ansible плейбук для развертывания 3 контейнером adminer и контейнера c nginx(с ssl сертификатом) как балансировщика.
8. HW31/nginx_ssl.conf - конфига nginx c ssl для балансировки
9. HW31/docker-compose.yml - docker-compose.yml файл для развертывания 3-х контейнеров adminer и 1 контейнера nginx.
10. HW31/Dockefile - для создания контейнера nginx и копирования в него файла конфигурации и приватного_ключа/сертификата ssl


 Переменные в Ansible плейбуках :

1. директория на удаленном компьютере для копирования  docker-compose.yml
   - tmp_folder: /usr/nginx-lb 
2. директория на локальном компьютере с docker-compose.yml
   - tmp_folder_local: /TEST/ansible/NGINX_LB_ADMINER
   
В файлах nginx.conf,nginx_ssl.conf - заменить имя домена на своё.
   
#### Порядок запуска

1. Если на удаленном компьютере не установлен сервис Docker тогда запускаем  docker_install_ubuntu.yml
   (в файле поменять хост и sudo пароль)
2. Зарегистрировать домен и добавить для него DNS запись (делается у регистратора домена на сайте)
3. Далее нужно получить сертификат Let’s Encrypt.
   Let’s Encrypt делает две проверки:
   - смотрит есть ли A запись на DNS сервере для имя_домена и запись A для www.имя_домена
   - шлет GET запрос на имя домена
   Если обе проверки прошли тогда certbot создает в директории .well-known/acme-challenge файл и генерирует сертификат.
   Поэтому для получения сертификата нужно чтобы web сервер был доступен для этого переходим к пункту 4.
4. Поднимаем временный nginx-tmp контейнер на порту 80 для получения сертификатаи контейнер certbot.
   nginx.conf конфигурация для временого контейнера nginx-tmp
   Для этого запускаем Ansible плейбук start_tmp_nginx_cont
5. Certbot положит ссылки на сертификат в директорию  tmp_folder/etc/letsencrypt/live/имя_домена/
   Сам сертификат и ключи будут лежать в tmp_folder/etc/letsencrypt/archive/имя_домена/
6. Дальше запускаем Ansible плейбук start_nginx_lb.yml, который создаст nginx-lb контейнер и 3 контейнера APP (Adminer) через docker compose.
   Конфигурация nginx-lb c ssl находиться в файле nginx_ssl.conf
   Контейнер nginx-lb создается из Dockerfile 




