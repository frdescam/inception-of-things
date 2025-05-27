#!/bin/bash
# assuming docker is installed, and kubectl too (kubectl needs to be in usr/bin or usr/local/bin), need to add that to the init part 3 script!
# try to find a way to make this work without sudo, most likely adding k3d etc to docker user group
# need to find a way to make the update of the git in argocd faster, for now its 3 minutes

echo "Creating cluster"
k3d cluster delete laptop
k3d cluster create laptop --port "8888:80@loadbalancer"

echo "Creating argocd namespace and installing argocd"
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sleep 20 # if we dont wait port-foward will fail
kubectl -n argocd patch secret argocd-secret -p '{"stringData": {
    "admin.password": "$2b$12$nI36D3qDnDHxgncOVR.zwuDM4eD2kXnutani8aEGwucwWQr9yUZn6",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }
}'
# expose argocd gui this will block the script tho
#kubectl port-forward svc/argocd-server -n argocd 8080:443
