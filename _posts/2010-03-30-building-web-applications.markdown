---
author: geeksinhk
comments: true
date: 2010-03-30 10:06:45+00:00
layout: post
link: https://geeksinhk.wordpress.com/2010/03/30/building-web-applications/
slug: building-web-applications
title: Google API and XHR request
wordpress_id: 56
categories:
- Cheatsheets
---

Google api:
http://code.google.com/apis/ajax/playground/

XHR request:

[sourcecode language="js"]
function loadXMLDoc(url)
{
        if (window.XMLHttpRequest)
        {// code for IE7+, Firefox, Chrome, Opera, Safari
                jsonhttp=new XMLHttpRequest();
        }
        else
        {// code for IE6, IE5
                jsonhttp=new ActiveXObject("Microsoft.XMLHTTP");
        }
        jsonhttp.open("GET",url,false);
        jsonhttp.send(null);
        document.write("Response from mysql:</br>");
        document.write(jsonhttp.responseText);
        return(JSON.parse(jsonhttp.responseText));
}
var result = loadXMLDoc('the_request.php');
[/sourcecode]
