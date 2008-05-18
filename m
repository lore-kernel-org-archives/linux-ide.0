From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 36/40] ide-floppy: add more debugging to idefloppy_pc_intr()
Date: Sun, 18 May 2008 20:59:52 +0200
Message-ID: <20080518185952.5636.30809.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:17236 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756732AbYERSm1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:42:27 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1473278fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:42:25 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add more debugging to idefloppy_pc_intr() to match ide-tape's
idetape_pc_intr().

While at it:

* Correct the first debug message.

* Log device name with "DMA finished" message.

This is a preparation for adding generic ide_pc_intr() helper.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -397,7 +397,7 @@ static ide_startstop_t idefloppy_pc_intr
 	u16 bcount;
 	u8 stat, ireason;
 
-	debug_log("Reached %s interrupt handler\n", __func__);
+	debug_log("Enter %s - interrupt handler\n", __func__);
 
 	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
 		dma_error = hwif->dma_ops->dma_end(drive);
@@ -409,7 +409,7 @@ static ide_startstop_t idefloppy_pc_intr
 			pc->xferred = pc->req_xfer;
 			idefloppy_update_buffers(drive, pc);
 		}
-		debug_log("DMA finished\n");
+		debug_log("%s: DMA finished\n", drive->name);
 	}
 
 	/* Clear the interrupt */
@@ -432,6 +432,9 @@ static ide_startstop_t idefloppy_pc_intr
 						" command\n", drive->name);
 				return ide_do_reset(drive);
 			}
+
+			debug_log("[cmd %x]: check condition\n", pc->c[0]);
+
 			/* Retry operation */
 			idefloppy_retry_pc(drive);
 			/* queued, but not started */
@@ -505,6 +508,9 @@ static ide_startstop_t idefloppy_pc_intr
 	pc->xferred += bcount;
 	pc->cur_pos += bcount;
 
+	debug_log("[cmd %x] transferred %d bytes on that intr.\n",
+		  pc->c[0], bcount);
+
 	/* And set the interrupt handler again */
 	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);
 	return ide_started;
