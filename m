From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [BUG] 2.6.29-rc1: ata_piix boot hang due to bmdma32 change
Date: Thu, 15 Jan 2009 09:42:51 +0100 (MET)
Message-ID: <200901150842.n0F8gpZb014365@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:50212 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757139AbZAOInD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jan 2009 03:43:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk
Cc: linux-ide@vger.kernel.org

One of my machines is an Intel 815EP chipset box with
an 82801BA IDE controller (8086:244b rev 05) and two
ATAPI devices on the second channel (the boot disk is
connected to a PDC20269).

With 2.6.29-rc1 this machine hangs hard during boot, when
init starts udev. There are no messages on the console and
not even sysrq gets any reaction.

Reverting the 2.6.29-rc1 change which made ata_piix inherit
the bmdma32 port ops makes the machine boot ok again. (Patch below.)
I'm guessing the 32-bit I/O stuff doesn't work on this controller
or these ATAPI devices.

Partial dmesg from 2.6.29-rc1 with the bmdma32 change reverted:

ata_piix 0000:00:1f.1: version 2.12
ata_piix 0000:00:1f.1: setting latency timer to 64
scsi0 : ata_piix
scsi1 : ata_piix
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf000 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf008 irq 15
ata2.00: ATAPI: CRD-8320B, 1.12, max MWDMA2
ata2.01: ATAPI: Hewlett-Packard CD-Writer Plus 9100, 1.0c, max UDMA/33
ata2.00: configured for MWDMA2
ata2.01: configured for UDMA/33
scsi 1:0:0:0: CD-ROM            GoldStar CD-ROM CRD-8320B 1.12 PQ: 0 ANSI: 5
scsi 1:0:1:0: CD-ROM            HP       CD-Writer+ 9100  1.0c PQ: 0 ANSI: 5

/Mikael

--- linux-2.6.29-rc1/drivers/ata/ata_piix.c.~1~	2009-01-13 23:35:23.000000000 +0100
+++ linux-2.6.29-rc1/drivers/ata/ata_piix.c	2009-01-14 22:57:37.000000000 +0100
@@ -310,7 +310,7 @@ static struct scsi_host_template piix_sh
 };
 
 static struct ata_port_operations piix_pata_ops = {
-	.inherits		= &ata_bmdma32_port_ops,
+	.inherits		= &ata_bmdma_port_ops,
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= piix_set_piomode,
 	.set_dmamode		= piix_set_dmamode,
