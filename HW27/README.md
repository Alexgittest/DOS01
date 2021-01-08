Создать ansible роль для установки nginx, в роли должен быть шаблон nginx.conf.j2 (в темплейте должны быть for, if и default значения)

ansible-galaxy init nginx_test - инициализация роли

ansible.cfg - конфигурационный файл Ansible
hosts - Inventory файл
install_nginx.yml - плейбук для установки роли nginx_test
nginx_test/ - каталог с ролью
