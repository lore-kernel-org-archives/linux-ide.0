From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/13] ide: add IDE_HFLAG_ERROR_STOPS_FIFO host flag
Date: Wed, 5 Sep 2007 23:52:57 +0200
Message-ID: <200709052352.57848.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:65431 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756973AbXIEV6w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Sep 2007 17:58:52 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1828117nfh
        for <linux-ide@vger.kernel.org>; Wed, 05 Sep 2007 14:58:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add IDE_HFLAG_ERROR_STOPS_FIFO host flag and use it instead
of hwif->err_stops_fifo.  As a side-effect this change fixes
hwif->err_stops_fifo not being restored by ide_hwif_restore().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c           |    3 ++-
 drivers/ide/pci/pdc202xx_new.c |    3 +--
 drivers/ide/pci/pdc202xx_old.c |    8 ++++----
 include/linux/ide.h            |    3 ++-
 4 files changed, 9 insertions(+), 8 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -519,7 +519,8 @@ static ide_startstop_t ide_ata_error(ide
 		}
 	}
 
-	if ((stat & DRQ_STAT) && rq_data_dir(rq) == READ && hwif->err_stops_fifo == 0)
+	if ((stat & DRQ_STAT) && rq_data_dir(rq) == READ &&
+	    (hwif->host_flags & IDE_HFLAG_ERROR_STOPS_FIFO) == 0)
 		try_to_flush_leftover_data(drive);
 
 	if (rq->errors >= ERROR_MAX || blk_noretry_request(rq)) {
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -471,8 +471,6 @@ static void __devinit init_hwif_pdc202ne
 	hwif->quirkproc = &pdcnew_quirkproc;
 	hwif->resetproc = &pdcnew_reset;
 
-	hwif->err_stops_fifo = 1;
-
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
 	if (hwif->dma_base == 0)
@@ -510,6 +508,7 @@ static struct pci_dev * __devinit pdc202
 		.init_chipset	= init_chipset_pdcnew, \
 		.init_hwif	= init_hwif_pdc202new, \
 		.host_flags	= IDE_HFLAG_POST_SET_MODE | \
+				  IDE_HFLAG_ERROR_STOPS_FIFO | \
 				  IDE_HFLAG_OFF_BOARD, \
 		.pio_mask	= ATA_PIO4, \
 		.mwdma_mask	= ATA_MWDMA2, \
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -317,8 +317,6 @@ static void __devinit init_hwif_pdc202xx
 	if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246)
 		hwif->resetproc = &pdc202xx_reset;
 
-	hwif->err_stops_fifo = 1;
-
 	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
 
 	if (hwif->dma_base == 0)
@@ -393,7 +391,8 @@ static void __devinit pdc202ata4_fixup_i
 		.init_hwif	= init_hwif_pdc202xx, \
 		.init_dma	= init_dma_pdc202xx, \
 		.extra		= 48, \
-		.host_flags	= IDE_HFLAG_OFF_BOARD, \
+		.host_flags	= IDE_HFLAG_ERROR_STOPS_FIFO | \
+				  IDE_HFLAG_OFF_BOARD, \
 		.pio_mask	= ATA_PIO4, \
 		.mwdma_mask	= ATA_MWDMA2, \
 		.udma_mask	= udma, \
@@ -406,7 +405,8 @@ static ide_pci_device_t pdc202xx_chipset
 		.init_hwif	= init_hwif_pdc202xx,
 		.init_dma	= init_dma_pdc202xx,
 		.extra		= 16,
-		.host_flags	= IDE_HFLAG_OFF_BOARD,
+		.host_flags	= IDE_HFLAG_ERROR_STOPS_FIFO |
+				  IDE_HFLAG_OFF_BOARD,
 		.pio_mask	= ATA_PIO4,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA2,
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -799,7 +799,6 @@ typedef struct hwif_s {
 	unsigned	auto_poll  : 1; /* supports nop auto-poll */
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 	unsigned	no_io_32bit : 1; /* 1 = can not do 32-bit IO ops */
-	unsigned	err_stops_fifo : 1; /* 1=data FIFO is cleared by an error */
 	unsigned	mmio       : 1; /* host uses MMIO */
 
 	struct device	gendev;
@@ -1261,6 +1260,8 @@ enum {
 	IDE_HFLAG_NO_LBA48		= (1 << 17),
 	/* no LBA48 DMA */
 	IDE_HFLAG_NO_LBA48_DMA		= (1 << 18),
+	/* data FIFO is cleared by an error */
+	IDE_HFLAG_ERROR_STOPS_FIFO	= (1 << 19),
 };
 
 #ifdef CONFIG_BLK_DEV_OFFBOARD
