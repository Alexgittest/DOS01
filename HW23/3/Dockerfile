FROM nginx:latest
RUN apt update && apt install -y iputils-ping net-tools
CMD ["ping","-c","5","www.google.com"]
