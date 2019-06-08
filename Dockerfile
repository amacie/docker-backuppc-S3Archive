FROM adferrand/backuppc

LABEL maintainer="amacie"

RUN apk --no-cache --update add \
    g++ \
    gnupg \
    python \
    py-boto \
  && apk --no-cache --update --virtual build-dependencies add git \ 
  && mkdir /usr/local/src/ \
  && cd /usr/local/src/ \
  && git clone git://github.com/rtucker/backuppc-archive-s3.git \
  && mkdir -p /usr/local/BackupPC/bin/ \
  && ln -s /usr/local/src/backuppc-archive-s3/BackupPC_archiveHost_s3 /usr/local/BackupPC/bin/ \
  && sed -i -e 's/^use lib "\/usr\/share\/backuppc\/lib/use lib "\/usr\/local\/BackupPC\/lib/g' /usr/local/src/backuppc-archive-s3/BackupPC_archiveStart \
  && apk del build-dependencies \
  && echo $'\n\
[watcher:syslogd]\n\
cmd = /sbin/syslogd -O -\n\
\n\
[watcher:crond]\n\
cmd = /usr/sbin/crond' >> /etc/circus.ini
