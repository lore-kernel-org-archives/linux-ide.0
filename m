From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] hpt366: UltraDMA filtering for SATA cards
Date: Mon, 6 Aug 2007 00:08:38 +0400
Message-ID: <200708060008.38077.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:35548 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757136AbXHEUGf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Aug 2007 16:06:35 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, rah@bash.sh
Cc: linux-ide@vger.kernel.org

The Marvell bridge chips used on HighPoint SATA cards do not seem to support
the UltraDMA modes 1, 2, and 3 (as well as any MWDMA modes), so the driver
needs to account for this in the udma_filter() method.  In order to achieve
that, do the following changes:

- install the method for all chips, not only HPT36x/370 (improve code formatting
  by killing an extra tabs while at it);

- add to the end of the 'switch' statement in hpt3xx_udma_filter() case for
  HPT372[AN] and HPT374 chips upon which the SATA cards are based and check
  there whether we're dealing with SATA drive (by looking at words 80 and 93
  of the drive's identify data), reorder HPT370[A] cases for consistency...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This is against the current Linus tree and unfortunately I was able to only
compile test it since that tree gives MODPOST warning and dies early.
Bob, please test it if/when you'll be able to and report the results...

 drivers/ide/pci/hpt366.c |   75 ++++++++++++++++++++++++++---------------------
 1 files changed, 43 insertions(+), 32 deletions(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.11	Aug 4, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.12	Aug 5, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -517,29 +517,17 @@ static int check_in_drive_list(ide_drive
 }
 
 /*
- *	Note for the future; the SATA hpt37x we must set
- *	either PIO or UDMA modes 0,4,5
+ * The Marvell bridge chips used on the HighPoint SATA cards do not seem
+ * to support the UltraDMA modes 1, 2, and 3 -- as well as any MWDMA modes
+ * (that we should start filtering out once the IDE core allows that).
  */
-
 static u8 hpt3xx_udma_filter(ide_drive_t *drive)
 {
 	struct hpt_info *info	= pci_get_drvdata(HWIF(drive)->pci_dev);
+	struct hd_driveid *id	= drive->id;
 	u8 mask;
 
 	switch (info->chip_type) {
-	case HPT370A:
-		if (!HPT370_ALLOW_ATA100_5 ||
-		    check_in_drive_list(drive, bad_ata100_5))
-			return 0x1f;
-		else
-			return 0x3f;
-	case HPT370:
-		if (!HPT370_ALLOW_ATA100_5 ||
-		    check_in_drive_list(drive, bad_ata100_5))
-			mask = 0x1f;
-		else
-			mask = 0x3f;
-		break;
 	case HPT36x:
 		if (!HPT366_ALLOW_ATA66_4 ||
 		    check_in_drive_list(drive, bad_ata66_4))
@@ -551,6 +539,30 @@ static u8 hpt3xx_udma_filter(ide_drive_t
 		    check_in_drive_list(drive, bad_ata66_3))
 			mask = 0x07;
 		break;
+	case HPT370:
+		if (!HPT370_ALLOW_ATA100_5 ||
+		    check_in_drive_list(drive, bad_ata100_5))
+			mask = 0x1f;
+		else
+			mask = 0x3f;
+		break;
+	case HPT370A:
+		if (!HPT370_ALLOW_ATA100_5 ||
+		    check_in_drive_list(drive, bad_ata100_5))
+			return 0x1f;
+		else
+			return 0x3f;
+	case HPT372 :
+	case HPT372A:
+	case HPT372N:
+	case HPT374 :
+		/*
+		 * Check for SATA drive by verifying that the word 93 is 0 and
+		 * the drive is ATA-5 or higher compatible.
+		 */
+		if (id->hw_config == 0 && (id->major_rev_num & 0x7fe0))
+			return 0x71;
+		/* fall thru */
 	default:
 		return 0x7f;
 	}
@@ -1229,25 +1241,24 @@ static unsigned int __devinit init_chips
 
 static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 {
-	struct pci_dev	*dev		= hwif->pci_dev;
-	struct hpt_info *info		= pci_get_drvdata(dev);
-	int serialize			= HPT_SERIALIZE_IO;
-	u8  scr1 = 0, ata66		= hwif->channel ? 0x01 : 0x02;
-	u8  chip_type			= info->chip_type;
-	u8  new_mcr, old_mcr 		= 0;
+	struct pci_dev	*dev	= hwif->pci_dev;
+	struct hpt_info *info	= pci_get_drvdata(dev);
+	int serialize		= HPT_SERIALIZE_IO;
+	u8  scr1 = 0, ata66	= hwif->channel ? 0x01 : 0x02;
+	u8  chip_type		= info->chip_type;
+	u8  new_mcr, old_mcr	= 0;
 
 	/* Cache the channel's MISC. control registers' offset */
-	hwif->select_data		= hwif->channel ? 0x54 : 0x50;
+	hwif->select_data	= hwif->channel ? 0x54 : 0x50;
 
-	hwif->tuneproc			= &hpt3xx_tune_drive;
-	hwif->speedproc			= &hpt3xx_tune_chipset;
-	hwif->quirkproc			= &hpt3xx_quirkproc;
-	hwif->intrproc			= &hpt3xx_intrproc;
-	hwif->maskproc			= &hpt3xx_maskproc;
-	hwif->busproc			= &hpt3xx_busproc;
+	hwif->tuneproc		= &hpt3xx_tune_drive;
+	hwif->speedproc		= &hpt3xx_tune_chipset;
+	hwif->quirkproc		= &hpt3xx_quirkproc;
+	hwif->intrproc		= &hpt3xx_intrproc;
+	hwif->maskproc		= &hpt3xx_maskproc;
+	hwif->busproc		= &hpt3xx_busproc;
 
-	if (chip_type <= HPT370A)
-		hwif->udma_filter	= &hpt3xx_udma_filter;
+	hwif->udma_filter	= &hpt3xx_udma_filter;
 
 	/*
 	 * HPT3xxN chips have some complications:

