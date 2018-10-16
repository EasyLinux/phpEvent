FROM alpine:3.8
LABEL author="Serge NOEL <serge.noel@net6a.com>"

RUN apk update
RUN apk add php5-apache2 php5-gd php5-imap php5-ldap php5-mysqli php5-curl
RUN mkdir /run/apache2
RUN mkdir /var/www/html
RUN  sed -i 's|/var/www/localhost/htdocs|/var/www/html|g' /etc/apache2/httpd.conf

# Récupérer phpEventCalendar
WORKDIR /tmp
RUN wget https://phpeventcalendar.com/eventcalendar/download/phpEventCalendar_Lite.zip
RUN unzip phpEventCalendar_Lite.zip
RUN cd phpEventCalendar_Lite
RUN mv phpEventCalendar_Lite/* /var/www/html
RUN rm -rf *

WORKDIR /var/www/html
EXPOSE 80
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
