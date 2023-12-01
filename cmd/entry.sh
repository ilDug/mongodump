#!/bin/sh

# crea il file crontab.txt utilizzzando la variabile ENV CRON
echo "$CRON /script.sh" > /crontab.txt;

# applica il crontab
/usr/bin/crontab /crontab.txt;

# start cron
/usr/sbin/crond -f -l 8