---
author: geeksinhk
comments: true
date: 2013-09-03 07:25:14+00:00
layout: post
link: https://geeksinhk.wordpress.com/2013/09/03/greeting-according-to-different-location-ip/
slug: greeting-according-to-different-location-ip
title: Greeting according to different location (IP)
wordpress_id: 85
tags:
- fun
- script
---

Imagine when you carry your own notebook to do assessment in different client sites. You would like to run several scripts and have to put different configuration files for different sites. I found its quite useful when you can notify to yourself what IP you current have and change your working directory to certain folder. Here is the script to put in the ~/.profile when you are using a Mac


{% highlight bash %}#Check if I am at office
networksetup -getinfo Wi-Fi| grep -x "Router: 123.123.123.123" > /dev/null && cd /Users/anony/Documents/work && \
toilet -f mono12 -F metal Office
{% endhighlight %}

You can obtain the "toilet" program by "sudo port install toilet" in Mac.{% endhighlight %}


Here is the result when I am in Office with IP 123.123.123.123


[![](http://geeksinhk.files.wordpress.com/2013/09/7cf11-screenshot2011-12-13at4-55-39pm.png?w=300)](http://4.bp.blogspot.com/-XsEL7Kcod6Y/TucU5yAOVOI/AAAAAAAAPjQ/DGeg9XPF4t8/s1600/Screen+Shot+2011-12-13+at+4.55.39+PM.png)

