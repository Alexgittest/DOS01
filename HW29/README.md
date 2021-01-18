#### 1.	Можно ли передать переменную окружения в ansible

     vars:
       local_pwd: "{{ lookup('env','PWD') }}"

#### 2.	Привести пример модуля и плагина в ansible

Плагины: lookup, become, shell, vars, connection
Модули: yum,copy,systemd


#### 3.	Развернуть nginx c lua модулем через ansible

HW29/nginx_with_lua.yml   - playbook без переменных
HW29/nginx_with_lua2.yml – playbook с перемеными

#### 4.	Проверить работоспособность
nginx –v
##### 5.	Установить apache jmeter для тестирования нагрузки веб серверов (лучше сделать через ansible и установить сервер, и воркеры на других машинах).
HW29/apache_jmeter_install.yml - playbook для установки
Если появляется ошибка при запуске:
    ```
    INFO: Created user preferences directory.
    Server failed to start: java.rmi.server.ExportException: Listen failed on port: 0; nested exception is: 
    java.io.FileNotFoundException: rmi_keystore.jks (No such file or directory)
    An error occurred: Listen failed on port: 0; nested exception is: 
    java.io.FileNotFoundException: rmi_keystore.jks (No such file or directory)
    ```
    нужно в файле jmeter.properties задать:
    **server.rmi.ssl.disable=true**
    Если при запуске на Ubuntu появляется ошибка: 
    ```
    Server failed to start: java.rmi.RemoteException: Cannot start. ubuntu is a loopback address.
     An error occurred: Cannot start. ubuntu is a loopback address.
    ```
    запускать со следующим ключом:
    **./jmeter-server -Djava.rmi.server.hostname=ip_address**


