---
title: JavaScript Blacklist for Chrome
categories: [JavaScript, Programming]
---

One of the things I missed since I've switched back from Safari 5 to Google Chrome is [Drew Thaler][thaler]'s [JavaScript Blacklist][jsbl] extension. It blocks scripts from a configurable list of domains and is useful to get rid of some of the most annoying things on the internet like [IntelliTXT][wp-intellitxt] (those doubly underlined text link ads).

 [thaler]: http://homepage.mac.com/drewthaler/
 [jsbl]: http://homepage.mac.com/drewthaler/jsblacklist/
 [wp-intellitxt]: http://en.wikipedia.org/wiki/IntelliTXT

Since I haven't found an equivalent for Chrome, I wrote it myself, with some code taken from the Safari extension.

Due to limitations in Chrome's extension API, it needs to wait for a [message][chromext-msg] from the [background page][chromext-arch] with the blacklisted domains before it can start filtering `<script>`-tags. It might be possible that some script files starts to load before the extension kicks in and one of the scripts that gets loaded is on the blacklist. That can't be avoided until there's a way to do message passing synchronously. That issue aside, I'd say the API is rather pleasant to work with. At least the parts that I needed for this extension.

 [chromext-arch]: http://code.google.com/chrome/extensions/overview.html#arch
 [chromext-msg]: http://code.google.com/chrome/extensions/messaging.html

## Install & Source Code

You can install it from [Chrome extensions gallery][gallery-link]. If you're interested in the source code, it's [on github][jou-chrome-blacklist]. Patches are welcome.

 [gallery-link]: https://chrome.google.com/extensions/detail/gofhjkjmkpinhpoiabjplobcaignabnl
 [jou-chrome-blacklist]: http://github.com/jou/chrome-jsblacklist

I'm running `dev`-channel on Mac, but I tested it with the current stable version and it seems to work. I haven't tested it on Linux or Windows, but it should work.

## Feedback

[Drop me a line][contact] or open a bug on [github's issue tracker][gh-issue].

 [contact]: /pages/contact.html
 [gh-issue]: http://github.com/jou/chrome-jsblacklist/issues

## Todo

I have no idea of graphics design and the current logo sucks bad. If someone would like to make a decent logo, I'd gladly accept the help.

Also, the settings page could be made a bit prettier.
