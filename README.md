# onlyoffice-documentserver-install-from-manual

Install Documentserver on ubuntu using [manual](http://helpcenter.onlyoffice.com/server/linux/document/linux-installation.aspx)

```bash
docker build -t onlyoffice-documentserver-install-from-manual **OPERATION_SYSTEM** && \
docker run -itd -p 80:80 --name onlyoffice-documentserver-install-from-manual onlyoffice-documentserver-install-from-manual
```

## CentOS

For checking release installation on CentOS use

```bash
cd Centos7
bash install.sh
```

For checking non-released version use argument for command with version name

```bash
cd Centos7
bash install.sh 6.4.0-16
```
