# onlyoffice-documentserver-install-from-manual

Install Documentserver on ubuntu using [manual](http://helpcenter.onlyoffice.com/server/linux/document/linux-installation.aspx)

```bash
docker build -t onlyoffice-documentserver-install-from-manual **OPERATION_SYSTEM** && \
docker run -itd -p 80:80 --name onlyoffice-documentserver-install-from-manual onlyoffice-documentserver-install-from-manual
```
