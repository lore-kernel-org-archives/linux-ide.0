From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] hpt366: use ATA_DMA_* constants
Date: Thu, 9 Apr 2009 16:38:50 +0400
Message-ID: <200904091638.50949.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:15789 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932739AbZDIMiJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Apr 2009 08:38:09 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Use ATA_DMA_* constants instead of the bare numbers for the BMIDE register bits.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is atop the recent pata-2.6 series...

 drivers/ide/hpt366.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/ide/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/hpt366.c
+++ linux-2.6/drivers/ide/hpt366.c
@@ -3,7 +3,7 @@
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
  * Portions Copyright (C) 2007		Bartlomiej Zolnierkiewicz
- * Portions Copyright (C) 2005-2008	MontaVista Software, Inc.
+ * Portions Copyright (C) 2005-2009	MontaVista Software, Inc.
  *
  * Thanks to HighPoint Technologies for their assistance, and hardware.
  * Special Thanks to Jon Burchmore in SanDiego for the deep pockets, his
@@ -810,7 +810,7 @@ static void hpt370_irq_timeout(ide_drive
 	/* get DMA command mode */
 	dma_cmd = inb(hwif->dma_base + ATA_DMA_CMD);
 	/* stop DMA */
-	outb(dma_cmd & ~0x1, hwif->dma_base + ATA_DMA_CMD);
+	outb(dma_cmd & ~ATA_DMA_START, hwif->dma_base + ATA_DMA_CMD);
 	hpt370_clear_engine(drive);
 }
 
@@ -827,11 +827,11 @@ static int hpt370_dma_end(ide_drive_t *d
 	ide_hwif_t *hwif	= drive->hwif;
 	u8  dma_stat		= inb(hwif->dma_base + ATA_DMA_STATUS);
 
-	if (dma_stat & 0x01) {
+	if (dma_stat & ATA_DMA_ACTIVE) {
 		/* wait a little */
 		udelay(20);
 		dma_stat = inb(hwif->dma_base + ATA_DMA_STATUS);
-		if (dma_stat & 0x01)
+		if (dma_stat & ATA_DMA_ACTIVE)
 			hpt370_irq_timeout(drive);
 	}
 	return ide_dma_end(drive);
@@ -853,7 +853,7 @@ static int hpt374_dma_test_irq(ide_drive
 
 	dma_stat = inb(hwif->dma_base + ATA_DMA_STATUS);
 	/* return 1 if INTR asserted */
-	if (dma_stat & 4)
+	if (dma_stat & ATA_DMA_INTR)
 		return 1;
 
 	return 0;

