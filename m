From: Mikael Pettersson <mikpe@it.uu.se>
Subject: pata_pdc2027x success on a PowerMac
Date: Sat, 10 Mar 2007 19:34:56 +0100 (MET)
Message-ID: <200703101834.l2AIYuVv012702@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:34107 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbXCJSfB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Mar 2007 13:35:01 -0500
Received: from harpo.it.uu.se (daemon@harpo.it.uu.se [130.238.12.34])
	by aun.it.uu.se (8.13.6/8.13.6) with ESMTP id l2AIYvt7002101
	for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 19:34:57 +0100 (MET)
Received: (from mikpe@localhost)
	by harpo.it.uu.se (8.13.8+Sun/8.13.7) id l2AIYuVv012702
	for linux-ide@vger.kernel.org; Sat, 10 Mar 2007 19:34:56 +0100 (MET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is just to let folks know that the 2.6.21-rc3 kernel's
pata_pdc2027x works w/o issues with a PDC20269 in an old
PowerMac G3 of mine:

pata_pdc2027x 0000:00:0e.0: version 0.8
pata_pdc2027x 0000:00:0e.0: PLL input clock 16000 kHz
ata1: PATA max UDMA/133 cmd 0xf10197c0 ctl 0xf1019fda bmdma 0xf1019000 irq 24
ata2: PATA max UDMA/133 cmd 0xf10195c0 ctl 0xf1019dda bmdma 0xf1019008 irq 24
scsi1 : pata_pdc2027x
ata1.00: ATA-5: IBM-DTLA-307030, TX4OA6AA, max UDMA/100
ata1.00: 60036480 sectors, multi 0: LBA 
ata1.00: configured for UDMA/100
scsi2 : pata_pdc2027x
ATA: abnormal status 0x8 on port 0xf10195df
scsi 1:0:0:0: Direct-Access     ATA      IBM-DTLA-307030  TX4O PQ: 0 ANSI: 5
SCSI device sdb: 60036480 512-byte hdwr sectors (30739 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 60036480 512-byte hdwr sectors (30739 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
sd 1:0:0:0: Attached scsi disk sdb

In particular, this confirms that Albert Lee's timing/tuning fixes,
which were essential for making the IDE pdc202xx_new driver work on
this machine, also work in pata_pdc2027x.

/Mikael
