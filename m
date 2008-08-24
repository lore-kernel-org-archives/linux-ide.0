From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-atapi: use drive->waiting_for_dma
Date: Sun, 24 Aug 2008 09:01:19 +0200
Message-ID: <20080824070119.GA18284@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:46805 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbYHXHBY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Aug 2008 03:01:24 -0400
Received: by fk-out-0910.google.com with SMTP id 18so709001fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 24 Aug 2008 00:01:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Borislav Petkov <petkovbb@gmail.com>
Date: Sun, 24 Aug 2008 08:57:57 +0200
Subject: [PATCH] ide-atapi: use drive->waiting_for_dma

.. and remove PC_FLAG_DMA_IN_PROGRESS. There should
be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |   10 +++++-----
 include/linux/ide.h     |    7 +++----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index a1d8c35..09ac062 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -282,7 +282,7 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 	/* Clear the interrupt */
 	stat = tp_ops->read_status(hwif);
 
-	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
+	if (drive->waiting_for_dma) {
 		if (hwif->dma_ops->dma_end(drive) ||
 		    (drive->media == ide_tape && !scsi && (stat & ATA_ERR))) {
 			if (drive->media == ide_floppy && !scsi)
@@ -303,7 +303,7 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 		debug_log("Packet command completed, %d bytes transferred\n",
 			  pc->xferred);
 
-		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
+		drive->waiting_for_dma = 0;
 
 		local_irq_enable_in_hardirq();
 
@@ -347,8 +347,8 @@ cmd_finished:
 		return ide_stopped;
 	}
 
-	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
-		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
+	if (drive->waiting_for_dma) {
+		drive->waiting_for_dma = 0;
 		printk(KERN_ERR "%s: The device wants to issue more interrupts "
 				"in DMA mode\n", drive->name);
 		ide_dma_off(drive);
@@ -528,7 +528,7 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
 
 	/* Begin DMA, if necessary */
 	if (pc->flags & PC_FLAG_DMA_OK) {
-		pc->flags |= PC_FLAG_DMA_IN_PROGRESS;
+		drive->waiting_for_dma = 1;
 		hwif->dma_ops->dma_start(drive);
 	}
 
diff --git a/include/linux/ide.h b/include/linux/ide.h
index e3ccec2..1268e71 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -393,11 +393,10 @@ enum {
 	PC_FLAG_SUPPRESS_ERROR		= (1 << 1),
 	PC_FLAG_WAIT_FOR_DSC		= (1 << 2),
 	PC_FLAG_DMA_OK			= (1 << 3),
-	PC_FLAG_DMA_IN_PROGRESS		= (1 << 4),
-	PC_FLAG_DMA_ERROR		= (1 << 5),
-	PC_FLAG_WRITING			= (1 << 6),
+	PC_FLAG_DMA_ERROR		= (1 << 4),
+	PC_FLAG_WRITING			= (1 << 5),
 	/* command timed out */
-	PC_FLAG_TIMEDOUT		= (1 << 7),
+	PC_FLAG_TIMEDOUT		= (1 << 6),
 };
 
 /*
-- 
1.5.5.4

-- 
Regards/Gruss,
    Boris.
