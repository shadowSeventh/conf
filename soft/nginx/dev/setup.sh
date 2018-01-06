#!/bin/bash


CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${CUR_DIR}/env.sh"

mkdir -p "${DIR_STORE}"
mkdir -p "${DIR_STORE_LOGS}"
mkdir -p "${DIR_STORE_HTML}"

#systemctl stop ${APP}
#systemctl disable ${APP}

docker stop ${APP_C}
docker rm ${APP_C}

#docker rmi ${APP_C}
#docker build -t ${APP_C} ./docker

docker create                                       \
    --name ${APP_C}                                 \
    --restart unless-stopped                        \
    -p 80:80                                        \
    -p 443:443                                      \
    -v /Users/lit/work:/Users/lit/work:ro                     \
    -v ${DIR_CONF}/conf:/etc/nginx:ro               \
    -v ${DIR_STORE_HTML}/:/usr/share/nginx/html:ro  \
    -v ${DIR_STORE_LOGS}:/var/log/nginx:rw          \
    -v ${DIR_CONF}:${DIR_CONF}                      \
    ${DOCKER_REG}/seventh/${APP_C}



#systemctl link "${DIR_CONF}/systemd/${APP}.service"
#systemctl enable "${DIR_CONF}/systemd/${APP}.service"
#systemctl start ${APP}
log "启动 docker 容器"
docker start ${APP_C}

