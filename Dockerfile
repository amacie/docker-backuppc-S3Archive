FROM adferrand/backuppc

LABEL maintainer="amacie"

RUN apk --no-cache --update add \
    g++ \
    gnupg \
    python2 \
    py-boto \
  && apk --no-cache --update --virtual build-dependencies add git \ 
  && mkdir /usr/local/src/ \
  && cd /usr/local/src/ \
  && git clone git://github.com/rtucker/backuppc-archive-s3.git \
  && mkdir -p /usr/local/BackupPC/bin/ \
  && ln -s /usr/local/src/backuppc-archive-s3/BackupPC_archiveHost_s3 /usr/local/BackupPC/bin/ \
  && sed -i -e 's/^use lib "\/usr\/share\/backuppc\/lib/use lib "\/usr\/local\/BackupPC\/lib/g' /usr/local/src/backuppc-archive-s3/BackupPC_archiveStart \
  && ln -s /usr/lib/python3.8/site-packages/boto /usr/lib/python2.7/site-packages/ \
  && ln -s /usr/lib/python3.8/site-packages/boto-2.49.0-py3.8.egg-info /usr/lib/python2.7/site-packages/ \
  && apk del build-dependencies \
  && echo $'\n\
[watcher:syslogd]\n\
cmd = /sbin/syslogd -n -O -\n\
\n\
[watcher:crond]\n\
cmd = /usr/sbin/crond -f' >> /etc/circus.ini
