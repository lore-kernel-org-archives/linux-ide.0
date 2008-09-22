From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11602] cdrom drive cannot open the tray, but reported this badly in /proc/sys/dev/cdrom/info
Date: Sun, 21 Sep 2008 23:54:40 -0700 (PDT)
Message-ID: <20080922065440.8D8E2108056@picon.linux-foundation.org>
References: <bug-11602-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52314 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751181AbYIVGym (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 02:54:42 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8M6seLW015542
	for <linux-ide@vger.kernel.org>; Sun, 21 Sep 2008 23:54:41 -0700
In-Reply-To: <bug-11602-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11602





------- Comment #6 from nm127@freemail.hu  2008-09-21 23:54 -------
In case of a list of devices which reports "tray" and cannot close the door I
could imagine a list which is marked with __initdata and only in the memory
when the module is loading. (This is not the case for the current
ide_cd_quirks_list[] in drivers/ide/ide-cd.c .)

I don't know if similar structure to Desktop Management Interface (DMI,
http://www.dmtf.org/standards/dmi/ ) already exists for IDE. The interface (
linux/dmi.h ) is used several points of the kernel when the task is to identify
a motherboard or BIOS version.

In case you close the door and try to lock and read sense data there could be a
problem when there is no media in the drive. In this case I'm not sure that you
can lock the door at all.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
