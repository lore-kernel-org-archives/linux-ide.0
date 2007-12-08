From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6] hpt366: kill set_dma_mode() method wrapper
Date: Sat, 8 Dec 2007 20:50:41 +0300
Message-ID: <200712082050.41067.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:14798 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751459AbXLHRuY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Dec 2007 12:50:24 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

There's no reason to keep the set_dma_mode() method wrapper for two different
chip families, so get rid of it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the pata-2.6 patchset...

 drivers/ide/pci/hpt366.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.23	Dec 7, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.24	Dec 8, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -725,20 +725,9 @@ static void hpt37x_set_mode(ide_drive_t 
 	pci_write_config_dword(dev, itr_addr, new_itr);
 }
 
-static void hpt3xx_set_mode(ide_drive_t *drive, const u8 speed)
-{
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct hpt_info	*info	= pci_get_drvdata(hwif->pci_dev);
-
-	if (info->chip_type >= HPT370)
-		hpt37x_set_mode(drive, speed);
-	else	/* hpt368: hpt_minimum_revision(dev, 2) */
-		hpt36x_set_mode(drive, speed);
-}
-
 static void hpt3xx_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	hpt3xx_set_mode(drive, XFER_PIO_0 + pio);
+	HWIF(drive)->set_dma_mode(drive, XFER_PIO_0 + pio);
 }
 
 static void hpt3xx_quirkproc(ide_drive_t *drive)
@@ -1310,7 +1299,11 @@ static void __devinit init_hwif_hpt366(i
 	hwif->select_data	= hwif->channel ? 0x54 : 0x50;
 
 	hwif->set_pio_mode	= &hpt3xx_set_pio_mode;
-	hwif->set_dma_mode	= &hpt3xx_set_mode;
+	if (chip_type >= HPT370)
+		hwif->set_dma_mode = &hpt37x_set_mode;
+	else
+		hwif->set_dma_mode = &hpt36x_set_mode;
+
 	hwif->quirkproc		= &hpt3xx_quirkproc;
 	hwif->maskproc		= &hpt3xx_maskproc;
 	hwif->busproc		= &hpt3xx_busproc;

