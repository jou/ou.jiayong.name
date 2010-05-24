---
title: Contact
layout: page
---
E-Mail: <span id="contact_email">ou@<a href="http://jiayong.name">this domain</a></span>  
Skype: [jia.yong.ou](skype:jia.yong.ou)  
Twitter: [@jiayongou](http://twitter.com/jiayongou)

<script type="text/javascript">
(function(){
    var domainParts = location.host.split('.');
    var decodedEmail = domainParts.shift() + '@' + domainParts.join('.');
	var emailSpan = document.getElementById("contact_email");
	emailSpan.innerHTML = '<a href="mailto:' + decodedEmail + '">' + decodedEmail +'</a>';
})();
</script>