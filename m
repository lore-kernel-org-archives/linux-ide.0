From: "Tomi Orava" <tomimo+linux-ide@ncircle.nullnet.fi>
Subject: Re: 2.4.26rc1 / HPT 374 / RAID = data read corruption with disks
     onprimary channels.
Date: Wed, 31 Mar 2004 10:08:04 +0300 (EEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <63171.194.237.142.24.1080716884.squirrel@ncircle.nullnet.fi>
References: <1080677057.11947.83.camel@sage.kitchen>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040331100804_70066"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ncircle.nullnet.fi ([81.17.200.207]:26314 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S261780AbUCaHIG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Mar 2004 02:08:06 -0500
In-Reply-To: <1080677057.11947.83.camel@sage.kitchen>
List-Id: linux-ide@vger.kernel.org
To: Mark Cooke <mpc@jts.homeip.net>
Cc: linux-ide@vger.kernel.org

------=_20040331100804_70066
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> Hi all,
>
> I've been having some trouble with an Abit IT7 machine.  It is a
> pentium-4 machine, 1GB ram (passes days of all-test memtest86), 80GB
> seagate on the ICH4 as the system disk.  4 x 160GB seagates, one on each
> channel of the HPT374.

It seems that 2.4.26rc1 doesn't still contain the HPT374 patch which
fixes at least some DMA-problems with that ide-chip. Perhaps you'd like
to retest after aplying the patch Andre Hedrick posted on this list a
short while ago ? I'm not saying it will fix your problems, but its worth
trying.

Regards,
Tomi Orava


------=_20040331100804_70066
Content-Type: text/x-patch; name="hpt366.c-2.4.23.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="hpt366.c-2.4.23.patch"

--- linux-2.4.23.orig/drivers/ide/pci/hpt366.c	Mon Aug 25 04:44:41 2003
+++ linux-2.4.23/drivers/ide/pci/hpt366.c	Fri Jan  9 21:44:48 2004
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/ide/pci/hpt366.c		Version 0.36	April 25, 2003
  *
- * Copyright (C) 1999-2002		Andre Hedrick <andre@linux-ide.org>
+ * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
  *
@@ -668,6 +668,35 @@
 	return __ide_dma_lostirq(drive);
 }
 
+/* returns 1 if dma irq issued, 0 otherwise */
+static int hpt374_ide_dma_test_irq (ide_drive_t *drive)
+{
+		        
+	ide_hwif_t *hwif	= HWIF(drive);
+	u16 bfifo		= 0;
+	u8 reginfo		= hwif->channel ? 0x56 : 0x52;
+	u8 dma_stat		= 0;
+
+	pci_read_config_word(hwif->pci_dev, reginfo, &bfifo);
+	if (bfifo & 0x1FF) {
+//		printk("%s: %d bytes in FIFO\n", drive->name, bfifo);
+		return 0;
+	}
+
+	dma_stat = hwif->INB(hwif->dma_status);
+	/* return 1 if INTR asserted */
+	if ((dma_stat & 4) == 4)
+		return 1;
+
+	if (!drive->waiting_for_dma)
+		printk(KERN_WARNING "%s: (%s) called while not waiting\n",
+				drive->name, __FUNCTION__);
+#if 0
+	drive->waiting_for_dma++;
+#endif
+	return 0;
+}
+
 static int hpt374_ide_dma_end (ide_drive_t *drive)
 {
 	struct pci_dev *dev	= HWIF(drive)->pci_dev;
@@ -1245,11 +1274,13 @@
 		hwif->udma_four = ((ata66 & regmask) ? 0 : 1);
 	hwif->ide_dma_check = &hpt366_config_drive_xfer_rate;
 
-	if (hpt_minimum_revision(dev,8))
+	if (hpt_minimum_revision(dev,8)) {
+		hwif->ide_dma_test_irq = &hpt374_ide_dma_test_irq;
 		hwif->ide_dma_end = &hpt374_ide_dma_end;
-	else if (hpt_minimum_revision(dev,5))
+	} else if (hpt_minimum_revision(dev,5)) {
+		hwif->ide_dma_test_irq = &hpt374_ide_dma_test_irq;
 		hwif->ide_dma_end = &hpt374_ide_dma_end;
-	else if (hpt_minimum_revision(dev,3)) {
+	} else if (hpt_minimum_revision(dev,3)) {
 		hwif->ide_dma_begin = &hpt370_ide_dma_begin;
 		hwif->ide_dma_end = &hpt370_ide_dma_end;
 		hwif->ide_dma_timeout = &hpt370_ide_dma_timeout;
------=_20040331100804_70066--

