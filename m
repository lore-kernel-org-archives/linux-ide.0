From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 3/8] ide-atapi: split drive-specific functionality in ide_issue_pc
Date: Thu, 18 Dec 2008 08:40:47 +0100
Message-ID: <1229586052-3542-4-git-send-email-petkovbb@gmail.com>
References: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:54278 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbYLRHlC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 02:41:02 -0500
Received: by bwz14 with SMTP id 14so1054037bwz.13
        for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2008 23:41:00 -0800 (PST)
In-Reply-To: <1229586052-3542-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   36 ++++++++++++++++++++----------------
 1 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 5295b26..2577782 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -565,39 +565,43 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 
 ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout)
 {
-	struct ide_atapi_pc *pc = drive->pc;
+	struct ide_atapi_pc *pc;
 	ide_hwif_t *hwif = drive->hwif;
 	ide_expiry_t *expiry = NULL;
 	u32 tf_flags;
 	u16 bcount;
 
-	/* We haven't transferred any data yet */
-	pc->xferred = 0;
-	pc->cur_pos = pc->buf;
-
 	if (dev_is_idecd(drive)) {
 		tf_flags = IDE_TFLAG_OUT_NSECT | IDE_TFLAG_OUT_LBAL;
 		bcount = ide_cd_get_xferlen(hwif->hwgroup->rq);
 		expiry = ide_cd_expiry;
+
+		if (drive->dma)
+			drive->dma = !hwif->dma_ops->dma_setup(drive);
 	} else {
+		pc = drive->pc;
+
+		/* We haven't transferred any data yet */
+		pc->xferred = 0;
+		pc->cur_pos = pc->buf;
+
 		tf_flags = IDE_TFLAG_OUT_DEVICE;
 		bcount = ((drive->media == ide_tape) ?
 				pc->req_xfer :
 				min(pc->req_xfer, 63 * 1024));
-	}
 
-	if (pc->flags & PC_FLAG_DMA_ERROR) {
-		pc->flags &= ~PC_FLAG_DMA_ERROR;
-		ide_dma_off(drive);
-	}
+		if (pc->flags & PC_FLAG_DMA_ERROR) {
+			pc->flags &= ~PC_FLAG_DMA_ERROR;
+			ide_dma_off(drive);
+		}
 
-	if (((pc->flags & PC_FLAG_DMA_OK) &&
-		(drive->dev_flags & IDE_DFLAG_USING_DMA)) ||
-	    drive->dma)
-		drive->dma = !hwif->dma_ops->dma_setup(drive);
+		if ((pc->flags & PC_FLAG_DMA_OK) &&
+		     (drive->dev_flags & IDE_DFLAG_USING_DMA))
+			drive->dma = !hwif->dma_ops->dma_setup(drive);
 
-	if (!drive->dma)
-		pc->flags &= ~PC_FLAG_DMA_OK;
+		if (!drive->dma)
+			pc->flags &= ~PC_FLAG_DMA_OK;
+	}
 
 	ide_pktcmd_tf_load(drive, tf_flags, bcount, drive->dma);
 
-- 
1.6.0.4

