From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 14/15] ide: remove dead code from ide_driveid_update()
Date: Mon, 1 Oct 2007 23:41:23 +0200
Message-ID: <200710012341.23176.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:62096 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757245AbXJAVjw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:52 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977013ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Remove dead code from ide_driveid_update().

While at it:

* Remove useless comment.

* s/HWIF(drive)/drive->hwif/

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |   26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -693,35 +693,16 @@ static u8 ide_auto_reduce_xfer (ide_driv
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
-/*
- * Update the 
- */
-int ide_driveid_update (ide_drive_t *drive)
+int ide_driveid_update(ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
+	ide_hwif_t *hwif = drive->hwif;
 	struct hd_driveid *id;
-#if 0
-	id = kmalloc(SECTOR_WORDS*4, GFP_ATOMIC);
-	if (!id)
-		return 0;
-
-	taskfile_lib_get_identify(drive, (char *)&id);
+	unsigned long timeout, flags;
 
-	ide_fix_driveid(id);
-	if (id) {
-		drive->id->dma_ultra = id->dma_ultra;
-		drive->id->dma_mword = id->dma_mword;
-		drive->id->dma_1word = id->dma_1word;
-		/* anything more ? */
-		kfree(id);
-	}
-	return 1;
-#else
 	/*
 	 * Re-read drive->id for possible DMA mode
 	 * change (copied from ide-probe.c)
 	 */
-	unsigned long timeout, flags;
 
 	SELECT_MASK(drive, 1);
 	if (IDE_CONTROL_REG)
@@ -763,7 +744,6 @@ int ide_driveid_update (ide_drive_t *dri
 	}
 
 	return 1;
-#endif
 }
 
 int ide_config_drive_speed(ide_drive_t *drive, u8 speed)
