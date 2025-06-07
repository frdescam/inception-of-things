#!/bin/bash

sudo bash -c "cat > /etc/hosts << EOF
127.0.0.1	localhost
127.0.1.1	iot.local iot

127.0.0.1	gitlab.iot.local
127.0.0.1	part3.iot.local # Port 8888
127.0.0.1	argocd.iot.local # Port 8080

192.168.56.110	app1.com
192.168.56.110	app2.com
192.168.56.110	app3.com
EOF"
