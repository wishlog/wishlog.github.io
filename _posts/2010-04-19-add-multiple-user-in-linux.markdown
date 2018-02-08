---
author: geeksinhk
comments: true
date: 2010-04-19 04:10:44+00:00
layout: post
link: https://geeksinhk.wordpress.com/2010/04/19/add-multiple-user-in-linux/
slug: add-multiple-user-in-linux
title: Add multiple user in linux
wordpress_id: 63
categories:
- Cheatsheets
---

http://www.cyberciti.biz/tips/linux-how-to-create-multiple-users-accounts-in-batch.html

for i in `seq 1 30`;
do
echo -n "group$i:group$i:"
echo -n $i | awk '{printf 1;printf "%03d", $1;}'
echo :506:Student user:/home/user$i:/bin/bash

done
