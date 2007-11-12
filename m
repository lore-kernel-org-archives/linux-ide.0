From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/13] ide: move drive->using_dma check to callers of ->dma_host_on method
Date: Tue, 13 Nov 2007 00:02:20 +0100
Message-ID: <200711130002.20962.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:26998 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758209AbXKLW6d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:33 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1613501mue
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:33 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c    |    2 +-
 drivers/ide/ide-iops.c   |    3 ++-
 drivers/ide/pci/cs5520.c |    3 +--
 drivers/ide/pci/sc1200.c |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -470,7 +470,7 @@ EXPORT_SYMBOL(ide_dma_off);
 
 void ide_dma_host_on(ide_drive_t *drive)
 {
-	if (drive->using_dma) {
+	if (1) {
 		ide_hwif_t *hwif	= HWIF(drive);
 		u8 unit			= (drive->select.b.unit & 0x01);
 		u8 dma_stat		= hwif->INB(hwif->dma_status);
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -791,7 +791,8 @@ int ide_config_drive_speed(ide_drive_t *
 	drive->id->dma_1word &= ~0x0F00;
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	if (speed >= XFER_SW_DMA_0 || (hwif->host_flags & IDE_HFLAG_VDMA))
+	if ((speed >= XFER_SW_DMA_0 || (hwif->host_flags & IDE_HFLAG_VDMA)) &&
+	    drive->using_dma)
 		hwif->dma_host_on(drive);
 	else if (hwif->dma_host_on)	/* check if host supports DMA */
 		ide_dma_off_quietly(drive);
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -109,8 +109,7 @@ static void cs5520_set_dma_mode(ide_driv
 
 static void cs5520_dma_host_on(ide_drive_t *drive)
 {
-	if (drive->using_dma)
-		drive->vdma = 1;
+	drive->vdma = 1;
 
 	ide_dma_host_on(drive);
 }
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -221,7 +221,7 @@ static void sc1200_set_pio_mode(ide_driv
 	if (mode != -1) {
 		printk("SC1200: %s: changing (U)DMA mode\n", drive->name);
 		ide_dma_off_quietly(drive);
-		if (ide_set_dma_mode(drive, mode) == 0)
+		if (ide_set_dma_mode(drive, mode) == 0 && drive->using_dma)
 			hwif->dma_host_on(drive);
 		return;
 	}
