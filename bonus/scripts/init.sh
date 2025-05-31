#!/bin/bash

CONF_FOLDER="/home/iot/inception-of-things/p3/scripts"

bash $CONF_FOLDER/deploy_argocd.sh
bash $CONF_FOLDER/deploy_part3.sh

echo "Port fowarding for argocd Web"
kubectl port-forward svc/argocd-server -n argocd 8080:443
