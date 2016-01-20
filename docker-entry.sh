#!/bin/bash

config_update_mysql () {
	OLD="\"DataSource\": \"mmuser:mostest@tcp(dockerhost:3306)\/mattermost_test?charset=utf8mb4,utf8\","
    NEW="\"DataSource\": \"$MYSQL_USER:$MYSQL_PASS@tcp($MYSQL_HOST:$MYSQL_PORT)\/$MYSQL_DB?charset=$MYSQL_CHARSET\","
    ORG_FILE="/app/config_docker.json.run"
    TMP_FILE="/app/config_docker.json.tmp"

    sed "s/$OLD/$NEW/g" "$ORG_FILE" > $TMP_FILE
    mv $TMP_FILE $ORG_FILE
}


#--------
#config
#--------

cp config_docker.json config_docker.json.run

echo preparing configuration
config_update_mysql

#--------
#missing dirs
#--------
mkdir -p mattermost/web/static/js



#--------
#run
#--------

echo starting mattermost
cd /app/mattermost/bin
./platform -config=/app/config_docker.json.run
