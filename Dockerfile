FROM ubuntu:14.04
MAINTAINER toru_kurahashi@eastback.jp

RUN apt-get update
RUN apt-get install -y apache2
RUN apt-get install -y php5
RUN apt-get install -y php5-mysqlnd

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

ADD ./webappinit /webappinit

RUN a2enmod rewrite
RUN php5enmod mysql

RUN perl -p -i -e "s/max_execution_time = 30/max_execution_time = 120/g" /etc/php5/apache2/php.ini
RUN perl -p -i -e "s#Directory /var/www#Directory /webapp#g" /etc/apache2/apache2.conf

RUN mv /webappinit/apache-default.conf /etc/apache2/sites-available/000-default.conf
RUN mv /webappinit/start.sh /start.sh && chmod a+x /start.sh

EXPOSE 80
VOLUME /webapp

CMD /start.sh
