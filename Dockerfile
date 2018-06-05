FROM ubuntu:14.04

ENV DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential libpcap0.8 && \
  apt-get install -y curl git htop iftop vim wget libpq-dev supervisor iotop  ntp sysstat sshpass nginx && \
  sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

# grab gosu = step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN arch="$(dpkg --print-architecture)" \
	&& set -x \
	&& curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.3/gosu-$arch" \
	&& curl -o /usr/local/bin/gosu.asc -fSL "https://github.com/tianon/gosu/releases/download/1.3/gosu-$arch.asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin

RUN echo US/Mountain > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

#Copy supervisod confs
COPY supervisord_conf/* /etc/supervisor/conf.d/

#copy nginx confs and files
COPY supervisord_conf/* /etc/supervisor/conf.d/
COPY nginx_conf/default /etc/nginx/sites-available/
COPY nginx_conf/nginx.conf /etc/nginx/
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
COPY var_www_nginx_html/ /var/www/nginx/html 
ENV TERM=screen

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]


