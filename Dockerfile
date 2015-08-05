FROM linuxserver/baseimage
MAINTAINER smdion <me@seandion.com>, Mark Burford <sparklyballs@gmail.com>, Stian Larsen <lonix@linuxserver.io>, Kode <kodestar@linuxserver.io>


# expose ports
EXPOSE 80
EXPOSE 443

# set volume
VOLUME /config

# update apt and install nginx
RUN apt-get update && \
apt-get install \
nginx \
php5-fpm \
php5-mysql \
php5 \
php5-cli \
php5-mcrypt \
php5-curl -y && \
apt-get clean -y && \
rm -rf /var/lib/apt/lists/*

#Adduser abc
RUN useradd -u 911 -U -s /bin/false abc
RUN usermod -G users abc

#Adding Custom files
RUN mkdir -p /defaults
ADD defaults/ /defaults/ 
ADD services/ /etc/service/
ADD init/ /etc/my_init.d/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh
