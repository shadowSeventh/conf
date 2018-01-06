#!/bin/bash

rm -fr client
rm -fr server
rm -fr myca

./genCaCert.sh
./genServerCert.sh
./genClientCert.sh

