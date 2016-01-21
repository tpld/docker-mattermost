#!/bin/bash

APP_DIR="/app"

DEFAULT_CONFIG_FILE="$APP_DIR/config_docker.json"
CONFIG_FILE="$APP_DIR/config_docker.json.run"

config_update_mysql () {
	OLD="\"DataSource\": \"mmuser:mostest@tcp(dockerhost:3306)\/mattermost_test?charset=utf8mb4,utf8\","
    NEW="\"DataSource\": \"$MYSQL_USER:$MYSQL_PASS@tcp($MYSQL_HOST:$MYSQL_PORT)\/$MYSQL_DB?charset=$MYSQL_CHARSET\","
    SRC_FILE="$CONFIG_FILE"
    TMP_FILE="$CONFIG_FILE.tmp"

    sed "s/$OLD/$NEW/g" "$SRC_FILE" > $TMP_FILE
    mv $TMP_FILE $SRC_FILE
}

make_config () {
    if [ ! -f /app/config_docker.json.run ]; then
        echo preparing first configuration
        cp $DEFAULT_CONFIG_FILE $CONFIG_FILE
        config_update_mysql
        
        mkdir -p "/$APP_DIR/mattermost/web/static/js"
    fi
    
}

run () {
    echo starting mattermost
    cd "/$APP_DIR/mattermost/bin"
    ./platform -config=/app/config_docker.json.run
}


make_config
run
