From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] [RFC] [resend] libata and starting/stopping ATAPI floppy devices
Date: Mon, 7 Jan 2008 21:34:47 +0100
Message-ID: <200801072134.49174.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.gsystems.sk ([62.176.172.50]:46289 "EHLO www.gsystems.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501AbYAGUfP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Jan 2008 15:35:15 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Hello,
I switched to libata drivers for my onboard PATA controller (PIIX4) recently. 
Everything works fine except that kernel tries to start not only my hard 
drive (sda) but also LS-120 floppy drive (sdb) which does not like it:

sd 0:0:0:0: [sda] Starting disk
ata1.00: configured for UDMA/33
sd 0:0:0:0: [sda] 58633344 512-byte hardware sectors (30020 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:1:0: [sdb] Starting disk
ata2.00: configured for UDMA/33
ata2.01: configured for PIO2
sd 1:0:1:0: [sdb] Result: hostbyte=0x00 driverbyte=0x08
sd 1:0:1:0: [sdb] Sense Key : 0x2 [current]
sd 1:0:1:0: [sdb] ASC=0x3a ASCQ=0x0


The question is: is it correct? Or a patch like this should be applied?

--- linux-2.6.23-orig/drivers/ata/libata-scsi.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-2.6.23-pentium/drivers/ata/libata-scsi.c	2008-01-05 15:50:16.000000000 +0100
@@ -802,7 +802,8 @@
 
 	blk_queue_max_phys_segments(sdev->request_queue, LIBATA_MAX_PRD);
 
-	sdev->manage_start_stop = 1;
+	if (dev->class == ATA_DEV_ATA)
+		sdev->manage_start_stop = 1;
 
 	if (dev)
 		ata_scsi_dev_config(sdev, dev);


-- 
Ondrej Zary
