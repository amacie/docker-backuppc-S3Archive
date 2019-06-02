FROM adferrand/backuppc

LABEL maintainer="amacie"

RUN apk --no-cache --update add boto

RUN cd /usr/local/src/ \
&& git clone git://github.com/rtucker/backuppc-archive-s3.git \
&& ln -s /usr/local/src/backuppc-archive-s3/BackupPC_archiveHost_s3 /usr/share/backuppc/bin/


EXPOSE 8080

WORKDIR /home/backuppc

VOLUME ["/etc/backuppc", "/home/backuppc", "/data/backuppc"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/run.sh"]
