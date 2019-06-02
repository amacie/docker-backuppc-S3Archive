FROM adferrand/backuppc

LABEL maintainer="amacie"

RUN pip install boto3

RUN mkdir /usr/local/src/ \
&& cd /usr/local/src/ \
&& git clone git://github.com/rtucker/backuppc-archive-s3.git \
&& ln -s /usr/local/src/backuppc-archive-s3/BackupPC_archiveHost_s3 /usr/local/BackupPC/bin

EXPOSE 8080

WORKDIR /home/backuppc

VOLUME ["/etc/backuppc", "/home/backuppc", "/data/backuppc"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/run.sh"]
