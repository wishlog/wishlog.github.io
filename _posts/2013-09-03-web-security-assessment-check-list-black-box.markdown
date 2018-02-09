---
author: geeksinhk
comments: true
date: 2013-09-03 07:29:29+00:00
layout: post
link: https://geeksinhk.wordpress.com/2013/09/03/web-security-assessment-check-list-black-box/
slug: web-security-assessment-check-list-black-box
title: 'Web security assessment check list. (Black box) '
wordpress_id: 89
tags:
- security
- web
---

There are several things we gonna check on building a secure web page. Assumed that the assessment is done on black box. Here we included some steps and procedures for a simple analysis on a web page. The following is from 2010, it take no reference from SANS and OWASP's checklist, but it contains what comes up my mind at the moment I post.


	
  1. Check the machine location and route. Is it only accessible through internal network or publicly reachable (Exclude mainland)? Is it behind a low balancer and firewall? Is it located on a distributed network or member of the cloud? Any fingerprint from whois/netcraft?

	
  2. Check the machine type. Is there any other services running beside port 80 and 443? Scanner like nmap/nessus may help. What OS and server is the machine running? Apache/IIS/WebSphere/Tomcat...? What version is it?

	
  3. Check the purpose of the web server. Is it a dynamic website with user involvement? Is there a database behind? What version will the database properly be, according to the httpd server? MySQL/Oracle/DB2/... Say if it is running apache most likely it work with LAMP. And if windows is the host, it may have IIS, ASP, Access, IIS database manager... or still WAMP. Will this server further connect to other internal computer for retrieving contents? What are the host properly behind? (You may know it from jobsdb or make a phone call to their datacenter :)

	
  4. Check vulnerable third party (close /open source) code. Do they use 3rd party code in their web server? How are they vulnerable? Do they store those code on their own server or ask your client browser to connect to them? If the client's DNS is poisoned and retrieve third party codes from badguys, will Charlie say thats really hurt? Is there any dynamic links to other page contents which can be polluted? e.g. Email server may execute contents from sender, Sammy worm move around on MySpace.

	
  5. Check Client side code. Will the client side expose any information that they don't want to disclose to you? Any keywords like test, fix, password and comments? Any server code exposed on the client side?

	
  6. Check client side injection. Is there any known injections can be done on client side? XSS/TAG injection/... Can they bypass server and client side filtering by changing encoding method?

	
  7. Check server side injection. Is there any known injections / vulnerability exist on the server side? (Blind) SQL injection / BOF / ... Can we further bypass the server side defense mechanism? HPP on web application firewall? Buffer overflow on HTMLEntities?

	
  8. Check cross domain issue. Can a CSRF attack be launched on that site? Any crossdomain.xml file? Do they accept XHR/XDR request from third party site? Do they check origin header / referrer header?

	
  9. Do they aware/care their site being cloaking by other domain? Any risk if someone rewrap their contents? Who cares about clickJacking?

	
  10. Check Design / implementation flaw. Can a normal user escalate their privilege by tampering request parameter / Obtaining next session ID / manipulate their cookies / ... Any broken page that expose server information or functions not working?

	
  11. Check for performance. Yslow?

