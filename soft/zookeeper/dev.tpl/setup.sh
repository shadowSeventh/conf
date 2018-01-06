#!/bin/bash


CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${CUR_DIR}/env.sh"


log "创建所需的目录（不会清空、删除）"
mkdir -p "${DIR_STORE}"
mkdir -p "${DIR_STORE_LOGS}"
mkdir -p "${DIR_STORE_DATA}"
mkdir -p "${DIR_STORE_DATA_LOG}"


log "停止并删除 docker 容器"
docker stop ${APP_C}
docker rm ${APP_C}

log "重新创建 docker 容器"
docker create                                   \
    --name ${APP_C}                             \
    --restart unless-stopped                    \
    -p 2181:2181                                \
    -p 2888:2888                                \
    -p 3888:3888                                \
    -v ${DIR_STORE_LOGS}:${DIR_STORE_LOGS}:rw   \
    -v ${DIR_STORE_DATA}:/data:rw               \
    -v ${DIR_STORE_DATA_LOG}:/datalog:rw        \
    -v ${DIR_CONF}/docker/conf:/conf            \
    -v ${DIR_CONF}:${DIR_CONF}                  \
    ${DOCKER_REG}/kingsilk/${APP_C}

log "启动 docker 容器"
docker start ${APP_C}

log "对 docker 内部进行额外额外初始化"
docker exec -it ${APP_C}                        \
    ${DIR_CONF}/docker/setup.sh




