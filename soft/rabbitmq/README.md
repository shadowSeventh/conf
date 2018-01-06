


# 端口说明

| port  | desp |
|-------|------|
|4369   |Erlang 开启的一个端口映射的端口，用以管理集群。|
|5671   |RabbitMq 节点 端口 (SSL)|
|5672   |RabbitMq 节点 端口 (主要端口)|
|15671  |rabbitmq_management 插件 基于 Web 的管理后台端口（HTTPS）|
|15672  |rabbitmq_management 插件 基于 Web 的管理后台端口 (HTTP)|
|15675  |rabbitmq_web_mqtt 插件监听的 WebSocket 端口。注意：WSS 端口默认为 15671。|
|25672  |RabbitMq 节点间通信端口（RabbitMq 节点 端口 + 20000）|
|1883   |rabbitmq_mqtt 插件端口|
|8883   |rabbitmq_mqtt 插件端口（TLS）|

