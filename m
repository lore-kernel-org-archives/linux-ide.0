From: Ben Gardner <gardner.ben@gmail.com>
Subject: Delkin Devices CFA not recognized
Date: Tue, 23 Feb 2010 11:03:32 -0600
Message-ID: <808c8e9d1002230903pea21f5al2c09e2420af141c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63679 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab0BWRDd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Feb 2010 12:03:33 -0500
Received: by wya21 with SMTP id 21so702849wya.19
        for <linux-ide@vger.kernel.org>; Tue, 23 Feb 2010 09:03:32 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I have a Delkin Devices compact flash card that isn't being recognized using the
SATA/PATA drivers.
The card is recognized and works with the deprecated ATA drivers.

I'm using Linux 2.6.33-rc8, but it looks like the same code dates back to at
least 2.6.20.
My guess is that this CF card never worked with the SATA/PATA drivers.

The error I am seeing is:
ata1.00: failed to IDENTIFY (device reports invalid type, err_mask=0x0)

That is followed by the expected failure to mount the root FS and a panic.

I tracked the problem down to ata_id_is_cfa() in include/linux/ata.h.
The Delkin card doesn't match either assumption in that function.
On the Delkin card, id[0] is 0x844a and id[83] is 0.

Here's the complete ID block:
844a 03e1 0000 0010 0000 0200 003f 000f 45f0 0000 4444 4930 3030 3033 3930 3920
3030 3030 3030 3031 0001 0001 0004 3330 2f30 362f 3033 4465 6c6b 696e 2044 6576
6963 6573 2043 4658 3531 3245 3447 312d 4441 4245 4730 3020 2020 2020 2020 0001
0000 0f00 0000 0200 0000 0003 03e1 0010 003f 45f0 000f 0100 45f0 000f 0000 0407
0003 0078 0078 0078 0078 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000 3036 3037 3239 6238 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000

The simple fix for me is to change the id[0] check ata_id_is_cfa() in to
include 0x844a.

--- linux-2.6.33-rc8.orig/include/linux/ata.h
+++ linux-2.6.33-rc8/include/linux/ata.h
@@ -841,7 +841,8 @@

 static inline int ata_id_is_cfa(const u16 *id)
 {
-	if (id[ATA_ID_CONFIG] == 0x848A)	/* Traditional CF */
+	if ((id[ATA_ID_CONFIG] == 0x848A) ||	/* Traditional CF */
+	    (id[ATA_ID_CONFIG] == 0x844A))	/* Delkin Devices CF */
 		return 1;
 	/*
 	 * CF specs don't require specific value in the word 0 anymore and yet
---

While that works, it doesn't seem like a very good solution.
Here are some of the ATA-related logs after the change:
---
scsi0 : pata_cs5536
scsi1 : pata_cs5536
ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xeff0 irq 14
ata2: DUMMY
ata1.00: CFA: Delkin Devices CFX512E4G1-DABEG00, 30/06/03, max MWDMA2
ata1.00: 1000944 sectors, multi 0: LBA
ata1.00: configured for MWDMA2
ata1.00: configured for MWDMA2
ata1: EH complete
scsi 0:0:0:0: Direct-Access     ATA      Delkin Devices C 30/0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 1000944 512-byte logical blocks: (512 MB/488 MiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
EXT3-fs (sda1): mounted filesystem with ordered data mode
VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
---

Is my little hack OK, or is there a better way to fix this?

Thanks,
Ben
