From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/8] ide: make ide_dma_timeout() available also for CONFIG_BLK_DEV_IDEDMA_SFF=n
Date: Tue, 02 Sep 2008 21:47:26 +0200
Message-ID: <20080902194726.14564.348.sendpatchset@localhost.localdomain>
References: <20080902194711.14564.63625.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:9758 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbYIBTtc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Sep 2008 15:49:32 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2492518muf.1
        for <linux-ide@vger.kernel.org>; Tue, 02 Sep 2008 12:49:31 -0700 (PDT)
In-Reply-To: <20080902194711.14564.63625.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Make ide_dma_timeout() available also for CONFIG_BLK_DEV_IDEDMA_SFF=n
and convert {ics,au1xxx-}ide.c to use it.

While at it:
- dump ATA Status register content on error
- use EXPORT_SYMBOL_GPL() to match the rest of SFF DMA functions

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c      |   16 +---------------
 drivers/ide/ide-dma.c         |    9 +++++----
 drivers/ide/mips/au1xxx-ide.c |   14 +-------------
 include/linux/ide.h           |    2 +-
 4 files changed, 8 insertions(+), 33 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -372,20 +372,6 @@ static int icside_dma_test_irq(ide_drive
 			ICS_ARCIN_V6_INTRSTAT_1)) & 1;
 }
 
-static void icside_dma_timeout(ide_drive_t *drive)
-{
-	ide_hwif_t *hwif = drive->hwif;
-
-	printk(KERN_ERR "%s: DMA timeout occurred: ", drive->name);
-
-	if (icside_dma_test_irq(drive))
-		return;
-
-	ide_dump_status(drive, "DMA timeout", hwif->tp_ops->read_status(hwif));
-
-	icside_dma_end(drive);
-}
-
 static int icside_dma_init(ide_hwif_t *hwif, const struct ide_port_info *d)
 {
 	hwif->dmatable_cpu	= NULL;
@@ -401,7 +387,7 @@ static const struct ide_dma_ops icside_v
 	.dma_start		= icside_dma_start,
 	.dma_end		= icside_dma_end,
 	.dma_test_irq		= icside_dma_test_irq,
-	.dma_timeout		= icside_dma_timeout,
+	.dma_timeout		= ide_dma_timeout,
 	.dma_lost_irq		= ide_dma_lost_irq,
 };
 #else
Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -829,8 +829,7 @@ void ide_dma_lost_irq(ide_drive_t *drive
 }
 EXPORT_SYMBOL_GPL(ide_dma_lost_irq);
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_SFF
-void ide_dma_timeout (ide_drive_t *drive)
+void ide_dma_timeout(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 
@@ -839,11 +838,13 @@ void ide_dma_timeout (ide_drive_t *drive
 	if (hwif->dma_ops->dma_test_irq(drive))
 		return;
 
+	ide_dump_status(drive, "DMA timeout", hwif->tp_ops->read_status(hwif));
+
 	hwif->dma_ops->dma_end(drive);
 }
+EXPORT_SYMBOL_GPL(ide_dma_timeout);
 
-EXPORT_SYMBOL(ide_dma_timeout);
-
+#ifdef CONFIG_BLK_DEV_IDEDMA_SFF
 void ide_release_dma_engine(ide_hwif_t *hwif)
 {
 	if (hwif->dmatable_cpu) {
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -366,18 +366,6 @@ static void auide_init_dbdma_dev(dbdev_t
 }
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-static void auide_dma_timeout(ide_drive_t *drive)
-{
-	ide_hwif_t *hwif = HWIF(drive);
-
-	printk(KERN_ERR "%s: DMA timeout occurred: ", drive->name);
-
-	if (auide_dma_test_irq(drive))
-		return;
-
-	auide_dma_end(drive);
-}
-
 static const struct ide_dma_ops au1xxx_dma_ops = {
 	.dma_host_set		= auide_dma_host_set,
 	.dma_setup		= auide_dma_setup,
@@ -386,7 +374,7 @@ static const struct ide_dma_ops au1xxx_d
 	.dma_end		= auide_dma_end,
 	.dma_test_irq		= auide_dma_test_irq,
 	.dma_lost_irq		= ide_dma_lost_irq,
-	.dma_timeout		= auide_dma_timeout,
+	.dma_timeout		= ide_dma_timeout,
 };
 
 static int auide_ddma_init(ide_hwif_t *hwif, const struct ide_port_info *d)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1432,11 +1432,11 @@ void ide_dma_exec_cmd(ide_drive_t *, u8)
 extern void ide_dma_start(ide_drive_t *);
 int ide_dma_end(ide_drive_t *);
 int ide_dma_test_irq(ide_drive_t *);
-extern void ide_dma_timeout(ide_drive_t *);
 extern const struct ide_dma_ops sff_dma_ops;
 #endif /* CONFIG_BLK_DEV_IDEDMA_SFF */
 
 void ide_dma_lost_irq(ide_drive_t *);
+void ide_dma_timeout(ide_drive_t *);
 
 #else
 static inline int ide_id_dma_bug(ide_drive_t *drive) { return 0; }
