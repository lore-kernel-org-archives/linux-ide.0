From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 35/40] ide-tape: always log debug info in idetape_pc_intr() if debugging is enabled
Date: Sun, 18 May 2008 20:59:43 +0200
Message-ID: <20080518185943.5636.13887.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:22495 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758302AbYERSmS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:42:18 -0400
Received: by gv-out-0910.google.com with SMTP id e6so243542gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:42:17 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add DBG_PC_INTR debug level and use it to always log debug info
in idetape_pc_intr() if debugging is enabled.

While at it:

* Use drive->name instead of tape->name.

* Log device name with "DMA finished" message.

This is a preparation for adding generic ide_pc_intr() helper.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -56,6 +56,8 @@ enum {
 	DBG_PROCS =		(1 << 3),
 	/* buffer alloc info (pc_stack & rq_stack) */
 	DBG_PCRQ_STACK =	(1 << 4),
+	/* IRQ handler (always log debug info if debugging is on) */
+	DBG_PC_INTR = 		(1 << 5),
 };
 
 /* define to see debug info */
@@ -64,7 +66,7 @@ enum {
 #if IDETAPE_DEBUG_LOG
 #define debug_log(lvl, fmt, args...)			\
 {							\
-	if (tape->debug_mask & lvl)			\
+	if ((lvl & DBG_PC_INTR) || (tape->debug_mask & lvl)) \
 	printk(KERN_INFO "ide-tape: " fmt, ## args);	\
 }
 #else
@@ -806,7 +808,7 @@ static ide_startstop_t idetape_pc_intr(i
 	u16 bcount;
 	u8 stat, ireason;
 
-	debug_log(DBG_PROCS, "Enter %s - interrupt handler\n", __func__);
+	debug_log(DBG_PC_INTR, "Enter %s - interrupt handler\n", __func__);
 
 	/* Clear the interrupt */
 	stat = ide_read_status(drive);
@@ -818,13 +820,12 @@ static ide_startstop_t idetape_pc_intr(i
 			pc->xferred = pc->req_xfer;
 			idetape_update_buffers(pc);
 		}
-		debug_log(DBG_PROCS, "DMA finished\n");
-
+		debug_log(DBG_PC_INTR, "%s: DMA finished\n", drive->name);
 	}
 
 	/* No more interrupts */
 	if ((stat & DRQ_STAT) == 0) {
-		debug_log(DBG_SENSE, "Packet command completed, %d bytes"
+		debug_log(DBG_PC_INTR, "Packet command completed, %d bytes"
 				" transferred\n", pc->xferred);
 
 		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
@@ -834,14 +835,14 @@ static ide_startstop_t idetape_pc_intr(i
 			stat &= ~ERR_STAT;
 		if ((stat & ERR_STAT) || (pc->flags & PC_FLAG_DMA_ERROR)) {
 			/* Error detected */
-			debug_log(DBG_ERR, "%s: I/O error\n", tape->name);
+			debug_log(DBG_PC_INTR, "%s: I/O error\n", drive->name);
 
 			if (pc->c[0] == REQUEST_SENSE) {
 				printk(KERN_ERR "%s: I/O error in request sense"
 						" command\n", drive->name);
 				return ide_do_reset(drive);
 			}
-			debug_log(DBG_ERR, "[cmd %x]: check condition\n",
+			debug_log(DBG_PC_INTR, "[cmd %x]: check condition\n",
 					pc->c[0]);
 
 			/* Retry operation */
@@ -898,7 +899,7 @@ static ide_startstop_t idetape_pc_intr(i
 						IDETAPE_WAIT_CMD, NULL);
 				return ide_started;
 			}
-			debug_log(DBG_SENSE, "The device wants to send us more "
+			debug_log(DBG_PC_INTR, "The device wants to send us more "
 				"data than expected - allowing transfer\n");
 		}
 		xferfunc = hwif->input_data;
@@ -916,7 +917,7 @@ static ide_startstop_t idetape_pc_intr(i
 	pc->xferred += bcount;
 	pc->cur_pos += bcount;
 
-	debug_log(DBG_SENSE, "[cmd %x] transferred %d bytes on that intr.\n",
+	debug_log(DBG_PC_INTR, "[cmd %x] transferred %d bytes on that intr.\n",
 			pc->c[0], bcount);
 
 	/* And set the interrupt handler again */
