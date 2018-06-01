---
layout: post
title: "Install helm on raspberry pi (ARM device)"
date:  2018-06-01 15:57:47
banner_image: k8s-1.jpg

tags:
#- fun
#- diving
#- philipine
- kubernetes
- helm
- arm
---

Install helm and tiller on kubernetes on raspberry pi
---------------------
Installation of helm and tiller is not straight forward on arm device. Since, by default, the helm will pick a non-arm image of tiller to deploy on kubernetes and make the pod crash.
Easiest way is to pick some existing arm version of tiller image to deploy on server.
E.g. one from jessestuart:
{% highlight bash %}
helm init --tiller-image=jessestuart/tiller:v2.9.1
{% endhighlight %}

For non-production use, the role binding of cluster-admin and default/kube-system can be found below:
{% highlight bash %}
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default
{% endhighlight %}

<!--more-->
Currently, not much helm charts in arm can be found, some outdated examples can be located here:
{% highlight bash %}
helm repo add arm-stable https://peterhuene.github.io/arm-charts/stable
{% endhighlight %}

