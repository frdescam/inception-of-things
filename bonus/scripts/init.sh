#!/bin/bash

CONF_FOLDER="/home/iot/inception-of-things/bonus/scripts"

sudo bash $CONF_FOLDER/deploy_argocd.sh
sudo bash $CONF_FOLDER/deploy_part3.sh

echo "Port fowarding of argocd web in port 8080"
sudo kubectl port-forward svc/argocd-server -n argocd 8080:443 &

echo "Port fowarding of part3 in port 8888"
sudo kubectl port-forward svc/part3 -n dev 8888:80
