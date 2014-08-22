FROM vinelab/base

MAINTAINER Abed Halawi <abed.halawi@vinelab.com>

# update packages
RUN yum -y update
# install package repo dependencies
RUN yum -y install http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
RUN wget -O /etc/yum.repos.d/hop5.repo http://www.hop5.in/yum/el6/hop5.repo
# install nginx
RUN yum install -y nginx
# install hhvm
RUN yum install -y hhvm
# make the php-cli available as a link to the hhvm compiler
# so that when someone runs php file.php it just works.
RUN ln -s /usr/bin/hhvm /usr/bin/php
# add hhvm files
ADD hhvm.conf /etc/nginx/
ADD hhvm.ini /etc/supervisord.d/
# install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer
# setup nginx
RUN mkdir /var/www
RUN chown -R nginx:nginx /var/www
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default
ADD app.conf /etc/nginx/conf.d/app.conf
ADD nginx.conf /etc/nginx/
ADD nginx.ini /etc/supervisord.d/
