From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 2/6] ide-atapi: combine drive-specific assignments
Date: Thu,  4 Dec 2008 07:43:25 +0100
Message-ID: <1228373010-20249-3-git-send-email-petkovbb@gmail.com>
References: <1228373010-20249-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:45198 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269AbYLDGni (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2008 01:43:38 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2725981fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 03 Dec 2008 22:43:36 -0800 (PST)
In-Reply-To: <1228373010-20249-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 33a1534..b6e0aac 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -551,18 +551,24 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
 	struct ide_atapi_pc *pc = drive->pc;
 	ide_hwif_t *hwif = drive->hwif;
 	u32 tf_flags;
-	u16 bcount;
+	u16 bcount = 0;
 	u8 scsi = !!(drive->dev_flags & IDE_DFLAG_SCSI);
 
 	/* We haven't transferred any data yet */
 	pc->xferred = 0;
 	pc->cur_pos = pc->buf;
 
-	/* Request to transfer the entire buffer at once */
-	if (drive->media == ide_tape && scsi == 0)
-		bcount = pc->req_xfer;
-	else
+	if (dev_is_idecd(drive)) {
+		tf_flags = IDE_TFLAG_OUT_NSECT | IDE_TFLAG_OUT_LBAL;
+	} else if (scsi) {
+		tf_flags = 0;
 		bcount = min(pc->req_xfer, 63 * 1024);
+	} else {
+		tf_flags = IDE_TFLAG_OUT_DEVICE;
+		bcount = ((drive->media == ide_tape) ?
+				pc->req_xfer :
+				min(pc->req_xfer, 63 * 1024));
+	}
 
 	if (pc->flags & PC_FLAG_DMA_ERROR) {
 		pc->flags &= ~PC_FLAG_DMA_ERROR;
@@ -581,13 +587,6 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
 	if (!drive->dma)
 		pc->flags &= ~PC_FLAG_DMA_OK;
 
-	if (scsi)
-		tf_flags = 0;
-	else if (dev_is_idecd(drive))
-		tf_flags = IDE_TFLAG_OUT_NSECT | IDE_TFLAG_OUT_LBAL;
-	else
-		tf_flags = IDE_TFLAG_OUT_DEVICE;
-
 	ide_pktcmd_tf_load(drive, tf_flags, bcount, drive->dma);
 
 	/* Issue the packet command */
-- 
1.6.0.4

