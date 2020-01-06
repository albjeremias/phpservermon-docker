FROM debian:bullseye-slim
ENV DEBIAN_FRONTEND noninteractive
WORKDIR /app/

RUN apt update
RUN apt -y install nginx php7.3 php7.3-fpm php7.3-mysql nano curl php7.3-xml cron php7.3-curl php7.3-gd php7.3-mbstring composer git cron

COPY nginx.conf /etc/nginx/sites-available/
RUN ln -sf /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/default

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY cronjob /etc/cron.d/monitor-cron
RUN chmod 0644 /etc/cron.d/monitor-cron
RUN crontab /etc/cron.d/monitor-cron
RUN touch /var/log/cron.log

RUN git clone https://github.com/phpservermon/phpservermon.git /app/
RUN composer install
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]	
