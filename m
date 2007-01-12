From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 17/19] ide: unexport ide_set_xfer_rate()
Date: Fri, 12 Jan 2007 05:27:53 +0100
Message-ID: <20070112042753.28794.89093.sendpatchset@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:34837 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030494AbXALEYS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2007 23:24:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so689928uga
        for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2007 20:24:17 -0800 (PST)
In-Reply-To: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

[PATCH] ide: unexport ide_set_xfer_rate()

In cmd64x and siimage drivers:
* don't set drive->init_speed as it should be already
  set by successful execution of ide_set_xfer_rate()
* use hwif->speedproc functions directly

Above changes allows removal of EXPORT_SYMBOL_GPL(ide_set_xfer_rate).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
 drivers/ide/ide-lib.c     |    2 --
 drivers/ide/pci/cmd64x.c  |    7 ++-----
 drivers/ide/pci/siimage.c |    5 +----
 3 files changed, 3 insertions(+), 11 deletions(-)

Index: a/drivers/ide/ide-lib.c
===================================================================
--- a.orig/drivers/ide/ide-lib.c
+++ a/drivers/ide/ide-lib.c
@@ -459,8 +459,6 @@ int ide_set_xfer_rate(ide_drive_t *drive
 		return -1;
 }
 
-EXPORT_SYMBOL_GPL(ide_set_xfer_rate);
-
 static void ide_dump_opcode(ide_drive_t *drive)
 {
 	struct request *rq;
Index: a/drivers/ide/pci/cmd64x.c
===================================================================
--- a.orig/drivers/ide/pci/cmd64x.c
+++ a/drivers/ide/pci/cmd64x.c
@@ -466,11 +466,8 @@ static int config_chipset_for_dma (ide_d
 	if (!speed)
 		return 0;
 
-	if(ide_set_xfer_rate(drive, speed))
-		return 0; 
-
-	if (!drive->init_speed)
-		drive->init_speed = speed;
+	if (cmd64x_tune_chipset(drive, speed))
+		return 0;
 
 	return ide_dma_enable(drive);
 }
Index: a/drivers/ide/pci/siimage.c
===================================================================
--- a.orig/drivers/ide/pci/siimage.c
+++ a/drivers/ide/pci/siimage.c
@@ -397,12 +397,9 @@ static int config_chipset_for_dma (ide_d
 	if (!speed)
 		return 0;
 
-	if (ide_set_xfer_rate(drive, speed))
+	if (siimage_tune_chipset(drive, speed))
 		return 0;
 
-	if (!drive->init_speed)
-		drive->init_speed = speed;
-
 	return ide_dma_enable(drive);
 }
 
