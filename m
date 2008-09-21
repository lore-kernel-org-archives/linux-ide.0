From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11602] cdrom drive cannot open the tray, but reported this badly in /proc/sys/dev/cdrom/info
Date: Sat, 20 Sep 2008 22:34:57 -0700 (PDT)
Message-ID: <20080921053458.0102811D109@picon.linux-foundation.org>
References: <bug-11602-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42867 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750743AbYIUFfA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Sep 2008 01:35:00 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8L5YwPK024781
	for <linux-ide@vger.kernel.org>; Sat, 20 Sep 2008 22:34:59 -0700
In-Reply-To: <bug-11602-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11602


bbpetkov@yahoo.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bbpetkov@yahoo.de




------- Comment #3 from bbpetkov@yahoo.de  2008-09-20 22:34 -------
On a first look, your check is wrong:

        cdinfo(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
+       printk(KERN_DEBUG "%s:%u: cdi->mask=0x%X, (cdi->mask &
CDC_CLOSE_TRAY)=%s\n",
+               __FILE__, __LINE__, cdi->mask, (cdi->mask & CDC_CLOSE_TRAY) ?
"TRUE" : "FALSE");

you're checking against cdi->mask but if you see how CDROM_CAN is defined:

#define CDROM_CAN(type) (cdi->ops->capability & ~cdi->mask & (type))

you see that the mask is negated and also cdi->ops->capability comes into play.

However, the problem is that the CDC_CLOSE_TRAY is turned on (i.e. is going to
be off in the final check and yes, it _IS_ confusing :)) in the cdi->mask only
for devices with caddy and popup loading mechanisms. I don't think we can
reliably detect whether the drive can close its tray now on a drive-by-drive
basis - from what i see in your dmesg output, your drive is mechtype_tray and
such drives normally can close the tray. Alternatively, we could make another
list :( of drive model names which cannot close its mechanism but this is kinda
overkill imho. Jens, Bart?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
