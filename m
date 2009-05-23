From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13365] 2.6.28+ cannot read a hard-drive properly through an
 "82801DB (ICH4) IDE Controller"
Date: Sat, 23 May 2009 05:00:29 GMT
Message-ID: <200905230500.n4N50TPg028044@demeter.kernel.org>
References: <bug-13365-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:58699 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbZEWFA2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 May 2009 01:00:28 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4N50T55028045
	for <linux-ide@vger.kernel.org>; Sat, 23 May 2009 05:00:29 GMT
In-Reply-To: <bug-13365-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13365


Christopher Hogan <chris.c.hogan@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |chris.c.hogan@gmail.com




--- Comment #6 from Christopher Hogan <chris.c.hogan@gmail.com>  2009-05-23 05:00:28 ---
I'm also having this problem with an Acer desktop system. I ran into the
problem when I updated from kernel-2.6.18-gentoo-r5 to kernel-2.6.29-gentoo-r3.
At the same time, I switched from using the BLK_DEV_PIIX driver to the ATA_PIIX
driver.

Booting the new kernel produced similar errors concerning the file system being
to large for the partition. The system could not boot the root file system.
Booting back into 2.6.18, fsck corrected some corruption and the system booted
normally. Every time I booted into the 2.6.29 kernel, I received the same
errors.

I recompiled the 2.6.29 kernel to use the BLK_DEV_PIIX driver and the errors
went away.

I'd attach the dmesg of the boot with the error. However, the root file system
wouldn't mount. I not sure how I'd capture it. If I get a chance tomorrow, I'll
try booting the system from a Knoppix image and see if it has problems mounting
the hard drive.

lspci output:
00:00.0 Host bridge: Intel Corporation 82845G/GL[Brookdale-G]/GE/PE DRAM
Controller/Host-Hub Interface (rev 03)
00:02.0 VGA compatible controller: Intel Corporation 82845G/GL[Brookdale-G]/GE
Chipset Integrated Graphics Device (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
USB UHCI Controller #3 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI
Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC Interface
Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 02)
01:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)

I also have a Dell GX260 that uses this chipset, but doesn't have this problem.
I'm using ReiserFS from the kernel.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
