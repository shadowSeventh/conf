#!/bin/bash

# 生成 server 端证书，并用自建 CA 签名

mkdir -p server

# 生成一个公钥私钥对儿
openssl genrsa                              \
    -out server/server.pem.key              \
    2048

# 生成 生成一个CSR (Certificate Signing Request)
openssl req                                 \
    -new                                    \
    -key server/server.pem.key              \
    -out server/server.pem.csr              \
    -subj "/CN=server/"

# 签名
openssl x509                                \
    -req                                    \
    -days           3650                    \
    -in             server/server.pem.csr   \
    -CA             myca/myca.pem.cer       \
    -CAkey          myca/myca.pem.key       \
    -CAcreateserial                         \
    -extfile        openssl.cnf             \
    -extensions     server_ca_extensions    \
    -out            server/server.pem.cer

# 将私钥和证书 合并成单个的 PKCS#12 格式的证书
openssl pkcs12                              \
    -export                                 \
    -in             server/server.pem.cer   \
    -inkey          server/server.pem.key   \
    -out            server/server.p12       \
    -passout        pass:123456             \
    -name           server

# 将 PKCS#12 格式的证书 转换为 JKS 格式的
keytool -importkeystore                     \
    -srcstoretype   PKCS12                  \
    -srckeystore    server/server.p12       \
    -srcstorepass   123456                  \
    -srcalias       server                  \
    -deststoretype  JKS                     \
    -destkeystore   server/server.jks       \
    -deststorepass  123456                  \
    -destalias      server                  \
    -destkeypass    456789

# 检查
openssl verify                              \
    -verbose                                \
    -CAfile         myca/myca.pem.cer       \
    server/server.pem.cer
