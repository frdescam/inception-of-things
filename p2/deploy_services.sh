#!/bin/bash

SERVICES_FOLDER="/services"

for service in app1
do
	kubectl apply -f $SERVICES_FOLDER/$service/$service.deployment.yaml
	kubectl apply -f $SERVICES_FOLDER/$service/$service.service.yaml
done

kubectl apply -f $SERVICES_FOLDER/ingress.yaml

