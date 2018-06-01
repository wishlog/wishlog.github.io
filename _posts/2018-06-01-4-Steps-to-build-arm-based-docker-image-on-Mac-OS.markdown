---
layout: post
title: "4 Steps to build arm-based docker image on Mac OS"
date:  2018-06-01 23:55:22
banner_image: k8s-2.jpg

tags:
- arm
- kubernete
- docker
---

To build an arm image, we need the qemu emulator to emulate those arm executions in the image. First, extract the static linked qemu emulator from linux. 

1. To not mess with Mac, we do it in an *Ubuntu Docker*:
//On Ubuntu Docker
{% highlight bash %}
docker exec -it ubuntuContainer bash //within the ubuntu docker:
sudo apt install -y qemu qemu-user-static qemu-user binfmt-support
{% endhighlight %}

2. SCP the qemu-arm-static out from docker *Ubuntu Docker* machine to host *Mac*
//On Ubuntu Docker
{% highlight bash %}
scp qemu-arm-static scottie@10.0.0.257:~
{% endhighlight %}

<!--more-->
3. Register QEMU as the build agent in *Mac*:
//On Mac
Don't understand, but it works...
{% highlight bash %}
docker run --rm --privileged multiarch/qemu-user-static:register --reset
{% endhighlight %}

4. Create the Dockerfile with ubuntu-arm from *Mac*:
//On Mac
{% highlight bash %}
FROM armv7/armhf-ubuntu:16.04
COPY qemu-arm /usr/bin/qemu-arm-static
RUN echo Hello from ARM container
{% endhighlight %}

ref: https://blog.hypriot.com/post/setup-simple-ci-pipeline-for-arm-images/
