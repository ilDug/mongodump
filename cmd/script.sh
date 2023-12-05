#!/bin/sh

PW=$(cat $MONGO_ROOT_PW_FILE)
# PW="cippa"


if [ $HOSTS = false ]
then
    # connection string
    CS="mongodb://$USER:$PW@$HOST:$PORT/$DB?authSource=$AUTH_SOURCE"
else
    # connection string
    CS="mongodb://$USER:$PW@$HOSTS/$DB?authSource=$AUTH_SOURCE&replicaSet=$REPLSET"
fi

echo $CS


# percorso file de log mensile
LOGFILE="/backup/backup.$(date +%Y.%m).log"

echo $(date) >>$LOGFILE

# BACKUP MONGODUMP
####################################################################################
if [ $ARCHIVE = false ]
then
    mongodump -v --uri $CS --out=/backup  2>&1 | tee -a $LOGFILE
else
    ARCHIVE_NAME="$DB-$(date +%Y.%m.%d.%H.%M.%S).gz"
    mongodump -v --uri $CS --archive=/backup/$ARCHIVE_NAME --gzip 2>&1 | tee -a $LOGFILE
fi

# mongodump -v -u root -p $MONGO_ROOT_PW --authenticationDatabase admin --out=/backup --db=ek  2>&1 | tee -a $LOGFILE

echo $? >>$LOGFILE


# RESTORE
####################################################################################
# mongorestore -v -u root -p $MONGO_ROOT_PW --authenticationDatabase admin --dir=/backup --drop
