FROM alpine:3

RUN apk add --no-cache 	mongodb-tools

ADD cmd/entry.sh /entry.sh
COPY cmd/script.sh /script.sh
RUN chmod 755 /script.sh /entry.sh

VOLUME [ "/backup" ]

ENV CRON="0 4 * * *"
ENV ARCHIVE=false

ENV USER=root
ENV MONGO_ROOT_PW_FILE=/run/secrets/MONGO_ROOT_PW

ENV HOST=db
ENV PORT=27017

ENV HOSTS=false
ENV REPLSET=rs0

ENV DB=admin
ENV AUTH_SOURCE=admin

ENTRYPOINT  ["/entry.sh"]