#! /bin/bash

if [ "$1" = "controller" ]
then
	echo "[provisioned script] Starting installation in controller mode ..."
	curl -sfL https://get.k3s.io | sh -
	sleep 30
	cp /var/lib/rancher/k3s/server/node-token /vagrant/
else
	echo "[provisioned script] Starting installation in agent mode ..."
	curl -sfL https://get.k3s.io | \
		K3S_TOKEN=$(cat /vagrant/node-token) K3S_URL=https://$2:6443 sh -
fi
