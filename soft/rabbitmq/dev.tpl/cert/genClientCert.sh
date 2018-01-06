#!/bin/bash

# 生成 client 端证书，并用自建 CA 签名

mkdir -p client

# 生成一个公钥私钥对儿
openssl genrsa                              \
   -out client/client.pem.key               \
   2048

# 生成 生成一个CSR (Certificate Signing Request)
openssl req                                 \
   -new                                     \
   -key     client/client.pem.key           \
   -out     client/client.pem.csr           \
   -subj    "/CN=client/"

# 签名
openssl x509                                \
   -req                                     \
   -days            3650                    \
   -in              client/client.pem.csr   \
   -CA              myca/myca.pem.cer       \
   -CAkey           myca/myca.pem.key       \
   -CAcreateserial                          \
   -extfile         openssl.cnf             \
   -extensions      client_ca_extensions    \
   -out             client/client.pem.cer

# 将私钥和证书 合并成单个的 PKCS#12 格式的证书
openssl pkcs12                              \
   -export                                  \
   -in              client/client.pem.cer   \
   -inkey           client/client.pem.key   \
   -out             client/client.p12       \
   -passout         pass:123456             \
   -name            client

# 将 PKCS#12 格式的证书 转换为 JKS 格式的
keytool -importkeystore                     \
   -srcstoretype    PKCS12                  \
   -srckeystore     client/client.p12       \
   -srcstorepass    123456                  \
   -srcalias        client                  \
   -deststoretype   JKS                     \
   -destkeystore    client/client.jks       \
   -deststorepass   123456                  \
   -destalias       client                  \
   -destkeypass     456789

# 检查
openssl verify                              \
    -verbose                                \
    -CAfile         myca/myca.pem.cer       \
    client/client.pem.cer


