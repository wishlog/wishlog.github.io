---
layout: post
title: "Static application security testing (SAST)"
date:  2021-01-11 17:56:30
#banner_image: 

tags:
#- SAST
#- security
#- assessment
#- grep
---
<!--more-->

Static source code scanning keywords for grep / findstr
====================
A Second Level Header
---------------------
Keyword list:
1. https://littlemaninmyhead.wordpress.com/2019/08/04/dont-underestimate-grep-based-code-scanning/
Visual studio can use "|" to separate the keywords, keywords extracted from above:

password|passwd|credential|passphrase|sql|query\(|strcat|strcpy|strncat|strncpy|sprintf|gets|setAllowsAnyHTTPSCertificate|validatesSecureCertificate|allowInvalidCertificates|kCFStreamSSLValidatesCertificateChain|crypt|CCCrypt|md5|sha1|sha-1|3des|des3|TripleDES|debuggable|WRITE_EXTERNAL_STORAGE|sdcard|getExternalStorageDirectory|isExternalStorageWritable|MODE_WORLD_READABLE|MODE_WORLD_WRITEABLE|SSLSocketFactory|SecretKeySpec|PBEParameterSpec|PasswordDeriveBytes|rc4|arcfour|exec\(|eval\(|http:|ftp:|ALLOW_ALL_HOSTNAME_VERIFIER|AllowAllHostnameVerifier|printStackTrace|readObject\(|dangerouslySetInnerHTML|trustAsHtml|Math\.random\(|java\.util\.Random|SAXParserFactory|DOM4J|XMLInputFactory|TransformerFactory|javax\.xml\.validation\.Validator|SchemaFactory|SAXTransformerFactory|XMLReader\ SAXBuilder|SAXReader|javax\.xml\.bind\.Unmarshaller|XPathExpression\ DOMSource|StAXSource|controller|HttpServletRequest|request\.getParameter|exec|getAcceptedIssuers|isTrusted|trustmanager|ServerCertificateValidationCallback|checkCertificateName|checkCertificateRevocationList|NODE_TLS_REJECT_UNAUTHORIZED|rejectUnauthorized|insecure|strictSSL|clientPemCrtSignedBySelfSignedRootCaBuffer|NSExceptionDomains|NSAllowsArbitraryLoads|NSExceptionAllowsInsecureHTTPLoads|kSSLProtocol3|kSSLProtocol2|kSSLProtocolAll|NSExceptionMinimumTLSVersion|public-read|AWS_KEY|urllib3\.disable_warnings|ssl_version|cookie|kSecAttrAccessibleAlways

2. https://github.com/floyd-fuh/crass (https://github.com/floyd-fuh/crass/blob/b057474284dd63b7f44eba9f1d2908578f5b6816/testing/tests/grep-test/file.txt)



Tools for keyword grep
---------------------
1. SonarQube: https://github.com/VillageChief/sonarqube, https://docs.sonarqube.org/latest/analysis/languages/swift/
2. SearchDiggity: https://resources.bishopfox.com/resources/tools/google-hacking-diggity/attack-tools/#searchdiggity-v-3
3. CRASS: https://github.com/floyd-fuh/crass

Refernce:
https://samate.nist.gov/index.php/Source_Code_Security_Analyzers.html


![alt text](/path/to/img.jpg "Title")
