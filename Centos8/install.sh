# Cannot use docker since no systemd in centos images
set -e

DS_PRODUCT=onlyoffice-documentserver-ee

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
cd -

sudo yum install redis -y
sudo service redis start
sudo systemctl enable redis

sudo rpm --import https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc
sudo cp rabbitmq.repo /etc/yum.repos.d
sudo yum install rabbitmq-server -y
sudo service rabbitmq-server start
sudo systemctl enable rabbitmq-server

if [ "$#" -ne 1 ]; then
    sudo yum -y install http://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm
else
    sudo cp onlyoffice.repo /etc/yum.repos.d/onlyoffice.repo
fi

sudo yum install ${DS_PRODUCT} -y

sudo service supervisord start
sudo systemctl enable supervisord
sudo service nginx start
sudo systemctl enable nginx

printf 'localhost\nonlyoffice\nonlyoffice\nonlyoffice\nlocalhost\nlocalhost\nguest\nguest\n' | sudo documentserver-configure.sh
sudo supervisorctl start all
