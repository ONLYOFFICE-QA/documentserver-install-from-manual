# ubuntu-install-documentserver-from-manual
Install Documentserver on ubuntu using manual http://helpcenter.onlyoffice.com/server/linux/document/linux-installation.aspx

```
docker build -t ubuntu-install-documentserver-from-manual . && \
docker run -itd -p 80:80 --name ubuntu-install-documentserver-from-manual ubuntu-install-documentserver-from-manual