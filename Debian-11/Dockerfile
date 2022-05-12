FROM debian:bullseye

LABEL maintainer="shockwavenn@gmail.com"

ENV DS_PRODUCT=onlyoffice-documentserver-ee
RUN apt-get update && apt-get install -y curl sudo gnupg
RUN sed -r -i 's/^deb(.*)$/deb\1 contrib/g' /etc/apt/sources.list

RUN sudo apt-get update && sudo apt-get install -y postgresql
RUN service postgresql start && \
    sudo -u postgres psql -c "CREATE DATABASE onlyoffice;" && \
    sudo -u postgres psql -c "CREATE USER onlyoffice WITH password 'onlyoffice';" && \
    sudo -u postgres psql -c "GRANT ALL privileges ON DATABASE onlyoffice TO onlyoffice;"
RUN sudo apt-get update && sudo apt-get install -y redis-server
RUN sudo apt-get update && sudo apt-get install -y rabbitmq-server
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
RUN sudo echo "deb http://download.onlyoffice.com/repo/debian squeeze main" | sudo tee /etc/apt/sources.list.d/onlyoffice.list
RUN echo ${DS_PRODUCT} onlyoffice/db-pwd select onlyoffice | sudo debconf-set-selections && \
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
RUN service postgresql start && \
    sudo apt-get update && sudo apt-get -y --force-yes install ${DS_PRODUCT}
CMD service postgresql start && \
    service rabbitmq-server start && \
    service redis-server start && \
    service nginx start && \
    service supervisor start && \
    supervisorctl start all && \
    bash
