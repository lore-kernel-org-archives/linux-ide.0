From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10216] kernel from different versions hangs with some CD/DVD drives
Date: Sun, 23 Nov 2008 15:18:18 -0800 (PST)
Message-ID: <20081123231818.AB2D110800F@picon.linux-foundation.org>
References: <bug-10216-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35875 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750818AbYKWXSU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Nov 2008 18:18:20 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mANNIIdN022779
	for <linux-ide@vger.kernel.org>; Sun, 23 Nov 2008 15:18:19 -0800
In-Reply-To: <bug-10216-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10216





------- Comment #25 from lars.winterfeld@tu-ilmenau.de  2008-11-23 15:18 -------
by looking through the dmesg output, you can see that the patch
http://bugzilla.kernel.org/attachment.cgi?id=18748&action=view did it for me in
all tested versions from 2.6.25 to 2.6.27.
i patched the original kernel ("vanilla-sources" as its called in gentoo) and
different sources which are patched by gentoo-developers. (main drivers part
should be the same...)
i patched drivers/ide/ide-iops.c, drivers/ide/ide-probe.c,
drivers/ide/pci/amd74xx.c as described and include/linux/ide.h like this:
        IDE_HFLAG_NO_UNMASK_IRQS        = (1 << 31),
+       /* AltStatus register can be unreliable*/
+       IDE_HFLAG_BROKEN_ALTSTATUS = IDE_HFLAG_PIO_NO_BLACKLIST,
  };


what is that "Clocksource tsc unstable" about?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
