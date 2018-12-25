# Cannot use docker since no systemd in centos images

curl -sL https://rpm.nodesource.com/setup_8.x | sudo bash -
sudo cp nginx.repo /etc/yum.repos.d/nginx.repo
sudo yum install nginx -y
sudo cp nginx.conf /etc/nginx/nginx.conf
sudo yum install epel-release -y

sudo yum install postgresql postgresql-server -y
sudo service postgresql initdb 
sudo chkconfig postgresql on
sudo sed -i "s/ident/trust/g" /var/lib/pgsql/data/pg_hba.conf
sudo service postgresql restart

cd /tmp
sudo -u postgres psql -c "CREATE DATABASE onlyoffice;"
sudo -u postgres psql -c "CREATE USER onlyoffice WITH password 'onlyoffice';"
sudo -u postgres psql -c "GRANT ALL privileges ON DATABASE onlyoffice TO onlyoffice;"

sudo yum install redis -y
sudo service redis start
sudo systemctl enable redis

sudo yum install rabbitmq-server -y
sudo service rabbitmq-server start
sudo systemctl enable rabbitmq-server

sudo yum -y install http://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm
sudo yum install onlyoffice-documentserver-ie -y

sudo service supervisord start
sudo systemctl enable supervisord
sudo service nginx start
sudo systemctl enable nginx

sudo bash documentserver-configure.sh
