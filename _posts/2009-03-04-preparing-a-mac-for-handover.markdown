---
title: Preparing a Mac to nicely hand over to another person
categories: [Mac, Shell-Fu, Howto]
---

So I’m parting with my good old first generation Macbook Pro and being nice as I am, I’d like to hand over the machine to the new owner fully updated and with iLife and iWork installed. So for that, I’ll have to install Leopard, install updates (tons of ‘em), install $whatever, install more updates, delete the user you used to install all that stuff and finally restore the Setup Assistant.
 

This post is about the last two points (especially the ‘delete user’ part) since the points before that are pretty boring.
 

While Mac OS X *does* have `/etc/passwd` and `/etc/groups`, those files only get used when booted in single user mode. In normal operation, it pulls users, groups and group memberships from [Open Directory][1] to make things more complicated.
 

While the [restoring Setup Assistant][2] part is easy and well-known, deleting a user in single user mode is more tricky. I did found hints to [delete users from the shell][3], but I need to get the directory service running first when I’m in single user mode. And I need to be in single user mode since I’m going to remove the only account on the machine.
 

Well then, let’s get started by booting into single user mode and do the usual thing and remount the hard disk writeable. For this guide, we’ll assume we want to get rid of the user `test`.
 

    # mount -uw
 

Trying to run dscl at this point makes it complain about Directory Services not running
 

    # dscl . list /users;
    For Single User Mode you must run the following command to enable use of dscl.;
    launchctl load /System/Library/LaunchDaemons/com.apple.DirectoryServicesLocal.plist
 

Sounds helpful, doesn’t it? So we start the local directory service and try again. But when we use `dscl` again, the same (at this point not very) helpful message greets us again:
 

    # launchctl load /System/Library/LaunchDaemons/com.apple.DirectoryServicesLocal.plist;
    # dscl . list /users;
    For Single User Mode you must run the following command to enable use of dscl.;
    launchctl load /System/Library/LaunchDaemons/com.apple.DirectoryServicesLocal.plist
 

While it tells you that you need to load `/System/Library/LaunchDaemons/com.apple.DirectoryServicesLocal.plist`, what it doesn’t tell you is that you also need `/System/Library/LaunchDaemons/com.apple.DirectoryServices.plist`
 

    # launchctl load /System/Library/LaunchDaemons/com.apple.DirectoryServicesLocal.plist;
    # launchctl load /System/Library/LaunchDaemons/com.apple.DirectoryServices.plist
 

So finally we have access to the directory and do the hacking on it. Yay!
 

For now, we assume we want to get rid of the user `test`. First we remove all his group memberships with this little bash one liner.
 

    # for group in `groups test`; do dscl . delete /groups/$group GroupMembership test; done;
 

Now we get rid of the user and its home directory:
 

    # dscl . delete /users/test;
    # rm -rf /Users/test
 

Finally, we make Mac OS X thinking that the Setup Assistant hasn’t been run yet and shut down the box:
 

    # rm /var/db/.AppleSetupDone;
    # shutdown -h now
 

So now the Mac is in a more or less factory settings, plus the stuff you installed earlier.

 [1]: http://en.wikipedia.org/wiki/Apple_Open_Directory
 [2]: http://theappleblog.com/2008/06/22/reset-os-x-password-without-an-os-x-cd/
 [3]: http://www.oreillynet.com/mac/blog/2006/04/deleting_mac_os_x_users_remote.html
