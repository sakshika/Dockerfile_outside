FROM ubuntu:14.04

# Install.
RUN apt-get update

#Install git
RUN apt-get install -y git  

#RUN apt-get install -y openjdk-7-jdk

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:webupd8team/java -y
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN apt-get install oracle-java8-installer -y
RUN apt-get install oracle-java8-set-default

RUN apt-get install -y zip
RUN apt-get install -y unzip
RUN apt-get install -y ant 

RUN apt-get update
RUN apt-get -y install php5-cli php5-common php5-mysql php5-xdebug libapache2-mod-php5

RUN curl -sS https://getcomposer.org/installer | php
RUN cp composer.phar /usr/local/bin/composer
RUN apt-get update
RUN apt-get -y install php5-xsl
RUN find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;
RUN find /etc/php5/cli/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

RUN apt-get -y install mcrypt php5-mcrypt
RUN php5enmod mcrypt
RUN service apache2 restart
RUN apt-get install -y openssh-server

#ADD . /var/www/html/phpapp/

RUN apt-get -y install apache2
RUN apt-get install nano
RUN rm -f /etc/apache2/mods-available/dir.conf

#ENV APP_PATH /var/www/html/phpapp
#WORKDIR $APP_PATH/


