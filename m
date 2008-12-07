From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10216] kernel from different versions hangs with some CD/DVD drives
Date: Sun,  7 Dec 2008 13:08:07 -0800 (PST)
Message-ID: <20081207210807.093AA10800C@picon.linux-foundation.org>
References: <bug-10216-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51730 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbYLGVII (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2008 16:08:08 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB7L87uA010844
	for <linux-ide@vger.kernel.org>; Sun, 7 Dec 2008 13:08:08 -0800
In-Reply-To: <bug-10216-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10216





------- Comment #31 from bzolnier@gmail.com  2008-12-07 13:08 -------
Sergei: I looked into it (under QEMU for now) and adding msleep(1000) +
printk() to ide_init() causes the "Clocksource tsc unstable" to appear before
IDE initialization so it seems that the issue is caused by some other kernel
code and IDE is just unlucky to be initialized at same time as clocksource
watchdog triggers.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
