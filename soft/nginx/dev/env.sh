#!/bin/bash

export APP=nginx
# 容器的名称
export APP_C=${APP}
export DOCKER_REG=registry.cn-hangzhou.aliyuncs.com

export DIR_STORE="/Users/lit/docker/$APP"
export DIR_STORE_LOGS="${DIR_STORE}/logs"
export DIR_STORE_HTML="${DIR_STORE}/html"

export DIR_CONF="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


#
# 向控制台输出内容。消息前会追加时间戳。
#
# @param $1 要打印的消息
#
log(){
    #Cyan
    Color_ON='\033[0;36m'
    Color_Off='\033[0m'
    echo -e "${Color_ON}$(date +%Y-%m-%d.%H:%M:%S) : $1${Color_Off}" 1>&2
}


