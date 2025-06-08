# INCEPTION OF THINGS

## Presentation

This is a project from 42 school, its goal was to let us learn the basics of cloud infrastructure through:

- VM (Vagrant)
- Kubernetes (K3s)
- Continuous deployment (ArgoCD)

But we chose to go way further than the mandatory part of the subject by doing the suggested bonus:

- Setting up a Gitlab instance on K3s as the source of IaC

As well as our own bonuses:

- Implementing https and http to https redirection (p2)
- Building docker image from Dockerfile locally (p2)

## Architecture
![architecture](.git-assets/architecture.png)

## Usage


This project was created to run on a Debian VM. It should work on any Debian/Ubuntu installation though.

First, you need to install the dependencies. Every part was designed to run independently so the only thing to do is run the `install_dependencies.sh` script before launching each part.

The first two parts can be run by executing `vagrant up` in the appropriate folder.

Don't hesitate to run `vagrant destroy -f && vagrant up` if you already ran that part once.

The third and bonus parts, which do not use Vagrant, can be run using the `init.sh` script in the scripts folder.

For bonus part, it is mandatory to run first the `deploy_gitlab.sh` script (Then wait a loooong time for Gitlab to start) then the `populate_gitlab_repo.sh` script and finally set the newly created repository as a public one for ArgoCD to be able to access it.

For parts two, three and bonus, we provide a `set_hosts.sh` script that will reset the `/etc/hosts` file to provide hostnames like :

- app1.com
- app2.com
- app3.com
- part3.iot.local
- argocd.iot.local
- gitlab.iot.local