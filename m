From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/10] ide: inline ide_dma_timeout() into ide_dma_timeout_retry()
Date: Fri, 20 Feb 2009 18:11:54 +0100
Message-ID: <20090220171154.25429.24988.sendpatchset@localhost.localdomain>
References: <20090220171139.25429.26702.sendpatchset@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759117AbZBTRK6@vger.kernel.org>
In-Reply-To: <20090220171139.25429.26702.sendpatchset@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: inline ide_dma_timeout() into ide_dma_timeout_retry()

Since ide_dma_timeout() is only used by ide_dma_timeout_retry()
inline it there.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -456,20 +456,6 @@ void ide_dma_lost_irq(ide_drive_t *drive
 }
 EXPORT_SYMBOL_GPL(ide_dma_lost_irq);
 
-static void ide_dma_timeout(ide_drive_t *drive)
-{
-	ide_hwif_t *hwif = drive->hwif;
-
-	printk(KERN_ERR "%s: timeout waiting for DMA\n", drive->name);
-
-	if (hwif->dma_ops->dma_test_irq(drive))
-		return;
-
-	ide_dump_status(drive, "DMA timeout", hwif->tp_ops->read_status(hwif));
-
-	hwif->dma_ops->dma_end(drive);
-}
-
 /*
  * un-busy the port etc, and clear any pending DMA status. we want to
  * retry the current request in pio mode instead of risking tossing it
@@ -495,7 +481,12 @@ ide_startstop_t ide_dma_timeout_retry(id
 		printk(KERN_WARNING "%s: DMA timeout retry\n", drive->name);
 		if (dma_ops->dma_clear)
 			dma_ops->dma_clear(drive);
-		ide_dma_timeout(drive);
+		printk(KERN_ERR "%s: timeout waiting for DMA\n", drive->name);
+		if (dma_ops->dma_test_irq(drive) == 0) {
+			ide_dump_status(drive, "DMA timeout",
+					hwif->tp_ops->read_status(hwif));
+			(void)dma_ops->dma_end(drive);
+		}
 	}
 
 	/*
