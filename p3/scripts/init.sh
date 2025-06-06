#!/bin/bash

CONF_FOLDER="/home/iot/inception-of-things/p3/scripts"

sudo bash $CONF_FOLDER/deploy_argocd.sh
sudo bash $CONF_FOLDER/deploy_part3.sh

echo "Port fowarding of argocd web in port 443"
sudo kubectl port-forward svc/argocd-server -n argocd 443:443
