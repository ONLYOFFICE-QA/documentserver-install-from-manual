FROM ubuntu:22.04

LABEL maintainer="shockwavenn@gmail.com"
ENV TZ=Etc/UTC
ENV DS_PRODUCT=onlyoffice-documentserver
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

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
RUN wget --retry-on-http-error=500 -qO - "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xe09ca29f6e178040ef22b4098320ca65cb2de8e5" | \
    gpg --dearmor > /usr/share/keyrings/onlyoffice.gpg
RUN sudo echo "deb http://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list
RUN echo ${DS_PRODUCT} onlyoffice/db-pwd select onlyoffice | sudo debconf-set-selections && \
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
RUN service postgresql start && \
    sudo apt-get update && sudo apt-get -y install ${DS_PRODUCT}
RUN sed -i "s/bind .*/bind 127.0.0.1/g" /etc/redis/redis.conf # https://github.com/antirez/redis/issues/5055 
CMD service postgresql start && \
    service rabbitmq-server start && \
    service redis-server start && \
    service nginx start && \
    service supervisor start && \
    supervisorctl start all && \
    bash
