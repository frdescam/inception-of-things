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

echo "[install ssh pubkey script] installing ssh key ..."
cat /vagrant/id_ed25519.pub >> /home/vagrant/.ssh/authorized_keys