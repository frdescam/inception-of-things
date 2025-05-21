#! /bin/bash

INSTALLATION_MODE="$1"
INSTALLATION_IP="$2"
CONTROLLER_IP="$3"

if [ "$INSTALLATION_MODE" = "controller" ]
then
	echo "[k3s installation script] Starting installation in controller mode ..."
	curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=$INSTALLATION_IP" sh -

	echo "[k3s installation script] Waiting for k3s to start ..."
	while [ ! -f /var/lib/rancher/k3s/server/node-token ]
	do
		sleep 1
	done

	echo "[k3s installation script] Copying k3s token to shared folder ..."
	cp /var/lib/rancher/k3s/server/node-token /vagrant/

else
	echo "[k3s installation script] Starting installation in agent mode ..."
	curl -sfL https://get.k3s.io | \
		K3S_TOKEN="$(cat /vagrant/node-token)" \
		K3S_URL="https://$CONTROLLER_IP:6443" \
		INSTALL_K3S_EXEC="--node-ip=$INSTALLATION_IP" \
		sh -

	echo "[k3s installation script] Removing k3s token from shared folder ..."
	rm /vagrant/node-token
fi