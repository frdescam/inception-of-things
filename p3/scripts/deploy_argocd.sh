#!/bin/bash

echo "Creating cluster"
k3d cluster delete dev-cluster
k3d cluster create dev-cluster --port "8888:80@loadbalancer"

echo "Creating argocd namespace and installing argocd"
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for argocd repo-server to be ready..."
until kubectl get pods -n argocd | grep repo-server | grep -q '1/1'; do
  sleep 5
done

echo "Waiting for argocd web server to be ready..."
until kubectl get pods -n argocd | grep argocd-server | grep -q '1/1'; do
  sleep 5
done

kubectl -n argocd patch secret argocd-secret -p '{"stringData": {
    "admin.password": "$2b$12$nI36D3qDnDHxgncOVR.zwuDM4eD2kXnutani8aEGwucwWQr9yUZn6",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }
}'
