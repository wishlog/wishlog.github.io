---
author: geeksinhk
comments: true
date: 2013-09-03 07:16:53+00:00
layout: post
link: https://geeksinhk.wordpress.com/2013/09/03/manage-multiple-clients-with-scripts/
slug: manage-multiple-clients-with-scripts
title: Manage multiple clients with scripts
wordpress_id: 79
tags:
- security
- pentest
---

For a penetration test, most checking procedures are standardized and routine. Don't you ever feel tired by typing nmap, Nessus, or Saint every single time when you start the test? Are you still feeling safe and rational to type 'cd' a thousand times for changing directories to manage your projects? Even if you upgraded yourself proudly and start using some funny GUI interface from Nexpose or Tenable, you will still suffer from managing them manually. Those automated tools will no longer helpful or customizable when you meet an standard crappy IPS that blocks typical scanning.

Manual assessment is your own value position to distinguish yourself from others in terms of skills, knowledge and speed! But the term "manual" are often over used by companies. It doesn't mean you have to spend your time and effort to keep typing ls and cd on the keyboards with your bloody hand but your mental power to think of an alternate route to penetrate into the system. Here is a handy script I written for myself to save my time, make a penetration test in a more organized manner and help you focus on a real hacking but not typing.

[![](http://geeksinhk.files.wordpress.com/2013/09/20e54-screenshot2011-12-13at5-32-52pm.png?w=208)](http://3.bp.blogspot.com/-8r4ElIh9rYY/TucbsE49zFI/AAAAAAAAPjg/82KGuvw-Gds/s1600/Screen+Shot+2011-12-13+at+5.32.52+PM.png)

<!--more-->

  With this script, you can create your client folder (when not exist), make standard directories to store scanning results, findings, ip list and etc by just typing:

<blockquote>client my_client_name</blockquote>

 Happy hacking!

p.s. Yahoo is not my client, yet.
