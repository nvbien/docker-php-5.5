FROM simpledrupalcloud/base

MAINTAINER Simple Drupal Cloud <support@simpledrupalcloud.com>

ENV DEBIAN_FRONTEND noninteractive

ADD ./src /src

RUN chmod +x /src/build.sh
RUN /src/build.sh

RUN rm -rf /tmp/*

EXPOSE 9000

ENTRYPOINT ["/bin/bash", "-l", "-c", "/run.sh"]
