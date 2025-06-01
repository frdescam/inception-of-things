#!/bin/bash

echo "Deleting cluster if it already exists and creating it"
sudo k3d cluster delete gitlab
sudo k3d cluster create gitlab --port "80:80@loadbalancer" --port "443:443@loadbalancer" --port "22:22@server:0" 
sudo kubectl create namespace gitlab
echo "Deploying gitlab"
sudo helm repo add gitlab https://charts.gitlab.io/
sudo helm repo update
sudo helm upgrade --install gitlab gitlab/gitlab --timeout 600s --set global.hosts.domain=iot.local --set global.hosts.externalIP=127.0.0.1 --set certmanager-issuer.email=me@example.com -n gitlab
echo "Deleting Traefik in kube-system"
sudo kubectl delete service traefik -n kube-system
sudo kubectl delete deployment traefik -n kube-system
echo "Gitlab login: root"
echo "Gitlab Password:"
sudo kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' -n gitlab | base64 --decode ; echo
