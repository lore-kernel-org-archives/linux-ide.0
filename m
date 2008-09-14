From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 03/10] ide-atapi: teach ide atapi about drive->waiting_for_dma
Date: Sun, 14 Sep 2008 13:35:51 +0200
Message-ID: <1221392158-3848-4-git-send-email-petkovbb@gmail.com>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:9920 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbYINLgG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Sep 2008 07:36:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1047398fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 14 Sep 2008 04:36:03 -0700 (PDT)
In-Reply-To: <1221392158-3848-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

This is in preparation for converting ide-cd to generic code. The actual
rewiring will be done later after the issue_pc/transfer_pc code knows all about
ide-cd.

There should be no functional change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index d557841..763acd7 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -487,7 +487,13 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 	ide_startstop_t startstop;
 	u8 ireason;
 
-	if (ide_wait_stat(&startstop, drive, ATA_DRQ, ATA_BUSY, WAIT_READY)) {
+	if ((drive->media == ide_cdrom || drive->media == ide_optical) &&
+	    (drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT)) {
+		if (drive->dma)
+			drive->waiting_for_dma = 1;
+	}
+	else if (ide_wait_stat(&startstop, drive, ATA_DRQ, ATA_BUSY,
+			       WAIT_READY)) {
 		printk(KERN_ERR "%s: Strange, packet command initiated yet "
 				"DRQ isn't asserted\n", drive->name);
 		return startstop;
@@ -562,8 +568,10 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
 		ide_dma_off(drive);
 	}
 
-	if ((pc->flags & PC_FLAG_DMA_OK) &&
-	    (drive->dev_flags & IDE_DFLAG_USING_DMA)) {
+	if (((pc->flags & PC_FLAG_DMA_OK) &&
+		(drive->dev_flags & IDE_DFLAG_USING_DMA)) ||
+	    ((drive->media == ide_cdrom || drive->media == ide_optical) &&
+	         drive->dma)) {
 		if (scsi)
 			hwif->sg_mapped = 1;
 		drive->dma = !hwif->dma_ops->dma_setup(drive);
@@ -579,6 +587,8 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, unsigned int timeout,
 
 	/* Issue the packet command */
 	if (drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT) {
+		if (drive->dma)
+			drive->waiting_for_dma = 0;
 		ide_execute_command(drive, ATA_CMD_PACKET, ide_transfer_pc,
 				    timeout, NULL);
 		return ide_started;
-- 
1.5.5.1

