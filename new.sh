#!/bin/bash

if [ "$#" -ne 1 ] ; then
  echo "Usage: $0 <title>" >&2
  exit 1
fi


title=`echo "$1" |sed 's/ /-/g'`
fileName="_posts/`date +%Y-%m-%d-$title.markdown`"

touch $fileName

cat > $fileName <<DELIM
---
layout: post
title: "$1"
date:  `date "+%Y-%m-%d %H:%M:%S"`
#banner_image: 

tags:
#- fun
#- diving
#- philipine
---
<!--more-->

[Basic syntax help for Markdown](http://daringfireball.net/projects/markdown/basics)
A First Level Header
====================
A Second Level Header
---------------------
Now is the time for all good men to come to
the aid of their country. This is just a
regular paragraph.
Some of these words *are emphasized*.
Some of these words _are emphasized also_.
Use two asterisks for **strong emphasis**.
Or, if you prefer, __use two underscores instead__.
### Header 3
> This is a blockquote.
>
> This is the second paragraph in the blockquote.
>
> ## This is an H2 in a blockquote
*   Dandy.
*   Gum.
1.  Red
2.  Green
3.  Blue
This is an [example link](http://example.com/).
[1]: http://google.com/        "Google"
[2]: http://search.yahoo.com/  "Yahoo Search"
[3]: http://search.msn.com/    "MSN Search"
To highlight:
{% highlight text linenos %}
some text to be syntax highlighted....
{% endhighlight %}
![alt text](/path/to/img.jpg "Title")
DELIM

vim $fileName +9
