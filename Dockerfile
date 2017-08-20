FROM maven:3-jdk-8

ENV DBSRV localhost
ENV DBNAME journals
ENV DBUSER root
ENV DBUSERPWD admin

RUN mkdir /root/upload
VOLUME /root/upload

EXPOSE 8080

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

COPY cot-pdfupload /cot-pdfupload

