
#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
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

RUN apt-get -y install php5-cli php5-common php5-mysql php5-xdebug libapache2-mod-php5
RUN add-apt-repository ppa:ondrej/php5-5.6 -y
RUN apt-get update 
#RUN apt-get upgrade -y
RUN apt-get install python-software-properties -y
RUN apt-get update
RUN apt-get install php5 --force-yes -y
RUN php5 -v
RUN apt-get install curl php5-curl --force-yes –y






RUN curl -sS https://getcomposer.org/installer | php
COPY composer.phar /usr/local/bin/composer
#RUN mv composer.phar /usr/local/bin/composer
RUN apt-get -y install php5-xsl --force-yes
RUN find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;
RUN find /etc/php5/cli/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

RUN apt-get -y install mcrypt php5-mcrypt --force-yes
RUN php5enmod mcrypt
RUN service apache2 restart
COPY resolv.conf /etc/
RUN apt-get install -y openssh-server
RUN sed -i 's|session required pam_loginuid.so|session optional pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

RUN adduser --quiet jenkins

RUN echo "jenkins:jenkins" | chpasswd

ADD . /var/www/html/phpapp/
#RUN rm -rf composer.lock vendor/

RUN apt-get -y install apache2 --force-yes
RUN apt-get install nano
RUN rm -f /etc/apache2/mods-available/dir.conf
COPY dir.conf /etc/apache2/mods-available/
#-----------------------------------------------------------------------------------
COPY almtaskmanager.conf /etc/apache2/sites-available/
RUN ln -s /etc/apache2/sites-available/almtaskmanager.conf /etc/apache2/sites-enabled
#-----------------------------------------------------------------------------------
#RUN rm -f /etc/resolv.conf
#COPY resolv.conf /etc/               
COPY auth.json /root/.composer/
COPY auth.json /home/jenkins/.composer/
COPY auth.json /home/ajinkyab/.composer/
RUN chmod -R 755 /root/.composer/auth.json 



#RUN apt-get update
#RUN apt-get install wget
#RUN wget http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip
#RUN apt-get install unzip
#RUN unzip sonar-runner-dist-2.4.zip
#COPY sonar-runner-2.4 /opt/sonar-runner

ENV APP_PATH /var/www/html/phpapp
WORKDIR $APP_PATH/
EXPOSE 80
CMD ["service apache2 start"]





