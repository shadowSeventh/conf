
# 说明

本目录下的是开发人员本机专用模板文件。


# 使用步骤

1. 复制为 `dev.tpl` 为 `dev` 目录。 `dev` 目录是被 git ignore 掉的。
 
    ```bash
    cd soft/nginx
    cp -fr dev.tpl dev
    ```

1. 替换端口 16000 开发人员自己的对应的变量值。具体请结合自己的 ip 地址，参考 wiki 上《端口列表》。

1. 替换 相应配置文件中本地文件的路径。

# 开发人员本地，nginx相关准备工作

```
# ~/work为开发人员本地work目录
mkdir -p /data0/work
ln -s /home/yanfq/work /data0/work
ln -s /home/yanfq/work/git-repo/kingsilk/qh-conf /data0/conf
```

# 安装 nginx

这里的内容不要修改，具体请看各个环境下的 setup.sh


```bash
mkdir -p /data0/store/soft/nginx/logs
mkdir -p /data0/store/soft/nginx/html
docker pull nginx:1.11.8

docker create \
    --name qh-nginx \
    -p 80:80 \
    -p 443:443 \
    -p 64444:64444 \
    -v /data0/app:/data0/app:ro \
    -v /data0/conf/soft/nginx/dev/conf/nginx.conf:/etc/nginx/nginx.conf:ro \
    -v /data0/conf/soft/nginx/dev/conf/conf.d/:/etc/nginx/conf.d/:ro \
    -v /data0/store/soft/nginx/html/:/usr/share/nginx/html:ro \
    -v /data0/store/soft/nginx/logs/:/etc/nginx/logs:rw \
    nginx:1.11.8

# 启动
docker start qh-nginx
  
# 进入 docker 容器
docker exec -it qh-nginx bash
```
备注：  
```
-v /data0/work:/data0/work:ro \g
-v /data0/app:/data0/app:ro \
```
以上两个配置

线上及测试环境使用   `-v /data0/work:/data0/work:ro \ `
开发人员自己环境使用 `-v /data0/app:/data0/app:ro \ `




