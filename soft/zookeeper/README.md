


# 安装

```bash
docker pull zookeeper:3.4.9

docker run -d \
        --name my-zk \
        --restart always \
        -p 2181:2181 \
        -p 2888:2888 \
        -p 3888:3888 \
        -v /data0/conf/soft/zookeeper/dev/conf/zoo.cfg:/conf/zoo.cfg \
        -v /data0/store/soft/zookeeper/data/:/data:rw \
        -v /data0/store/soft/zookeeper/datalog/:/datalog:rw \
        zookeeper:3.4.9
```