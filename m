From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/11] au1xxx-ide: use ide_tune_dma()
Date: Sat, 4 Aug 2007 22:06:57 +0200
Message-ID: <200708042206.57529.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:51458 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760939AbXHDUQG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 16:16:06 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1014325fkz
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 13:16:05 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Add ->mdma_filter to ide_hwif_t and use it in ide_get_mode_mask().

* Remove needless setting of drive->using_dma from auide_dma_check().

* Split off auide_mdma_filter() from auide_dma_check().

* Use ide_tune_dma() in auide_dma_check(), this fixes following issues:
  - device's DMA capability bit not being checked
  - device not being checked against generic DMA blacklist
  - transfer mode not being set on device/host

* Add PIO autotune fallback to auide_dma_check().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c         |    3 +++
 drivers/ide/ide.c             |    1 +
 drivers/ide/mips/au1xxx-ide.c |   36 ++++++++++++++++++++++--------------
 include/linux/ide.h           |    1 +
 4 files changed, 27 insertions(+), 14 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -677,6 +677,9 @@ static unsigned int ide_get_mode_mask(id
 	case XFER_MW_DMA_0:
 		if (id->field_valid & 2)
 			mask = id->dma_mword & hwif->mwdma_mask;
+
+		if (hwif->mdma_filter)
+			mask &= hwif->mdma_filter(drive);
 		break;
 	case XFER_SW_DMA_0:
 		if (id->field_valid & 2) {
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -398,6 +398,7 @@ static void ide_hwif_restore(ide_hwif_t 
 
 	hwif->set_pio_mode		= tmp_hwif->set_pio_mode;
 	hwif->set_dma_mode		= tmp_hwif->set_dma_mode;
+	hwif->mdma_filter		= tmp_hwif->mdma_filter;
 	hwif->udma_filter		= tmp_hwif->udma_filter;
 	hwif->selectproc		= tmp_hwif->selectproc;
 	hwif->reset_poll		= tmp_hwif->reset_poll;
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -351,11 +351,18 @@ static int auide_dma_setup(ide_drive_t *
 	return 0;
 }
 
-static int auide_dma_check(ide_drive_t *drive)
+static u8 auide_mdma_filter(ide_drive_t *drive)
 {
-	u8 speed = ide_max_dma_mode(drive);
+	/*
+	 * FIXME: ->white_list and ->black_list are based on completely bogus
+	 * ->ide_dma_check implementation which didn't set neither the host
+	 * controller timings nor the device for the desired transfer mode.
+	 *
+	 * They should be either removed or 0x00 MWDMA mask should be
+	 * returned for devices on the ->black_list.
+	 */
 
-	if( dbdma_init_done == 0 ){
+	if (dbdma_init_done == 0) {
 		auide_hwif.white_list = ide_in_drive_list(drive->id,
 							  dma_white_list);
 		auide_hwif.black_list = ide_in_drive_list(drive->id,
@@ -366,21 +373,20 @@ static int auide_dma_check(ide_drive_t *
 	}
 
 	/* Is the drive in our DMA black list? */
-
-	if ( auide_hwif.black_list ) {
-		drive->using_dma = 0;
-
-		/* Borrowed the warning message from ide-dma.c */
-
+	if (auide_hwif.black_list)
 		printk(KERN_WARNING "%s: Disabling DMA for %s (blacklisted)\n",
-		       drive->name, drive->id->model);	       
-	}
-	else
-		drive->using_dma = 1;
+				    drive->name, drive->id->model);
 
-	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
+	return drive->hwif->mwdma_mask;
+}
+
+static int auide_dma_check(ide_drive_t *drive)
+{
+	if (ide_tune_dma(drive))
 		return 0;
 
+	ide_set_max_pio(drive);
+
 	return -1;
 }
 
@@ -692,6 +698,8 @@ static int au_ide_probe(struct device *d
 	hwif->dma_off_quietly		= &auide_dma_off_quietly;
 	hwif->dma_timeout		= &auide_dma_timeout;
 
+	hwif->mdma_filter		= &auide_mdma_filter;
+
 	hwif->ide_dma_check             = &auide_dma_check;
 	hwif->dma_exec_cmd              = &auide_dma_exec_cmd;
 	hwif->dma_start                 = &auide_dma_start;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -723,6 +723,7 @@ typedef struct hwif_s {
 	/* driver soft-power interface */
 	int	(*busproc)(ide_drive_t *, int);
 #endif
+	u8 (*mdma_filter)(ide_drive_t *);
 	u8 (*udma_filter)(ide_drive_t *);
 
 	void (*ata_input_data)(ide_drive_t *, void *, u32);
