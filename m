From: "Darrick Burch" <darrick@tuffmail.com>
Subject: SB600 in AHCI mode will not run SATA optical drive
Date: Sun, 4 Jan 2009 18:33:06 -0500 (EST)
Message-ID: <21155.72.218.132.189.1231111986.squirrel@webmail.tuffmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fallback-out1.mxes.net ([216.86.168.190]:2403 "EHLO
	fallback-in1.mxes.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751496AbZADXvy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Jan 2009 18:51:54 -0500
Received: from mxout-03.mxes.net (mxout-03.mxes.net [216.86.168.178])
	by fallback-in1.mxes.net (Postfix) with ESMTP id 88955164687
	for <linux-ide@vger.kernel.org>; Sun,  4 Jan 2009 18:35:25 -0500 (EST)
Received: from wm1.irbs.net (wm1.irbs.net [216.86.168.168])
	by smtp.mxes.net (Postfix) with ESMTP id B39DC23E3F7
	for <linux-ide@vger.kernel.org>; Sun,  4 Jan 2009 18:33:06 -0500 (EST)
Received: from webmail.tuffmail.net (wm1.irbs.net [216.86.168.168])
	by wm1.irbs.net (Postfix) with ESMTPA id 8D0231156B9
	for <linux-ide@vger.kernel.org>; Sun,  4 Jan 2009 18:33:06 -0500 (EST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hey, all:

I'm having a bit of an issue with running my Pioneer BDC-202BK BD-ROM
drive on my motherboard's (MSI K9A2-CF) AMD SB600-based SATA controller
and I was wondering if anyone has seen anything similar.

The problem is that the drive does not initialize at all under Linux.  I
get errors from the ahci driver which, from what I've read from the wiki,
is the only driver under which the SATA ports on the SB600 are supported.

The errors I'm getting loop infinitely until I remove the drive data cable:

Nov  9 21:51:51 linux kernel: ata3: soft resetting link
Nov  9 21:51:51 linux kernel: ata3: SATA link down (SStatus 1 SControl 300)
Nov  9 21:51:51 linux kernel: ata3: EH complete
Nov  9 21:51:51 linux kernel: ata3: exception Emask 0x10 SAct 0x0 SErr
0x40c0000 action 0xa frozen
Nov  9 21:51:51 linux kernel: ata3: irq_stat 0x00000040, connection status
changed
Nov  9 21:51:51 linux kernel: ata3: SError: { CommWake 10B8B DevExch }
Nov  9 21:51:51 linux kernel: ata3: soft resetting link
Nov  9 21:51:51 linux kernel: ata3: SATA link down (SStatus 1 SControl 300)
Nov  9 21:51:51 linux kernel: ata3: EH complete
Nov  9 21:51:51 linux kernel: ata3: exception Emask 0x10 SAct 0x0 SErr
0x40c0000 action 0xa frozen
Nov  9 21:51:51 linux kernel: ata3: irq_stat 0x00000040, connection status
changed
Nov  9 21:51:51 linux kernel: ata3: SError: { CommWake 10B8B DevExch }

I've been able to get around this problem (which prevents me from booting
completely) by commenting the PCI_VDEVICE definition for the SB600.  Of
course, this means that the controller is effectively disabled.  I'm not
in desperate need for my optical drive in Linux at the moment, but it
would be nice to have access to it someday.

I suppose my questions are the following:

1. Is it possible that the drive simply does not want to run under AHCI
mode?  I should note that the drive works correctly under Windows XP with
the controller set to IDE emulation mode.

2. I'm thinking that the best thing for me to do is to get another PCIe
SATA controller and dedicate it to this one drive.  Does anyone want to
give their opinion on this?

Thanks in advance,
-Darrick

PS - I have no other devices on the SATA controller; my two hard drives
are PATA and they're connected to the single PATA header available on the
motherboard.  These, of course, are working fine.

