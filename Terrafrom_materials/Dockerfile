FROM docker.io/redhat/ubi9
RUN yum update -y && yum install httpd -y &&yum install wget -y && yum install zip -y
RUN wget https://www.free-css.com/assets/files/free-css-templates/download/page296/mediplus-lite.zip
RUN unzip mediplus-lite.zip -d /mnt
RUN cp -rvf /mnt/mediplus-lite/* /var/www/html
EXPOSE 80
CMD ["httpd", "-D","FOREGROUND"]
