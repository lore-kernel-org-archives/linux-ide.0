From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: icside_dmaintr() in icside.c
Date: Sun, 24 Oct 2004 15:54:54 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e041024065467404a38@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.197]:14602 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261501AbUJXNy4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Oct 2004 09:54:56 -0400
Received: by rproxy.gmail.com with SMTP id 77so339916rnk
        for <linux-ide@vger.kernel.org>; Sun, 24 Oct 2004 06:54:54 -0700 (PDT)
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org

Hi Russell,

* for() loop in icside_dmaintr seems buggy

* what do you think about following patch?
  (ide-dma is nowadays always build if BLK_DEV_IDEDMA)

[ide] icside: use ide_dma_intr()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
--- a/drivers/ide/arm/icside.c	2004-10-24 15:51:02 +02:00
+++ b/drivers/ide/arm/icside.c	2004-10-24 15:51:02 +02:00
@@ -392,35 +392,6 @@
 	enable_dma(hwif->hw.dma);
 }
 
-/*
- * dma_intr() is the handler for disk read/write DMA interrupts
- */
-static ide_startstop_t icside_dmaintr(ide_drive_t *drive)
-{
-	unsigned int stat;
-	int dma_stat;
-
-	dma_stat = icside_dma_end(drive);
-	stat = HWIF(drive)->INB(IDE_STATUS_REG);
-	if (OK_STAT(stat, DRIVE_READY, drive->bad_wstat | DRQ_STAT)) {
-		if (!dma_stat) {
-			struct request *rq = HWGROUP(drive)->rq;
-			int i;
-
-			for (i = rq->nr_sectors; i > 0; ) {
-				i -= rq->current_nr_sectors;
-				DRIVER(drive)->end_request(drive, 1, rq->nr_sectors);
-			}
-
-			return ide_stopped;
-		}
-		printk(KERN_ERR "%s: bad DMA status (dma_stat=%x)\n",
-		       drive->name, dma_stat);
-	}
-
-	return DRIVER(drive)->error(drive, __FUNCTION__, stat);
-}
-
 static int icside_dma_setup(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -469,7 +440,7 @@
 static void icside_dma_exec_cmd(ide_drive_t *drive, u8 command)
 {
 	/* issue cmd to drive */
-	ide_execute_command(drive, cmd, icside_dmaintr, 2*WAIT_CMD, NULL);
+	ide_execute_command(drive, cmd, ide_dma_intr, 2 * WAIT_CMD, NULL);
 }
 
 static int icside_dma_test_irq(ide_drive_t *drive)
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2004-10-24 15:51:02 +02:00
+++ b/drivers/ide/ide-dma.c	2004-10-24 15:51:02 +02:00
@@ -162,7 +162,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_dma_intr	-	IDE DMA interrupt handler
  *	@drive: the drive the interrupt is for
@@ -192,6 +191,7 @@
 
 EXPORT_SYMBOL_GPL(ide_dma_intr);
 
+#ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 /**
  *	ide_build_sglist	-	map IDE scatter gather for DMA I/O
  *	@drive: the drive to build the DMA table for
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2004-10-24 15:51:02 +02:00
+++ b/include/linux/ide.h	2004-10-24 15:51:02 +02:00
@@ -1493,12 +1493,12 @@
 int __ide_dma_good_drive(ide_drive_t *);
 int __ide_dma_off(ide_drive_t *);
 void ide_dma_verbose(ide_drive_t *);
+ide_startstop_t ide_dma_intr(ide_drive_t *);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 extern int ide_build_sglist(ide_drive_t *, struct request *);
 extern int ide_build_dmatable(ide_drive_t *, struct request *);
 extern void ide_destroy_dmatable(ide_drive_t *);
-extern ide_startstop_t ide_dma_intr(ide_drive_t *);
 extern int ide_release_dma(ide_hwif_t *);
 extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
