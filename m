From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/5] scc_pata: add ->dma_host_set and ->dma_start methods
Date: Sat, 12 Apr 2008 21:04:26 +0200
Message-ID: <200804122104.26846.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:16865 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755936AbYDLSvn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 14:51:43 -0400
Received: by fg-out-1718.google.com with SMTP id l27so857243fgb.17
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 11:51:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Add ->dma_host_set and ->dma_start methods (+ __scc_dma_end() helper)
so scc_ide_{in,out}b() can be used directly.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/scc_pata.c |   54 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -260,6 +260,20 @@ static void scc_set_dma_mode(ide_drive_t
 	out_be32((void __iomem *)udenvt_port, reg);
 }
 
+static void scc_dma_host_set(ide_drive_t *drive, int on)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u8 unit = (drive->select.b.unit & 0x01);
+	u8 dma_stat = scc_ide_inb(hwif->dma_status);
+
+	if (on)
+		dma_stat |= (1 << (5 + unit));
+	else
+		dma_stat &= ~(1 << (5 + unit));
+
+	scc_ide_outb(dma_stat, hwif->dma_status);
+}
+
 /**
  *	scc_ide_dma_setup	-	begin a DMA phase
  *	@drive: target device
@@ -304,13 +318,45 @@ static int scc_dma_setup(ide_drive_t *dr
 	return 0;
 }
 
+static void scc_dma_start(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u8 dma_cmd = scc_ide_inb(hwif->dma_command);
+
+	/* start DMA */
+	scc_ide_outb(dma_cmd | 1, hwif->dma_command);
+	hwif->dma = 1;
+	wmb();
+}
+
+static int __scc_dma_end(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u8 dma_stat, dma_cmd;
+
+	drive->waiting_for_dma = 0;
+	/* get DMA command mode */
+	dma_cmd = scc_ide_inb(hwif->dma_command);
+	/* stop DMA */
+	scc_ide_outb(dma_cmd & ~1, hwif->dma_command);
+	/* get DMA status */
+	dma_stat = scc_ide_inb(hwif->dma_status);
+	/* clear the INTR & ERROR bits */
+	scc_ide_outb(dma_stat | 6, hwif->dma_status);
+	/* purge DMA mappings */
+	ide_destroy_dmatable(drive);
+	/* verify good DMA status */
+	hwif->dma = 0;
+	wmb();
+	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;
+}
 
 /**
  *	scc_dma_end	-	Stop DMA
  *	@drive: IDE drive
  *
  *	Check and clear INT Status register.
- *      Then call __ide_dma_end().
+ *	Then call __scc_dma_end().
  */
 
 static int scc_dma_end(ide_drive_t *drive)
@@ -414,7 +460,7 @@ static int scc_dma_end(ide_drive_t *driv
 		break;
 	}
 
-	dma_stat = __ide_dma_end(drive);
+	dma_stat = __scc_dma_end(drive);
 	if (data_loss)
 		dma_stat |= 2; /* emulate DMA error (to retry command) */
 	return dma_stat;
@@ -777,10 +823,10 @@ static const struct ide_port_ops scc_por
 };
 
 static const struct ide_dma_ops scc_dma_ops = {
-	.dma_host_set		= ide_dma_host_set,
+	.dma_host_set		= scc_dma_host_set,
 	.dma_setup		= scc_dma_setup,
 	.dma_exec_cmd		= ide_dma_exec_cmd,
-	.dma_start		= ide_dma_start,
+	.dma_start		= scc_dma_start,
 	.dma_end		= scc_dma_end,
 	.dma_test_irq		= scc_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
