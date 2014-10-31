FROM ubuntu:14.04
MAINTAINER Nikolay Ryzhikov <niquola@gmail.com>

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y rsyslog bash sudo openssl ca-certificates build-essential software-properties-common python-software-properties curl git-core libxml2-dev libxslt1-dev libfreetype6-dev python-pip python-apt python-dev
RUN pip install --upgrade pip
RUN pip install --upgrade virtualenv

RUN mkdir /var/edx && cd /var/edx && git clone -b release https://github.com/edx/configuration
RUN cd /var/edx/configuration && pip install -r requirements.txt

# EDX LOCAL ROLE
######################

RUN apt-get install -y python-mysqldb mysql-server-5.5 postfix
COPY mysql.sql /var/edx/
RUN  service mysql start && mysql -uroot < /var/edx/mysql.sql && service mysql stop

RUN apt-get install -y memcached


# EDX MONGO
######################

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

RUN apt-get update && apt-get install -y mongodb-org

# Create the MongoDB data directory
RUN mkdir -p /data/db

RUN pip install pymongo==2.6.3

# Expose port #27017 from the container to the host
EXPOSE 27017
# RUN /usr/bin/mongod


# EDXAPP
##########################

RUN useradd -m -s /bin/bash edxapp && echo "edxapp:edxapp"|chpasswd && adduser edxapp sudo

RUN mkdir /home/edxapp/data && \
    mkdir /home/edxapp/venus && \
    mkdir /home/edxapp/theme && \
    mkdir /home/edxapp/staticfile && \
    mkdir /home/edxapp/course_static && \
    mkdir /home/edxapp/course_data && \
    chown -R edxapp /home/edxapp

RUN add-apt-repository -y ppa:chris-lea/node.js && apt-get update

RUN apt-get install -y \
  build-essential \
  s3cmd \
  pkg-config \
  graphviz-dev \
  graphviz \
  libmysqlclient-dev \
  gfortran \
  liblapack-dev \
  g++ \
  libxml2-dev \
  libxslt1-dev \
  apparmor-utils \
  curl \
  ipython \
  nodejs \
  ntp \
  libgeos-dev \
  gettext \
  libjpeg8-dev \
  libpng12-dev \
  libfreetype6-dev

RUN mkdir /home/edxapp/log && chown -R edxapp /home/edxapp/log

# py sandbox

#TODO: RUN update-alternatives --set libblas.so.3gf /usr/lib/libblas/libblas.so.3gf
#TODO: RUN update-alternatives --set liblapack.so.3gf /usr/lib/lapack/liblapack.so.3gf
#SKIPPED
#RUN useradd -m -s /bin/bash sandbox && mkdir /home/sandbox/code && chown -R sandbox /home/sandbox
