#!/bin/bash


CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${CUR_DIR}/env.sh"


log "创建所需的目录（不会清空、删除）"
mkdir -p "${DIR_STORE}"
mkdir -p "${DIR_STORE_LOGS}"
mkdir -p "${DIR_STORE_DATA}"


log "停止并删除 docker 容器"
docker stop ${APP_C}
docker rm ${APP_C}

log "重新创建 docker 容器"
# 参考: https://www.rabbitmq.com/relocate.html
docker create                                   \
    --name ${APP_C}                             \
    --restart unless-stopped                    \
    -p 4369:4369                                \
    -p 5671:5671                                \
    -p 5672:5672                                \
    -p 25672:25672                              \
    -p 1883:1883                                \
    -p 8883:8883                                \
    -p 15671:15671                              \
    -p 15672:15672                              \
    -p 15674:15674                              \
    -p 15675:15675                              \
    -v ${DIR_STORE_LOGS}:${DIR_STORE_LOGS}:rw   \
    -v ${DIR_STORE_DATA}:/var/lib/rabbitmq:rw   \
    -v ${DIR_CONF}/docker/rabbitmq:/etc/rabbitmq\
    -v ${DIR_CONF}:${DIR_CONF}                  \
    -e RABBITMQ_LOG_BASE=${DIR_STORE_LOGS}      \
    ${DOCKER_REG}/kingsilk/${APP_C}

log "启动 docker 容器"
docker start ${APP_C}

log "对 docker 内部进行额外额外初始化"
docker exec -it ${APP_C}                        \
    ${DIR_CONF}/docker/setup.sh




