docker-php-5.2.17
=================

Run the container
-----------------

    CONTAINER=php52 && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 5217:5217
      -v /var/www:/var/www \
      -d \
      simpledrupalcloud/php:5.2.17

Build the image
---------------

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-php.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout 5.2.17 \
      && sudo docker build -t simpledrupalcloud/php:5.2.17 . \
      && cd -

Apache directives
-----------------

    <IfModule mod_fastcgi.c>
      AddHandler php .php

      Alias /php52 /var/www/php52
      FastCgiExternalServer /var/www/php52 -host 127.0.0.1:5217 -idle-timeout 300 -pass-header Authorization

      <Location /php52>
        Order deny,allow
        Deny from all
        Allow from env=REDIRECT_STATUS
      </Location>

      Action php /php52
    </IfModule>