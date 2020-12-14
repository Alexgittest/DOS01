FROM ubuntu:20.04 AS builder
COPY . /tmp
RUN /tmp/1.sh >> /tmp/1.html

FROM nginx:latest AS nginx-test
COPY --from=builder /tmp/1.html /usr/share/nginx/html/index.html
RUN nginx
