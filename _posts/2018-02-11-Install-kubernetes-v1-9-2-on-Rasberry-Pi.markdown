---
author: geeksinhk
layout: post
title: "Install kubernetes v1.9.2 on Rasberry Pi"
date:  2018-02-11 00:25:33
banner_image: k8s-1.jpg

tags:
- raspberry pi
- kubernetes
---
Below are the steps to install 5 nodes + 1 master of k8s on Raspberry Pi

SD card preparation
====================
Prepare 6 SD cards and flash with the Hypriot OS, this would be the most stable OS as of today.
Install the tool flash
{% highlight bash %}
curl -O https://raw.githubusercontent.com/hypriot/flash/master/$(uname -s)/flash
chmod +x flash
sudo mv flash /usr/local/bin/flash
{% endhighlight %}

<!--more-->

Flashing 6 SD card with the latest Hyprio OS - hostname from node[01-06]
{% highlight bash %}
flash --hostname node01 https://github.com/hypriot/image-builder-rpi/releases/download/v1.7.1/hypriotos-rpi-v1.7.1.img.zip
{% endhighlight %}

Default username and password would be pirate:hypriot, make sure to change it before proceed.

Install kubeadm on master and other nodes
====================
Use root privilege to install kubeadm on all 6 raspberry pi
{% highlight bash %}
sudo su -
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
apt-get update && apt-get install -y kubeadm
{% endhighlight %}


For the Master node
---------------------
Deploy the master with the below network, better don't change the network mask, since other plugins (flannel) are also using the same one for somea reason I don't know. Better don't take the extra risk for nothing :)
{% highlight bash %}
kubeadm init --pod-network-cidr 10.244.0.0/16
{% endhighlight %}

After installation, it should prompt for something like this below (for k8s version 1.9.2)
{% highlight bash %}
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
{% endhighlight %}

For the rest of 5 slave nodes
---------------------
After master node deployted, it should prompt for something like below for connectng to the master node.
{% highlight bash %}
kubeadm join --token 1-masked-5e31-masked-d90bc 192.168.-.-:6443 --discovery-token-ca-cert-hash sha256:6bbb9bdd507c1f58510--masked--0f37cba2d62--masked--00af6cb69a7
{% endhighlight %}

Last step - to deploy the flannel network driver
====================
Instead of following the tutorial from Hypriot for v0.7.1 or v0.8, we install the latest one from the community.
In which, we don't have to install the rbac. (Not sure if RBAC is already included, but the below deployment works anyway).
{% highlight bash %}
curl -sSL https://rawgit.com/coreos/flannel/master/Documentation/kube-flannel.yml | sed "s/amd64/arm/g" | kubectl apply -f -
{% endhighlight %}

Notice that the script is "apply" instead of "create".

Finally, you should be able to get below:
{% include image_caption.html imageurl="/images/posts/k8s-1.jpg" title="Apple Super" caption="After connecting 1 slave node (node02) to master" %}

Last and the least step - Upgrade to the latest version (v1.9.3)
========================
Run the below two command can conduct the upgrade:
kubeadm upgrade plan
kubeadm upgrade apply vxxx

However, we have to upgrade kubeadm before proceed:
{% highlight bash %}
export VERSION=$(curl -sSL https://dl.k8s.io/release/stable.txt) # or manually specify a released Kubernetes version
export ARCH=arm # or: arm, arm64, ppc64le, s390x
curl -sSL https://dl.k8s.io/release/${VERSION}/bin/linux/${ARCH}/kubeadm > /usr/bin/kubeadm
$ chmod a+rx /usr/bin/kubeadm
{% endhighlight %}

Store the kubeadm init's flags:
{% highlight bash %}
kubeadm config upload from-flags --pod-network-cidr 10.244.0.0/16
{% endhighlight %}

Apply the upgrade
{% highlight bash %}
kubeadm upgrade plan
kubeadm upgrade apply 
{% endhighlight %}

It failed and get the below error:
{% highlight bash %}
[upgrade/apply] FATAL: couldn't upgrade control plane. kubeadm has tried to recover everything into the earlier state. Errors faced: [timed out waiting for the condition]
{% endhighlight %}

Go back to v1.9.2.... 
kubeadm upgrade apply 1.9.2

Some useful commands
========================
In case it fucked up, you can reset everything with below:
{% highlight bash %}
kubeadm reset
{% endhighlight %}


Enable CPU and memory accounting:
{% highlight bash %}
mkdir -p /etc/systemd/system.conf.d
cat <<EOF >/etc/systemd/system.conf.d/kubernetes-accounting.conf
[Manager]
DefaultCPUAccounting=yes
DefaultMemoryAccounting=yes  
EOF

#Reload it
systemctl daemon-reload
{% endhighlight %}



Ref:
https://blog.hypriot.com/post/setup-kubernetes-raspberry-pi-cluster/
