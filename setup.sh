#!/bin/sh

setup_minikube()
{
    minikube delete
    echo "Removed all previous instance of minikube\n"
    #usermod -aG docker $(whoami) && newgrp docker
    minikube config unset driver
    echo "VM setup is done\n"
    minikube start --vm-driver=docker --cpus=2
    echo "Minikube launched\n"
    eval $(minikube docker-env)
}

setup_metallb()
{
    kubectl get configmap kube-proxy -n kube-system -o yaml | sed -e "s/strictARP: false/strictARP: true/" | kubectl apply -f - -n kube-system
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
    kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
    kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
    kubectl apply -f metallb/metallb-config.yaml
    echo "Metallb is running\n"
}

setup_images()
{
    docker build -t alpine_server ./nginx
}

setup_deployments()
{
    kubectl apply -f nginx/nginx.yaml
}


setup()
{
    setup_minikube
    setup_metallb
    setup_images
    setup_deployments
}

setup