From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 3/4] ide-dma-sff: factor out ide_dma_sff_write_status()
Date: Wed, 31 Dec 2008 22:58:58 +0400
Message-ID: <200812312158.58635.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:12314 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756130AbYLaS6d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Dec 2008 13:58:33 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Factor out ide_dma_sff_write_status(), symmetric to ide_dma_sff_read_status().

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of the current pata-2.6 series...

 drivers/ide/ide-dma-sff.c |   37 ++++++++++++++++---------------------
 1 files changed, 16 insertions(+), 21 deletions(-)

Index: linux-2.6/drivers/ide/ide-dma-sff.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma-sff.c
+++ linux-2.6/drivers/ide/ide-dma-sff.c
@@ -61,6 +61,16 @@ u8 ide_dma_sff_read_status(ide_hwif_t *h
 }
 EXPORT_SYMBOL_GPL(ide_dma_sff_read_status);
 
+static void ide_dma_sff_write_status(ide_hwif_t *hwif, u8 val)
+{
+	unsigned long addr = hwif->dma_base + ATA_DMA_STATUS;
+
+	if (hwif->host_flags & IDE_HFLAG_MMIO)
+		writeb(val, (void __iomem *)addr);
+	else
+		outb(val, addr);
+}
+
 /**
  *	ide_dma_host_set	-	Enable/disable DMA on a host
  *	@drive: drive to control
@@ -80,11 +90,7 @@ void ide_dma_host_set(ide_drive_t *drive
 	else
 		dma_stat &= ~(1 << (5 + unit));
 
-	if (hwif->host_flags & IDE_HFLAG_MMIO)
-		writeb(dma_stat,
-		       (void __iomem *)(hwif->dma_base + ATA_DMA_STATUS));
-	else
-		outb(dma_stat, hwif->dma_base + ATA_DMA_STATUS);
+	ide_dma_sff_write_status(hwif, dma_stat);
 }
 EXPORT_SYMBOL_GPL(ide_dma_host_set);
 
@@ -198,7 +204,7 @@ int ide_dma_setup(ide_drive_t *drive)
 	}
 
 	/* PRD table */
-	if (hwif->host_flags & IDE_HFLAG_MMIO)
+	if (mmio)
 		writel(hwif->dmatable_dma,
 		       (void __iomem *)(hwif->dma_base + ATA_DMA_TABLE_OFS));
 	else
@@ -214,12 +220,7 @@ int ide_dma_setup(ide_drive_t *drive)
 	dma_stat = hwif->dma_ops->dma_sff_read_status(hwif);
 
 	/* clear INTR & ERROR flags */
-	if (mmio)
-		writeb(dma_stat | ATA_DMA_ERR | ATA_DMA_INTR,
-		       (void __iomem *)(hwif->dma_base + ATA_DMA_STATUS));
-	else
-		outb(dma_stat | ATA_DMA_ERR | ATA_DMA_INTR,
-		     hwif->dma_base + ATA_DMA_STATUS);
+	ide_dma_sff_write_status(hwif, dma_stat | ATA_DMA_ERR | ATA_DMA_INTR);
 
 	drive->waiting_for_dma = 1;
 	return 0;
@@ -300,13 +301,12 @@ EXPORT_SYMBOL_GPL(ide_dma_start);
 int ide_dma_end(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;
 	u8 dma_stat = 0, dma_cmd = 0, mask;
 
 	drive->waiting_for_dma = 0;
 
 	/* stop DMA */
-	if (mmio) {
+	if (hwif->host_flags & IDE_HFLAG_MMIO) {
 		dma_cmd = readb((void __iomem *)(hwif->dma_base + ATA_DMA_CMD));
 		writeb(dma_cmd & ~ATA_DMA_START,
 		       (void __iomem *)(hwif->dma_base + ATA_DMA_CMD));
@@ -318,13 +318,8 @@ int ide_dma_end(ide_drive_t *drive)
 	/* get DMA status */
 	dma_stat = hwif->dma_ops->dma_sff_read_status(hwif);
 
-	if (mmio)
-		/* clear the INTR & ERROR bits */
-		writeb(dma_stat | ATA_DMA_ERR | ATA_DMA_INTR,
-		       (void __iomem *)(hwif->dma_base + ATA_DMA_STATUS));
-	else
-		outb(dma_stat | ATA_DMA_ERR | ATA_DMA_INTR,
-		     hwif->dma_base + ATA_DMA_STATUS);
+	/* clear INTR & ERROR bits */
+	ide_dma_sff_write_status(hwif, dma_stat | ATA_DMA_ERR | ATA_DMA_INTR);
 
 	/* purge DMA mappings */
 	ide_destroy_dmatable(drive);

