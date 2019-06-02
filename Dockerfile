FROM adferrand/backuppc

LABEL maintainer="amacie"

RUN apk --no-cache --update add \
    g++ \
    python \
    py-boto \
  && apk --no-cache --update --virtual build-dependencies add git \ 
  && mkdir /usr/local/src/ \
  && cd /usr/local/src/ \
  && git clone git://github.com/rtucker/backuppc-archive-s3.git \
  && ls -l /usr/local/ \
  && mkdir -p /usr/local/BackupPC/bin/ \
  && ln -s /usr/local/src/backuppc-archive-s3/BackupPC_archiveHost_s3 /usr/local/BackupPC/bin/ \
  && apk del build-dependencies
