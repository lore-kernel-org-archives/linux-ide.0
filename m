From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 01/10] ide: add ide_drive_t.dma flag
Date: Sun, 14 Sep 2008 13:35:49 +0200
Message-ID: <1221392158-3848-2-git-send-email-petkovbb@gmail.com>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:5793 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876AbYINLgE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Sep 2008 07:36:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1047391fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 14 Sep 2008 04:36:02 -0700 (PDT)
In-Reply-To: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

This flag is to accomodate ide-cd functionality into ide atapi.

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |    9 +++++----
 include/linux/ide.h     |    1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index a1d8c35..d557841 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -545,7 +545,7 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
 	struct ide_atapi_pc *pc = drive->pc;
 	ide_hwif_t *hwif = drive->hwif;
 	u16 bcount;
-	u8 dma = 0, scsi = !!(drive->dev_flags & IDE_DFLAG_SCSI);
+	u8 scsi = !!(drive->dev_flags & IDE_DFLAG_SCSI);
 
 	/* We haven't transferred any data yet */
 	pc->xferred = 0;
@@ -566,15 +566,16 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
 	    (drive->dev_flags & IDE_DFLAG_USING_DMA)) {
 		if (scsi)
 			hwif->sg_mapped = 1;
-		dma = !hwif->dma_ops->dma_setup(drive);
+		drive->dma = !hwif->dma_ops->dma_setup(drive);
 		if (scsi)
 			hwif->sg_mapped = 0;
 	}
 
-	if (!dma)
+	if (!drive->dma)
 		pc->flags &= ~PC_FLAG_DMA_OK;
 
-	ide_pktcmd_tf_load(drive, scsi ? 0 : IDE_TFLAG_OUT_DEVICE, bcount, dma);
+	ide_pktcmd_tf_load(drive, scsi ? 0 : IDE_TFLAG_OUT_DEVICE, bcount,
+			   drive->dma);
 
 	/* Issue the packet command */
 	if (drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT) {
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 540959f..7c1b00a 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -601,6 +601,7 @@ struct ide_drive_s {
 	u8	select;			/* basic drive/head select reg value */
 	u8	retry_pio;		/* retrying dma capable host in pio */
 	u8	waiting_for_dma;	/* dma currently in progress */
+	u8	dma;			/* atapi dma flag */
 
         u8	quirk_list;	/* considered quirky, set for a specific host */
         u8	init_speed;	/* transfer rate set at boot */
-- 
1.5.5.1

