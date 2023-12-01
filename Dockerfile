FROM alpine:3

ADD cmd/entry.sh /entry.sh
COPY cmd/script.sh /script.sh
RUN chmod 755 /script.sh /entry.sh
# RUN /usr/bin/crontab /crontab.txt

ENV CRON="* * * * *"

ENTRYPOINT  ["/entry.sh"]