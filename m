From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13308] New: ide-tape boot kernel panic
Date: Thu, 14 May 2009 12:37:54 GMT
Message-ID: <bug-13308-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:47761 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbZENMhx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 May 2009 08:37:53 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4ECbsm3023794
	for <linux-ide@vger.kernel.org>; Thu, 14 May 2009 12:37:54 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13308

           Summary: ide-tape boot kernel panic
           Product: IO/Storage
           Version: 2.5
    Kernel Version: 2.6.29.3
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: odi@odi.ch
        Regression: No


I'm on an Intel ICH5 with dual Pentium 4

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller
(rev 02)

Trying to get an old ATAPI Travan tape to work. I was trying the old piix with
ide-tape, but that ends in a kernel panic on boot (see attached screen photos).
Sorry, I can't scrollback after the panic, and I'm already using the smallest
font, so no idea what the rest of the kernel output is.

partial transscript:
Call Trace:
[<c0401b79>] ? ide_wait_stat+0x39/0x80
...
EIP: [<c040ccd3>] idetape_do_request+0x187/0x3c1

2.6.30-rc5 still crashes, but the stack trace is much longer and off screen...



I have also tried ata_piix, but that fails to scan the device:

May 11 17:57:24 xxx ata_piix 0000:00:1f.1: version 2.12
May 11 17:57:24 xxx ata_piix 0000:00:1f.1: enabling device (0005 -> 0007)
May 11 17:57:24 xxx ata_piix 0000:00:1f.1: PCI INT A -> GSI 18 (level, low)
 -> IRQ 18
May 11 17:57:24 xxx ata_piix 0000:00:1f.1: setting latency timer to 64
May 11 17:57:24 xxx scsi0 : ata_piix
May 11 17:57:24 xxx scsi1 : ata_piix
May 11 17:57:24 xxx ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc0
0 irq 14
May 11 17:57:24 xxx ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xfc0
8 irq 15
May 11 17:57:24 xxx ata1: link is slow to respond, please be patient (ready
=0)
May 11 17:57:24 xxx ata1: SRST failed (errno=-16)
May 11 17:57:24 xxx ata1: link is slow to respond, please be patient (ready
=0)
May 11 17:57:24 xxx ata1: SRST failed (errno=-16)
May 11 17:57:24 xxx ata1: link is slow to respond, please be patient (ready
=0)
May 11 17:57:24 xxx ata1: SRST failed (errno=-16)
May 11 17:57:24 xxx ata1: SRST failed (errno=-16)
May 11 17:57:24 xxx ata1: reset failed, giving up

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
