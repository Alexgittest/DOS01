#! /bin/bash
apt-get -y update
apt-get install -y nginx
apt install net-tools
echo "<!DOCTYPE html>
<html>
<head>
<title>Welcome to Server1</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to Server!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working.</p>

<p><em>Thank you for using our website</em></p>
</body>
</html>" > /var/www/html/index.html