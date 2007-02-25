From: "Graham W. Mitchell" <gmitch@woodlea.com>
Subject: Re: [PATCH]: via 6421 PATA support done in a rather cleaner fashion
Date: Sat, 24 Feb 2007 22:22:58 -0500
Message-ID: <3A1214D41EC70C469B7A95E05149B3EECBA3@aximx50vsync.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:38029 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933644AbXBYD25 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Feb 2007 22:28:57 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've just installed this patch to a 2.6.19 kernel (running FC6).

Wants testing... so test and report

Signed-off-by: Alan Cox <alan@xxxxxxxxxx>

--- linux.vanilla-2.6.19-rc6-mm1/drivers/ata/sata_via.c	2006-11-24
13:58:05.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/ata/sata_via.c	2006-12-04
14:57:34.719099648 +0000

I have a Maxtor 320GB PATA drive connected to the PATA port of a via
6421 based card. I can see a SATA drive if I connect it to the SATA
ports, but I can't see the PATA one using the unpatched driver.

Once I patch the driver and rebuild, I can still see the SATA drives if
connected, but there is still no PATA drive showing. Inserting the
module gives the following messages.

Feb 24 21:57:11 file02bert kernel: ACPI: PCI Interrupt 0000:02:0e.0[A]
-> GSI 16 (level, low) -> IRQ 18
Feb 24 21:57:11 file02bert kernel: sata_via 0000:02:0e.0: routed to hard
irq line 10
Feb 24 21:57:11 file02bert kernel: ata10: SATA max UDMA/133 cmd 0xAC00
ctl 0xAC0A bmdma 0xBC00 irq 18
Feb 24 21:57:11 file02bert kernel: ata11: SATA max UDMA/133 cmd 0xB000
ctl 0xB00A bmdma 0xBC08 irq 18
Feb 24 21:57:11 file02bert kernel: ata12: SATA max UDMA/133 cmd 0xB400
ctl 0xB40A bmdma 0xBC10 irq 18
Feb 24 21:57:11 file02bert kernel: scsi10 : sata_via
Feb 24 21:57:11 file02bert kernel: ata10: SATA link down (SStatus 0
SControl 310)
Feb 24 21:57:11 file02bert kernel: ATA: abnormal status 0x7F on port
0xAC07
Feb 24 21:57:11 file02bert kernel: scsi11 : sata_via
Feb 24 21:57:11 file02bert kernel: ata11: SATA link down (SStatus 0
SControl 310)
Feb 24 21:57:11 file02bert kernel: ATA: abnormal status 0x7F on port
0xB007
Feb 24 21:57:11 file02bert kernel: scsi12 : sata_via
Feb 24 21:57:11 file02bert kernel: ATA: abnormal status 0x7F on port
0xB407

Is there a more up to date patch than the one Alan posted in Dec? (Date:
Mon, 4 Dec 2006 15:21:05 +0000). I've looked thru the archives, and
can't find anything in there, and the only other patch that I can find
is the VIA supplied one, which of course doesn't compile.

Thanks


Graham

