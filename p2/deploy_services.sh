#!/bin/bash

SERVICES_FOLDER="/services"

for service in app1 app2 app3
do
    echo "Applying Deployment for $service..."
    kubectl apply -f $SERVICES_FOLDER/$service/$service.yaml
done

echo "Applying Ingress..."
kubectl apply -f $SERVICES_FOLDER/ingress.yaml

echo "All resources applied!"
