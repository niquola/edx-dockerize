FROM ubuntu:14.04
MAINTAINER Nikolay Ryzhikov <niquola@gmail.com>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y rsyslog bash sudo openssl ca-certificates build-essential software-properties-common python-software-properties curl git-core libxml2-dev libxslt1-dev libfreetype6-dev python-pip python-apt python-dev
RUN pip install --upgrade pip
RUN pip install --upgrade virtualenv

RUN mkdir /var/edx && cd /var/edx && git clone -b release https://github.com/edx/configuration
RUN cd /var/edx/configuration && pip install -r requirements.txt

# edx local role

RUN apt-get install -y python-mysqldb mysql-server-5.5 postfix
COPY mysql.sql /var/edx/
RUN  service mysql start && mysql -uroot < /var/edx/mysql.sql && service mysql stop

RUN apt-get install -y memcached

# RUN cd /var/edx/configuration/playbooks && ansible-playbook -c local ./edx_sandbox.yml -i "localhost,"

