#! /bin/bash

echo "[install docker script] installing docker ..."
apk add docker
rc-update add docker default
service docker start

echo "[install docker script] Waiting for docker to start ..."
while ! docker info > /dev/null 2>&1
do
    sleep 1
done