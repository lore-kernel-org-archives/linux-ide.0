From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10086] 2.6.25-rc2 + smartd = hang
Date: Sun, 23 Mar 2008 08:08:15 -0700 (PDT)
Message-ID: <20080323150815.BDB70108039@picon.linux-foundation.org>
References: <bug-10086-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52551 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750898AbYCWPIS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Mar 2008 11:08:18 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2NF8F9k011656
	for <linux-ide@vger.kernel.org>; Sun, 23 Mar 2008 08:08:17 -0700
In-Reply-To: <bug-10086-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10086





------- Comment #11 from gordonfarquharson@gmail.com  2008-03-23 08:08 -------
I did check for the debug strings in the versions of the modules that are
executed (/lib/modules...). I made the changes to the source, recompiled, and
then copied ide-cd_mod.ko and ide-core.ko to /lib/modules/`uname
-r`/kernel/drivers/ide, and zImage to /boot. I'll try a full installation of
the kernel and modules to see if that makes a difference.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
