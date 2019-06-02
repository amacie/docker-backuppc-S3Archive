FROM adferrand/backuppc

LABEL maintainer="amacie"

RUN pip install boto3 \
  && apk --no-cache --update add g++ \ 
  && apk --no-cache --update --virtual build-dependencies add git \ 
  && mkdir /usr/local/src/ \
  && cd /usr/local/src/ \
  && git clone git://github.com/rtucker/backuppc-archive-s3.git \
  && apk del build-dependencies

EXPOSE 8080

WORKDIR /home/backuppc

VOLUME ["/etc/backuppc", "/home/backuppc", "/data/backuppc"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/run.sh"]
