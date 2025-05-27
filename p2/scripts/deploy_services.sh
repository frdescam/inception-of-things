#!/bin/bash

SERVICES_FOLDER="/services"

for service in app1 app2 app3
do
    echo "[services deployment script] Deploying $service..."
    kubectl apply -f $SERVICES_FOLDER/$service/$service.yaml
done

echo "[services deployment script] Waiting for traefik CRD to be installed ..."
while ! kubectl api-resources | grep traefik.io/v1alpha1 | grep "Middleware\b" > /dev/null 2>&1
do
    sleep 2
done

echo "[services deployment script] Deploying Ingress..."
kubectl apply -f $SERVICES_FOLDER/ingress.yaml

echo "[services deployment script] All resources deployed!"
