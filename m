From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 38/40] ide-scsi: add more debugging to idescsi_pc_intr()
Date: Sun, 18 May 2008 21:00:10 +0200
Message-ID: <20080518190010.5636.62709.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:34853 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758619AbYERSms (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:42:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1426331fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:42:44 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Add more debugging to idescsi_pc_intr() to match ide-tape's
idetape_pc_intr().

While at it:

* Correct the first debug message.

This is a preparation for adding generic ide_pc_intr() helper.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/scsi/ide-scsi.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -364,7 +364,7 @@ static ide_startstop_t idescsi_pc_intr (
 	u16 bcount;
 	u8 stat, ireason;
 
-	debug_log("Reached %s interrupt handler\n", __func__);
+	debug_log("Enter %s - interrupt handler\n", __func__);
 
 	if (pc->flags & PC_FLAG_TIMEDOUT) {
 		pc->callback(drive);
@@ -383,10 +383,16 @@ static ide_startstop_t idescsi_pc_intr (
 
 	if ((stat & DRQ_STAT) == 0) {
 		/* No more interrupts */
+		debug_log("Packet command completed, %d bytes transferred\n",
+			  pc->xferred);
 		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
 		local_irq_enable_in_hardirq();
-		if ((stat & ERR_STAT) || (pc->flags & PC_FLAG_DMA_ERROR))
+		if ((stat & ERR_STAT) || (pc->flags & PC_FLAG_DMA_ERROR)) {
+			/* Error detected */
+			debug_log("%s: I/O error\n", drive->name);
+
 			rq->errors++;
+		}
 		pc->callback(drive);
 		return ide_stopped;
 	}
@@ -457,6 +463,9 @@ static ide_startstop_t idescsi_pc_intr (
 	pc->xferred += bcount;
 	pc->cur_pos += bcount;
 
+	debug_log("[cmd %x] transferred %d bytes on that intr.\n",
+		  pc->c[0], bcount);
+
 	/* And set the interrupt handler again */
 	ide_set_handler(drive, &idescsi_pc_intr, get_timeout(pc), idescsi_expiry);
 	return ide_started;
