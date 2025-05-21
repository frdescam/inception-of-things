#! /bin/bash
#
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    install_k3s.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: frdescam <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/17 19:44:43 by frdescam          #+#    #+#              #
#    Updated: 2022/10/21 19:46:15 by frdescam         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

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

	echo "[k3s installation script] Copying node-token to shared folder ..."
	cp /var/lib/rancher/k3s/server/node-token /vagrant/

else
	echo "[k3s installation script] Starting installation in agent mode ..."
	curl -sfL https://get.k3s.io | \
		K3S_TOKEN="$(cat /vagrant/node-token)" \
		K3S_URL="https://$CONTROLLER_IP:6443" \
		INSTALL_K3S_EXEC="--node-ip=$INSTALLATION_IP" \
		sh -

	echo "[k3s installation script] Removing files from shared folder ..."
	rm /vagrant/id_ed25519.pub /vagrant/node-token
fi

# This shouldn't be here, it has nothing to do with k3s installation
echo "[k3s installation script] Authorizating ssh key ..."
cat /vagrant/id_ed25519.pub >> /home/vagrant/.ssh/authorized_keys