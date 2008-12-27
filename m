From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Sat, 27 Dec 2008 00:27:48 -0800 (PST)
Message-ID: <20081227082748.89058108048@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51220 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751419AbYL0I2U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Dec 2008 03:28:20 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBR8Rm2r008305
	for <linux-ide@vger.kernel.org>; Sat, 27 Dec 2008 00:27:49 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144





------- Comment #27 from bbpetkov@yahoo.de  2008-12-27 00:27 -------
Hi,

Thanks, hope your holidays were happy too! Ok, well, I'm afraid that we'll have
to trace the driver to see exactly what happens. Here's how:

1. Apply the attached big debug patch + whitelist entry for your drive in the
quirks list ontop of the last audio ops patch
2. Build your kernel, reboot the machine (here you'll see lots of output
whizzing by)
3. Send me the whole boot log (I assume dmesg output will be truncated so you
can cut it from /var/log/syslog instead, since you're using a debian system)


Thanks for your debugging help so far :).


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
