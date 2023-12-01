#!/bin/sh

# PW=$(echo $MONGO_ROOT_PW_FILE)
PW="cippa"

# connection string
CS="mongodb://$USER:$PW@$HOST:$PORT/$DB?authSource=admin"

echo $CS


# montare una cartella sul server dove salvare il BACKUP

# echo $(date) >>/backup/backup.$(date +%Y.%m).log

# docker exec mongodb sh -c "mongodump -v  -u root -p $MONGO_ROOT_PW --authenticationDatabase admin --out=/backup --db=ek" 2>&1 | tee -a /backup/backup.$(date +%Y.%m).log

# echo $? >>/backup/backup.$(date +%Y.%m).log
####################################################################################
# docker exec mongodb sh -c "mongorestore -v -u root -p $MONGO_ROOT_PW --authenticationDatabase admin --dir=/backup --drop"
