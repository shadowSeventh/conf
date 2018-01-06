#!/bin/bash

# 自建CA（认证中心）的 根CA证书

mkdir -p myca

# 生成自签名证书
openssl req                             \
    -x509                               \
    -newkey         rsa:2048            \
    -days           3650                \
    -sha256                             \
    -config         openssl.cnf         \
    -extensions     root_ca_extensions  \
    -subj           "/CN=myca/"         \
    -outform        PEM                 \
    -out            myca/myca.pem.cer   \
    -keyout         myca/myca.pem.key   \
    -nodes

# 将私钥和证书 合并成单个的 PKCS#12 格式的证书
openssl pkcs12                          \
   -export                              \
   -in              myca/myca.pem.cer   \
   -inkey           myca/myca.pem.key   \
   -out             myca/myca.p12       \
   -passout         pass:123456         \
   -name            myca

# 将 PKCS#12 格式的证书 转换为 JKS 格式的
keytool -importkeystore                 \
   -srcstoretype    PKCS12              \
   -srckeystore     myca/myca.p12       \
   -srcstorepass    123456              \
   -srcalias        myca                \
   -deststoretype   JKS                 \
   -destkeystore    myca/myca.jks       \
   -deststorepass   123456              \
   -destalias       myca                \
   -destkeypass     456789
