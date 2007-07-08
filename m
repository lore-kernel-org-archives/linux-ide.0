From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/12] sis5513: add ->udma_filter method for chipset_family >= ATA_133
Date: Sun, 8 Jul 2007 15:38:32 +0200
Message-ID: <200707081538.32621.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:45141 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbXGHOAO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 10:00:14 -0400
Received: by nf-out-0910.google.com with SMTP id g13so50892nfb
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 07:00:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add sis5513_ata133_udma_filter() for chipset_family >= ATA_133,
  use it to filter UDMA6 mode if ATA133 bit is disabled.

* Remove no longer needed UDMA6 limiting logic from sis5513_tune_chipset().

* Bump driver version.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sis5513.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/sis5513.c	Version 0.25	Jun 10, 2007
+ * linux/drivers/ide/pci/sis5513.c	Version 0.26	Jul 7, 2007
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
@@ -582,9 +582,6 @@ static int sis5513_tune_chipset (ide_dri
 					regdw |= (unsigned long)cycle_time_value[ATA_133][speed-XFER_UDMA_0] << 4;
 					regdw |= (unsigned long)cvs_time_value[ATA_133][speed-XFER_UDMA_0] << 8;
 				} else {
-				/* if ATA133 disable, we should not set speed above UDMA5 */
-					if (speed > XFER_UDMA_5)
-						speed = XFER_UDMA_5;
 					regdw |= (unsigned long)cycle_time_value[ATA_100][speed-XFER_UDMA_0] << 4;
 					regdw |= (unsigned long)cvs_time_value[ATA_100][speed-XFER_UDMA_0] << 8;
 				}
@@ -640,6 +637,20 @@ static int sis5513_config_xfer_rate(ide_
 	return -1;
 }
 
+static u8 sis5513_ata133_udma_filter(ide_drive_t *drive)
+{
+	struct pci_dev *dev = drive->hwif->pci_dev;
+	int drive_pci;
+	u32 reg54 = 0, regdw = 0;
+
+	pci_read_config_dword(dev, 0x54, &reg54);
+	drive_pci = ((reg54 & 0x40000000) ? 0x70 : 0x40) + drive->dn * 4;
+	pci_read_config_dword(dev, drive_pci, &regdw);
+
+	/* if ATA133 disable, we should not set speed above UDMA5 */
+	return (regdw & 0x08) ? ATA_UDMA6 : ATA_UDMA5;
+}
+
 /* Chip detection and general config */
 static unsigned int __devinit init_chipset_sis5513 (struct pci_dev *dev, const char *name)
 {
@@ -850,6 +861,9 @@ static void __devinit init_hwif_sis5513 
 	hwif->tuneproc = &sis5513_tuneproc;
 	hwif->speedproc = &sis5513_tune_chipset;
 
+	if (chipset_family >= ATA_133)
+		hwif->udma_filter = sis5513_ata133_udma_filter;
+
 	if (!(hwif->dma_base)) {
 		hwif->drives[0].autotune = 1;
 		hwif->drives[1].autotune = 1;
