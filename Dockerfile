FROM nginx
MAINTAINER Swire Chen <idoop@msn.cn>

ENV APP_BASE /var/www/simple-nuget-server
ENV DEFAULT_SIZE 20M

# Install PHP7
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates curl unzip php php-fpm php-mysql php-sqlite3 php-zip php-xml

# Download project
RUN curl -sSL https://github.com/Daniel15/simple-nuget-server/archive/master.zip -o master.zip && unzip master.zip -d /var/www && mv /var/www/simple-nuget-server-master $APP_BASE
RUN chown www-data:www-data $APP_BASE/db $APP_BASE/packagefiles && \
    chown 0770 $APP_BASE/db $APP_BASE/packagefiles

# Activate the nginx configuration
RUN rm /etc/nginx/conf.d/*
COPY nginx.conf.example /etc/nginx/conf.d/nuget.conf

# Set default upload file sizes limit
RUN sed -i -e "s/post_max_size.*/post_max_size = $DEFAULT_SIZE/" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/upload_max_filesize.*/upload_max_filesize = $DEFAULT_SIZE/" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "/server_name.*$/a\    client_max_body_size $DEFAULT_SIZE;" /etc/nginx/conf.d/nuget.conf

RUN usermod -G www-data nginx

VOLUME ["$APP_BASE/db", "$APP_BASE/packagefiles"]

EXPOSE 80-60000

COPY docker-entrypoint /bin/docker-entrypoint
RUN chmod +x /bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]