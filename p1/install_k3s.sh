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

if [ "$1" = "controller" ]
then
	echo "[provisioned script] Starting installation in controller mode ..."
	curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.56.110" sh -
	echo "[provisioned script] Waiting for k3s to start ..."
	while [ ! -f /var/lib/rancher/k3s/server/node-token ]
	do
		sleep 1
	done
	echo "[provisioned script] Copying node-token to shared folder ..."
	cp /var/lib/rancher/k3s/server/node-token /vagrant/
	echo "[provisioned script] Authorizating ssh key ..."
	cat /vagrant/id_ed25519.pub >> /home/vagrant/.ssh/authorized_keys
else
	echo "[provisioned script] Starting installation in agent mode ..."
	curl -sfL https://get.k3s.io | \
		K3S_TOKEN=$(cat /vagrant/node-token) K3S_URL=https://$2:6443 INSTALL_K3S_EXEC="--node-ip=192.168.56.111" sh -
	echo "[provisioned script] Authorizating ssh key ..."
	cat /vagrant/id_ed25519.pub >> /home/vagrant/.ssh/authorized_keys
	echo "[provisioned script] Removing files from shared folder ..."
	rm /vagrant/id_ed25519.pub /vagrant/node-token
fi
