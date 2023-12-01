FROM alpine:3

RUN apk add --no-cache 	mongodb-tools

ADD cmd/entry.sh /entry.sh
COPY cmd/script.sh /script.sh
RUN chmod 755 /script.sh /entry.sh

ENV CRON="* * * * *"
ENV MONGO_ROOT_PW_FILE=/run/secrets/MONGO_ROOT_PW
ENV USER=root
ENV HOST=db
ENV PORT=27017
ENV DB=admin

ENTRYPOINT  ["/entry.sh"]