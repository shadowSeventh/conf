#!/bin/bash


CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${CUR_DIR}/env.sh"

mkdir -p "${DIR_STORE}"
mkdir -p "${DIR_STORE_LOGS}"
mkdir -p "${DIR_STORE_DATA}"

#systemctl stop ${APP}
#systemctl disable ${APP}

docker stop ${APP_C}
docker rm ${APP_C}

#docker rmi ${APP_C}
#docker build -t ${APP_C} ./docker

docker create                                       \
    --name ${APP_C}                                 \
    --restart unless-stopped                        \
    -p 3306:3306                                    \
    -e MYSQL_ROOT_PASSWORD=123456                   \
    -v ${DIR_CONF}/conf.d:/etc/mysql/conf.d:ro               \
    -v ${DIR_STORE_DATA}/:/var/lib/mysql:rw           \
    ${DOCKER_REG}/seventh/${APP_C}



#systemctl link "${DIR_CONF}/systemd/${APP}.service"
#systemctl enable "${DIR_CONF}/systemd/${APP}.service"
#systemctl start ${APP}
log "启动 docker 容器"
docker start ${APP_C}




