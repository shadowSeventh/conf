#!/bin/bash


CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${CUR_DIR}/env.sh"

mkdir -p "${DIR_STORE}"
mkdir -p "${DIR_STORE}/docker/etc/letsencrypt"
mkdir -p "${DIR_STORE}/docker/var/lib/letsencrypt"
mkdir -p "${DIR_STORE}/docker/var/log/letsencrypt"

docker stop ${APP_C}
docker rm ${APP_C}

docker create                                       \
    --name ${APP_C}                                 \
    --restart unless-stopped                        \
    --entrypoint "/bin/sh"                          \
    -t                                              \
    -e CERTBOT_ADC_YAML=${DIR_CONF}/docker/config/certbot_adc.yaml  \
    -v ${DIR_CONF}:${DIR_CONF}                                      \
    -v ${DIR_STORE}/docker/etc/letsencrypt:/etc/letsencrypt         \
    -v ${DIR_STORE}/docker/var/lib/letsencrypt:/var/lib/letsencrypt \
    -v ${DIR_STORE}/docker/var/log/letsencrypt:/var/log/letsencrypt \
    btpka3/certbot-adc:latest

docker start ${APP_C}

docker exec -it ${APP_C}                            \
    ${DIR_CONF}/docker/setup.sh
