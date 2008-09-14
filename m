From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 09/10] ide-atapi: protect ide_atapi_pc pointer from ide-cd code path
Date: Sun, 14 Sep 2008 13:35:57 +0200
Message-ID: <1221392158-3848-10-git-send-email-petkovbb@gmail.com>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:18333 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbYINLgH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Sep 2008 07:36:07 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1486847fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 14 Sep 2008 04:36:06 -0700 (PDT)
In-Reply-To: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

... since it is undefined.

There should be no functional change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 733a75a..45e88a9 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -561,9 +561,16 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
 	u16 bcount;
 	u8 scsi = !!(drive->dev_flags & IDE_DFLAG_SCSI);
 
-	/* We haven't transferred any data yet */
-	pc->xferred = 0;
-	pc->cur_pos = pc->buf;
+	if (!DEV_IS_IDECD(drive)) {
+		/* We haven't transferred any data yet */
+		pc->xferred = 0;
+		pc->cur_pos = pc->buf;
+
+		if (pc->flags & PC_FLAG_DMA_ERROR) {
+			pc->flags &= ~PC_FLAG_DMA_ERROR;
+			ide_dma_off(drive);
+		}
+	}
 
 	/* Request to transfer the entire buffer at once */
 	if (drive->media == ide_tape && scsi == 0)
@@ -573,14 +580,10 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
 	else
 		bcount = min(pc->req_xfer, 63 * 1024);
 
-	if (pc->flags & PC_FLAG_DMA_ERROR) {
-		pc->flags &= ~PC_FLAG_DMA_ERROR;
-		ide_dma_off(drive);
-	}
-
-	if (((pc->flags & PC_FLAG_DMA_OK) &&
-		(drive->dev_flags & IDE_DFLAG_USING_DMA)) ||
-	    (DEV_IS_IDECD(drive) && drive->dma)) {
+	if (drive->dma ||
+	   (!DEV_IS_IDECD(drive) &&
+	     (pc->flags & PC_FLAG_DMA_OK) &&
+	     (drive->dev_flags & IDE_DFLAG_USING_DMA))) {
 		if (scsi)
 			hwif->sg_mapped = 1;
 		drive->dma = !hwif->dma_ops->dma_setup(drive);
@@ -588,7 +591,7 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
 			hwif->sg_mapped = 0;
 	}
 
-	if (!drive->dma)
+	if (!drive->dma && !DEV_IS_IDECD(drive))
 		pc->flags &= ~PC_FLAG_DMA_OK;
 
 	if (scsi)
-- 
1.5.5.1

