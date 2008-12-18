From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Thu, 18 Dec 2008 07:45:35 -0800 (PST)
Message-ID: <20081218154535.98134108048@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43054 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750949AbYLRPqH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 10:46:07 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBIFjZPv004373
	for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2008 07:45:36 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144





------- Comment #20 from bbpetkov@yahoo.de  2008-12-18 07:45 -------
Hi,

you need to disable the loading of the ata_piix.ko kernel module for the 2.6.27
kernel you're going to test the patch with. If you still don't know what to do,
just reconfigure your kernel by issuing:

make menuconfig

in the kernel sources, then go to "Device Drivers" -> "Serial ATA (prod) and
Parallel ATA (experimental) drivers" and disable the menu point "Intel ESB,
ICH, PIIX3, PIIX4 PATA/SATA support" and then apply the patch, recompile your
kernel, install it and reboot the machine.

Regards,
Boris.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
