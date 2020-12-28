1.	Повторить все команды, которые разбирали на практике (установка nginx на ubuntu и centos)

    HW25/task1.txt

2. Установить докер и docker-compose на машины с убунту и на centos

    HW25/task2.yml

3.	Развернуть приложение voting-app, используя docker-compose

    HW25/task3.yml
    
Inventory file - hosts.

Если при запуске HW25/task3.yml появляется следующая ошибка:

>  FAILED! => {"changed": false, "msg": "Failed to import the required Python library (Docker SDK for Python: docker (Python >= 2.7) or docker-py (Python 2.6)) on Centos_8.2_VM2's Python /usr/libexec/platform-python3.6. Please read the module documentation and install it in the appropriate location. If the required library is installed, but Ansible is using the wrong Python interpreter, please consult the documentation on ansible_python_interpreter, for example via `pip install docker` or `pip install  docker-py` (Python 2.6). The error was: cannot import name '__version__'"}


нужно на клиенте переустановить модуль docker для python:

pip3.6 install --ignore-installed  docker

