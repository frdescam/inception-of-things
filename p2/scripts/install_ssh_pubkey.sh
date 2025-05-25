#! /bin/bash

echo "[install ssh pubkey script] installing ssh key ..."
cat /vagrant/id_ed25519.pub >> /home/vagrant/.ssh/authorized_keys