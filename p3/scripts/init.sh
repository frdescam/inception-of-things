#!/bin/bash

CONF_FOLDER="/home/iot/inception-of-things/p3/scripts"

bash $CONF_FOLDER/install_kubectl.sh
bash $CONF_FOLDER/deploy_argocd.sh
bash $CONF_FOLDER/deploy_part3.sh
