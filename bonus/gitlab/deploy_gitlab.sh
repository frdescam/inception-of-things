#!/bin/bash

# do we change the domain name?

sudo k3d cluster delete gitlab
echo "Deploying gitlab"
sudo k3d cluster create gitlab --port "80:80@loadbalancer" --port "443:443@loadbalancer" --port "22:22@server:0" 
sudo kubectl create namespace gitlab
#sudo kubectl create secret generic -n gitlab gitlab-gitlab-initial-root-password --from-literal=password=iotiot
sudo helm upgrade --install gitlab gitlab/gitlab   --timeout 600s   --set global.hosts.domain=iot.com   --set global.hosts.externalIP=127.0.0.1  --set certmanager-issuer.email=me@example.com -n gitlab
sleep 20 # change this
sudo kubectl delete service traefik -n kube-system
#sudo kubectl create secret generic -n gitlab gitlab-gitlab-initial-root-password --from-literal=password=iotiotiot
sudo kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' -n gitlab | base64 --decode ; echo
