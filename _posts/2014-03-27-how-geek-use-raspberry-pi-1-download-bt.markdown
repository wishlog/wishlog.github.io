---
author: geeksinhk
comments: true
date: 2014-03-27 11:42:20+00:00
layout: post
link: https://geeksinhk.wordpress.com/2014/03/27/how-geek-use-raspberry-pi-1-download-bt/
slug: how-geek-use-raspberry-pi-1-download-bt
title: How geek use raspberry pi (1) - Download BT
wordpress_id: 112
categories:
- Fun for Geeks
---

As that's quite time consuming to go to the torrent site and search bt files from it, the geeks wrote a 'oneliner' (actually 2 lines) to perform the search:


<blockquote>root@raspberrypi:~# cat /usr/bin/search
#!/bin/sh
lynx -dump "http://thepiratebay.se/search/$@/0/7/0"|grep magnet | sed 'y/+/ /; s/%/\\x/g' | xargs -L 1 echo -e

#transmission-remote -n "transmission:the password lor" -a "magnet:?xt=urn:btih..."</blockquote>


And here is the script to download the torrent with transmission x:


<blockquote>root@raspberrypi:~# cat /usr/bin/download
#!/bin/sh
transmission-remote -n "transmission:okay, you win" -a "$@"</blockquote>


That's how it looks like for a search:


<blockquote>root@raspberrypi:~# search harvard business school
25. magnet:?xt=urn:btih:19ce84592aec23ca73f017f7643fb21b9b22dce2&dn=Harvard Business Review - 10 Must Reads on Strategy x5BPDFx5D x5BQwert&tr=udpx3Ax2Fx2Ftracker.openbittorrent.comx3A80&tr=udpx3Ax2Fx2Ftracker.publicbt.comx3A80&tr=udpx3Ax2Fx2Ftracker.istole.itx3A6969&tr=udpx3Ax2Fx2Ftracker.ccc.dex3A80&tr=udpx3Ax2Fx2Fopen.demonii.comx3A1337
30. magnet:?xt=urn:btih:8b7a78d69ba037175d3ac4c2fe91fa8269eb183e&dn=Harvard Business Review - April 2014 USA&tr=udpx3Ax2Fx2Ftracker.openbittorrent.comx3A80&tr=udpx3Ax2Fx2Ftracker.publicbt.comx3A80&tr=udpx3Ax2Fx2Ftracker.istole.itx3A6969&tr=udpx3Ax2Fx2Ftracker.ccc.dex3A80&tr=udpx3Ax2Fx2Fopen.demonii.comx3A1337
36. magnet:?xt=urn:btih:20a0ea7c101eee5f67f25e9d4ff30873e8b5f9a3&dn=Harvard Business Review - February 2014 USA&tr=udpx3Ax2Fx2Ftracker.openbittorrent.comx3A80&tr=udpx3Ax2Fx2Ftracker.publicbt.comx3A80&tr=udpx3Ax2Fx2Ftracker.istole.itx3A6969&tr=udpx3Ax2Fx2Ftracker.ccc.dex3A80&tr=udpx3Ax2Fx2Fopen.demonii.comx3A1337
42. magnet:?xt=urn:btih:6a3d4a510ab735efd98905aec2bf74bd0ad50cfe&dn=Harvard Business Review - March 2014 USA&tr=udpx3Ax2Fx2Ftracker.openbittorrent.comx3A80&tr=udpx3Ax2Fx2Ftracker.publicbt.comx3A80&tr=udpx3Ax2Fx2Ftracker.istole.itx3A6969&tr=udpx3Ax2Fx2Ftracker.ccc.dex3A80&tr=udpx3Ax2Fx2Fopen.demonii.comx3A1337<---snip---></blockquote>


Here is how we download:


<blockquote>root@raspberrypi:~# download "magnet:?xt=urn:btih:8b7a78d69ba037175d3ac4c2fe91fa8269eb183e&dn=Harvard Business Review - April 2014 USA&tr=udpx3Ax2Fx2Ftracker.openbittorrent.comx3A80&tr=udpx3Ax2Fx2Ftracker.publicbt.comx3A80&tr=udpx3Ax2Fx2Ftracker.istole.itx3A6969&tr=udpx3Ax2Fx2Ftracker.ccc.dex3A80&tr=udpx3Ax2Fx2Fopen.demonii.comx3A1337"
localhost:9091/transmission/rpc/ responded: "success"</blockquote>
