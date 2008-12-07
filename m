From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/4] ide-atapi: remove ide-scsi remnants from ide_issue_pc
Date: Sun,  7 Dec 2008 18:21:08 +0100
Message-ID: <1228670471-3435-2-git-send-email-petkovbb@gmail.com>
References: <1228670471-3435-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:7962 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbYLGRVS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Dec 2008 12:21:18 -0500
Received: by mu-out-0910.google.com with SMTP id g7so781713muf.1
        for <linux-ide@vger.kernel.org>; Sun, 07 Dec 2008 09:21:16 -0800 (PST)
In-Reply-To: <1228670471-3435-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index c110329..ff6b567 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -602,7 +602,6 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout)
 	ide_expiry_t *expiry = NULL;
 	u32 tf_flags;
 	u16 bcount;
-	u8 scsi = !!(drive->dev_flags & IDE_DFLAG_SCSI);
 
 	/* We haven't transferred any data yet */
 	pc->xferred = 0;
@@ -612,10 +611,6 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout)
 		tf_flags = IDE_TFLAG_OUT_NSECT | IDE_TFLAG_OUT_LBAL;
 		bcount = ide_cd_get_xferlen(hwif->hwgroup->rq);
 		expiry = ide_cd_expiry;
-	} else if (scsi) {
-		tf_flags = 0;
-		bcount = min(pc->req_xfer, 63 * 1024);
-		expiry = ide_scsi_expiry;
 	} else {
 		tf_flags = IDE_TFLAG_OUT_DEVICE;
 		bcount = ((drive->media == ide_tape) ?
@@ -630,13 +625,8 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout)
 
 	if (((pc->flags & PC_FLAG_DMA_OK) &&
 		(drive->dev_flags & IDE_DFLAG_USING_DMA)) ||
-	    drive->dma) {
-		if (scsi)
-			hwif->sg_mapped = 1;
+	    drive->dma)
 		drive->dma = !hwif->dma_ops->dma_setup(drive);
-		if (scsi)
-			hwif->sg_mapped = 0;
-	}
 
 	if (!drive->dma)
 		pc->flags &= ~PC_FLAG_DMA_OK;
-- 
1.6.0.4

