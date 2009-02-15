From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12714] New: [pata_ali] ATAPI UltraDMA on secondary channel broken
Date: Sun, 15 Feb 2009 14:01:09 -0800 (PST)
Message-ID: <bug-12714-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38187 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752242AbZBOWBj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 17:01:39 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1FM19iZ013763
	for <linux-ide@vger.kernel.org>; Sun, 15 Feb 2009 14:01:10 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12714

           Summary: [pata_ali] ATAPI UltraDMA on secondary channel broken
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.27
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: jtsn@gmx.de


Latest working kernel version: 2.6.24 (with libata)
Earliest failing kernel version: confirmed 2.6.27 (with libata), possibly
2.6.25
Distribution: Slackware 12.2
Hardware Environment:

00:12.0 IDE interface [0101]: ALi Corporation M5229 IDE [10b9:5229] (rev c7)

See http://bugzilla.kernel.org/show_bug.cgi?id=9904 for more hardware info.

Problem Description:

Linux 2.6.24 (Slackware 12.1) pata_ali driver worked reliable in ATAPI UltraDMA
mode reading and writing media on both channels, beside the cable detection
issue mentioned in bug #9904 (which occured only with this specific ASUS
drive).

The 2.6.27 driver completely disables ATAPI DMA and the atapi_dma=1 modparm
brings it back only on the primary channel.

pata_ali 0000:00:12.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
scsi3 : pata_ali
scsi4 : pata_ali
ata4: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
ata5: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
ata4.00: ATAPI: PIONEER DVD-RW  DVR-212, 1.28, max UDMA/66
ata4.00: configured for UDMA/66
ata5.00: ATAPI: MATSHITADVD-RAM SW-9576S, AY0J, max UDMA/66
ata5.00: simplex DMA is claimed by other device, disabling DMA
ata5.00: configured for PIO4

# hdparm -t /dev/sr1

/dev/sr1:
 Timing buffered disk reads:    6 MB in  3.18 seconds =   1.89 MB/sec

So the secondary channel is completely unusable now with libata.

Also I see no sense in the atapi_dma switch and its default (off), because
ATAPI DMA was fine on 2.6.24. There might be a tunable for buggy hardware, but
this default (which does not work with modern DVD writers at all) is bogus and
should be changed.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
