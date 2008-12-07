From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10216] kernel from different versions hangs with some CD/DVD drives
Date: Sun,  7 Dec 2008 14:38:55 -0800 (PST)
Message-ID: <20081207223855.458C310800C@picon.linux-foundation.org>
References: <bug-10216-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45722 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754905AbYLGWjO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2008 17:39:14 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mB7Mctfv015945
	for <linux-ide@vger.kernel.org>; Sun, 7 Dec 2008 14:38:56 -0800
In-Reply-To: <bug-10216-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10216





------- Comment #32 from sshtylyov@ru.mvista.com  2008-12-07 14:38 -------
(In reply to comment #31)
> Sergei: I looked into it (under QEMU for now) and adding msleep(1000) +
> printk() to ide_init() causes the "Clocksource tsc unstable" to appear before
> IDE initialization so it seems that the issue is caused by some other kernel
> code and IDE is just unlucky to be initialized at same time as clocksource
> watchdog triggers.

I guess it's caused by mspleep(1000) call itself. If ide_wait_not_ready() is
touching the other watchdogs anyway, I don't see why it shouldn't touch the
clocksource watchdog too.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
