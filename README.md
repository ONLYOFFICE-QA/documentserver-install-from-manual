# onlyoffice-documentserver-install-from-manual

Install Documentserver on ubuntu using [manual](http://helpcenter.onlyoffice.com/server/linux/document/linux-installation.aspx)

```bash
docker build -t onlyoffice-documentserver-install-from-manual **OPERATION_SYSTEM** && \
docker run -itd -p 80:80 --name onlyoffice-documentserver-install-from-manual onlyoffice-documentserver-install-from-manual
```

## Centos

For checking release installation on CentOS use

```bash
cd Centos7
bash install.sh
```

For checking custom branch edit `Centos7/onlyoffice.repo` file accordingly and run

```bash
cd Centos7
bash install.sh custom-repo
```
