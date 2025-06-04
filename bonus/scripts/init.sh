#!/bin/bash

CONF_FOLDER="/home/iot/inception-of-things/p3/scripts"

sudo bash $CONF_FOLDER/deploy_argocd.sh
sudo bash $CONF_FOLDER/deploy_part3.sh

echo "Port fowarding for argocd Web"
sudo kubectl port-forward svc/argocd-server -n argocd 443:443
