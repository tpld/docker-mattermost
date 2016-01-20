Docker file to build mattermost (base on official mattermost dockerfile).
This build allow to use external MySQL database.

Just use it like bellow:
```bash
docker run -ti --name="mat" \
    --env="MYSQL_HOST=db" \
    --env="MYSQL_PORT=3306" \
    --env="MYSQL_USER=dbuser" \
    --env="MYSQL_PASS=dbpass" \
    --env="MYSQL_DB=db_mattermost" \
    --env="MYSQL_CHARSET=utf8" \
    --volume=/home/docker-volumes/mattermost:/mattermost/data \
    tpld/mattermost
```
    
If you need shared volume, you should use --volume option and map your folder to /app/mattermost/data.
Example:

```bash
docker run -ti --name="mat" \
    --env="MYSQL_HOST=db" \
    --env="MYSQL_PORT=3306" \
    --env="MYSQL_USER=dbuser" \
    --env="MYSQL_PASS=dbpass" \
    --env="MYSQL_DB=db_mattermost" \
    --env="MYSQL_CHARSET=utf8" \
    --volume=/srv/mattermost-files:/app/mattermost/data \
    tpld/mattermost
```
