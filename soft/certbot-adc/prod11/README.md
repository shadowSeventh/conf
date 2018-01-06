

# 合并配置的域名列表

* kingsilk.xyz

    ```bash
    
    docker exec qh-certbot-adc
        certbot \
            certonly \
            -n \
            --manual \
            --cert-name _.kingsilk.xyz \
            --manual-public-ip-logging-ok \
            --manual-auth-hook /usr/local/bin/certbot-adc-manual-auth-hook \
            --manual-cleanup-hook /usr/local/bin/certbot-adc-manual-cleanup-hook \
            --preferred-challenges dns \
            -d           kingsilk.xyz \
            -d       git.kingsilk.xyz \
            -d       doc.kingsilk.xyz \
            -d       mvn.kingsilk.xyz \
            -d      wiki.kingsilk.xyz \
            -d    zentao.kingsilk.xyz \
            -d sonarqube.kingsilk.xyz \
            -d    test11.kingsilk.xyz \
            -d    test12.kingsilk.xyz \
            -d    test13.kingsilk.xyz \
            -d    test14.kingsilk.xyz \
            -d    test15.kingsilk.xyz \
            -d     dev40.kingsilk.xyz \
            -d     dev41.kingsilk.xyz \
            -d     dev42.kingsilk.xyz \
            -d     dev43.kingsilk.xyz \
            -d     dev44.kingsilk.xyz \
            -d     dev60.kingsilk.xyz \
            -d     dev61.kingsilk.xyz \
            -d     dev62.kingsilk.xyz \
            -d     dev63.kingsilk.xyz \
            -d     dev64.kingsilk.xyz \
            -d     dev65.kingsilk.xyz \
            -d     dev66.kingsilk.xyz \
            -d     dev67.kingsilk.xyz \
            -d     dev68.kingsilk.xyz \
            -d     dev69.kingsilk.xyz \
            -d     dev70.kingsilk.xyz \
            -d     dev71.kingsilk.xyz \
            -d     dev72.kingsilk.xyz \
            -d     dev73.kingsilk.xyz \
            -d     dev74.kingsilk.xyz
    ```

* kingsilk.net

    ```bash
    docker exec qh-certbot-adc \
        certbot \
            certonly \
            -n \
            --manual \
            --cert-name _.kingsilk.net \
            --manual-public-ip-logging-ok \
            --manual-auth-hook /usr/local/bin/certbot-adc-manual-auth-hook \
            --manual-cleanup-hook /usr/local/bin/certbot-adc-manual-cleanup-hook \
            --preferred-challenges dns \
            -d           kingsilk.net \
            -d       www.kingsilk.net \
            -d       pay.kingsilk.net \
            -d    common.kingsilk.net \
            -d     oauth.kingsilk.net \
            -d     login.kingsilk.net \
            -d       img.kingsilk.net \
            -d   static1.kingsilk.net \
            -d    static.kingsilk.net \
            -d       yun.kingsilk.net
    ```


# 开发环境，测试环境 

certbot-adc 只在线上环境安装。 开发环境和测试环境不安装 , 但通过 rsync 的定时任务从线上环境获取。
然后通过目录挂载的方式，挂载到各个docker容器内。 

```bash

# 定时任务 (test12), 从 prod 环境获取
crontab -e
0 0 * * *  rsync -avzh root@pub-prod11.kingsilk.net:/data0/store/soft/certbot-adc /data0/store/soft/

# 定时任务 (test13, test14, devXx) , 从 test12 环境获取
crontab -e
0 1 * * *  rsync -avzh root@192.168.0.12:/data0/store/soft/certbot-adc /data0/store/soft/


# nginx docker 容器

docker create ... \
    -v /data0/store/soft/certbot-adc/docker/etc/letsencrypt:/etc/letsencrypt \
    ...
```

# 其他环境的证书安装

其他环境目前均需要手动上传证书

- 阿里云 CDN
    阿里云CDN 提供了[设置证书](https://help.aliyun.com/document_detail/45014.html)的接口，certbot-adc 做的更好的话，
    可以通过 certbot 的 `--post-hook`, [`--deploy-hook`](https://certbot.eff.org/docs/using.html#id19) 来再 renew 时自动上传。
    
- 七牛云 CDN
    没有设置证书的API，而且貌似可用证书时间不能太短（有待确认）。
    不行就只能通过免费的单域名的 赛门铁克的 DV型的证书了（特殊处理）。



