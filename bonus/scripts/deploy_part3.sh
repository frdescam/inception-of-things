#!/bin/bash

CONF_FOLDER="/home/iot/inception-of-things/p3/confs"

echo "Installing part3 in dev namespace"
kubectl create namespace dev
kubectl apply -f $CONF_FOLDER/argocd-project.yaml
kubectl apply -f $CONF_FOLDER/part3-argocd.yaml
