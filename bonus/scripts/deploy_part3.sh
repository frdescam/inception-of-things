#!/bin/bash

CONF_FOLDER="/home/iot/inception-of-things/bonus/confs"

echo "Installing part3 in dev namespace"
kubectl create namespace dev
kubectl apply -f $CONF_FOLDER/argocd-project.yaml
kubectl apply -f $CONF_FOLDER/part3-argocd.yaml

echo "Waiting for part3 service to be ready..."
sleep 10
until kubectl get pods -n dev | grep part3 | grep -q '1/1'; do
  sleep 5
done
