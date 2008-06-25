From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Wed, 25 Jun 2008 11:58:32 -0700 (PDT)
Message-ID: <20080625185832.73F08108045@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34415 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752591AbYFYS7F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jun 2008 14:59:05 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5PIwW95020895
	for <linux-ide@vger.kernel.org>; Wed, 25 Jun 2008 11:58:33 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943





------- Comment #4 from gfpadovan@gmail.com  2008-06-25 11:58 -------
I tried to get theses info. But the system only show the services stopping on
shutdown. Could you help me?

ps: I made a Magic SysRq reboot and the machine rebooted ( with ahci as
module). I didn't have time to look this at kernel source, but I will do.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
