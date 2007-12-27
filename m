From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] ide: add IDE_HFLAG_NO_DSC host flag
Date: Thu, 27 Dec 2007 18:38:00 +0100
Message-ID: <200712271838.00351.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:1606 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbXL0R20 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Dec 2007 12:28:26 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1677043ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 27 Dec 2007 09:28:25 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


* Add IDE_HFLAG_NO_DSC host flag for hosts that doesn't support DSC overlap.

* Set it in aec62xx (for ATP850UF only) and hpt34x host drivers.

* Convert ide-tape device driver to check for IDE_HFLAG_NO_DSC flag.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c    |   16 ++++------------
 drivers/ide/pci/aec62xx.c |    1 +
 drivers/ide/pci/hpt34x.c  |    1 +
 include/linux/ide.h       |    2 ++
 4 files changed, 8 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4532,19 +4532,11 @@ static void idetape_setup (ide_drive_t *
 
 	spin_lock_init(&tape->spinlock);
 	drive->dsc_overlap = 1;
-#ifdef CONFIG_BLK_DEV_IDEPCI
-	if (HWIF(drive)->pci_dev != NULL) {
-		/*
-		 * These two ide-pci host adapters appear to need DSC overlap disabled.
-		 * This probably needs further analysis.
-		 */
-		if ((HWIF(drive)->pci_dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) ||
-		    (HWIF(drive)->pci_dev->device == PCI_DEVICE_ID_TTI_HPT343)) {
-			printk(KERN_INFO "ide-tape: %s: disabling DSC overlap\n", tape->name);
-		    	drive->dsc_overlap = 0;
-		}
+	if (drive->hwif->host_flags & IDE_HFLAG_NO_DSC) {
+		printk(KERN_INFO "ide-tape: %s: disabling DSC overlap\n",
+				 tape->name);
+		drive->dsc_overlap = 0;
 	}
-#endif /* CONFIG_BLK_DEV_IDEPCI */
 	/* Seagate Travan drives do not support DSC overlap. */
 	if (strstr(drive->id->model, "Seagate STT3401"))
 		drive->dsc_overlap = 0;
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -202,6 +202,7 @@ static const struct ide_port_info aec62x
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.host_flags	= IDE_HFLAG_SERIALIZE |
 				  IDE_HFLAG_NO_ATAPI_DMA |
+				  IDE_HFLAG_NO_DSC |
 				  IDE_HFLAG_ABUSE_SET_DMA_MODE |
 				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -131,6 +131,7 @@ static void __devinit init_hwif_hpt34x(i
 
 #define IDE_HFLAGS_HPT34X \
 	(IDE_HFLAG_NO_ATAPI_DMA | \
+	 IDE_HFLAG_NO_DSC | \
 	 IDE_HFLAG_ABUSE_SET_DMA_MODE | \
 	 IDE_HFLAG_NO_AUTODMA)
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1098,6 +1098,8 @@ enum {
 	IDE_HFLAG_CY82C693		= (1 << 27),
 	/* force host out of "simplex" mode */
 	IDE_HFLAG_CLEAR_SIMPLEX		= (1 << 28),
+	/* DSC overlap is unsupported */
+	IDE_HFLAG_NO_DSC		= (1 << 29),
 };
 
 #ifdef CONFIG_BLK_DEV_OFFBOARD
