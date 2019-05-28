FROM ubuntu:18.04

LABEL maintainer="shockwavenn@gmail.com"

RUN apt-get update && apt-get install -y curl \ 
                                         gnupg \
                                         sudo

RUN sudo apt-get update && sudo apt-get install -y postgresql
RUN service postgresql start && \
    sudo -u postgres psql -c "CREATE DATABASE onlyoffice;" && \
    sudo -u postgres psql -c "CREATE USER onlyoffice WITH password 'onlyoffice';" && \
    sudo -u postgres psql -c "GRANT ALL privileges ON DATABASE onlyoffice TO onlyoffice;"
RUN sudo apt-get update && sudo apt-get install -y redis-server
RUN sudo apt-get update && sudo apt-get install -y rabbitmq-server
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
RUN sudo echo "deb http://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list
RUN echo onlyoffice-documentserver-ie onlyoffice/db-pwd select onlyoffice | sudo debconf-set-selections
RUN service postgresql start && \
    sudo apt-get update && sudo apt-get -y install onlyoffice-documentserver-ie
RUN sed -i "s/bind .*/bind 127.0.0.1/g" /etc/redis/redis.conf # https://github.com/antirez/redis/issues/5055 
CMD service postgresql start && \
    service rabbitmq-server start && \
    service redis-server start && \
    service nginx start && \
    service supervisor start && \
    supervisorctl start all && \
    bash
