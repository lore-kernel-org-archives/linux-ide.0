From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/15] sgiioc4: fix sgiioc4_ide_dma_check() to enable/disable DMA properly
Date: Fri, 19 Jan 2007 01:32:00 +0100
Message-ID: <20070119003200.14846.55029.sendpatchset@localhost.localdomain>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:62361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932807AbXASA2B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Jan 2007 19:28:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so322530uga
        for <linux-ide@vger.kernel.org>; Thu, 18 Jan 2007 16:28:00 -0800 (PST)
In-Reply-To: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

[PATCH] sgiioc4: fix sgiioc4_ide_dma_check() to enable/disable DMA properly

* use sgiioc4_ide_dma_{on,off_quietly}() instead of changing
  drive->using_dma directly
* fix warning message
* add FIXME

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/pci/sgiioc4.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -275,21 +275,6 @@ sgiioc4_ide_dma_end(ide_drive_t * drive)
 }
 
 static int
-sgiioc4_ide_dma_check(ide_drive_t * drive)
-{
-	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) != 0) {
-		printk(KERN_INFO
-		       "Couldnot set %s in Multimode-2 DMA mode | "
-			   "Drive %s using PIO instead\n",
-		       drive->name, drive->name);
-		drive->using_dma = 0;
-	} else
-		drive->using_dma = 1;
-
-	return 0;
-}
-
-static int
 sgiioc4_ide_dma_on(ide_drive_t * drive)
 {
 	drive->using_dma = 1;
@@ -305,6 +290,17 @@ sgiioc4_ide_dma_off_quietly(ide_drive_t 
 	return HWIF(drive)->ide_dma_host_off(drive);
 }
 
+static int sgiioc4_ide_dma_check(ide_drive_t *drive)
+{
+	/* FIXME: check for available DMA modes */
+	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) != 0) {
+		printk(KERN_WARNING "%s: couldn't set MWDMA2 mode, "
+				    "using PIO instead\n", drive->name);
+		return sgiioc4_ide_dma_off_quietly(drive);
+	} else
+		return sgiioc4_ide_dma_on(drive);
+}
+
 /* returns 1 if dma irq issued, 0 otherwise */
 static int
 sgiioc4_ide_dma_test_irq(ide_drive_t * drive)
