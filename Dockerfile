# See License.txt for license information.
FROM ubuntu:14.04


ENV MYSQL_HOST=172.17.0.1
ENV MYSQL_PORT=3306
ENV MYSQL_USER=mattermost
ENV MYSQL_PASS=password
ENV MYSQL_DB=mattermost
ENV MYSQL_CHARSET=utf8mb4,utf8

# ---------------------------------------------------------------------------------------------------------------------
WORKDIR /app

# Download app
RUN mkdir mattermost
WORKDIR /app/mattermost
ADD https://github.com/mattermost/platform/releases/download/v2.0.0/mattermost.tar.gz mattermost.tar.gz
RUN tar -zxvf mattermost.tar.gz --strip-components=1 && rm mattermost.tar.gz

# Add default config
WORKDIR /app
ADD config_docker.json /app/

#Prepare entry
ADD docker-entry.sh /app/

EXPOSE 80

ENTRYPOINT /app/docker-entry.sh
