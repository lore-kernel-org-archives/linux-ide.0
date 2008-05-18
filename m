From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 04/40] ide-scsi: fix Interrupt Reason checking in idescsi_pc_intr()
Date: Sun, 18 May 2008 20:55:03 +0200
Message-ID: <20080518185503.5636.98141.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:24872 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756095AbYERShi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:37:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1425123fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:37:37 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Set PC_FLAG_WRITING pc flag in idescsi_queue() (if needed)
and then fix Interrupt Reason checking in idescsi_pc_intr().

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/scsi/ide-scsi.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -427,7 +427,15 @@ static ide_startstop_t idescsi_pc_intr (
 		printk(KERN_ERR "ide-scsi: CoD != 0 in idescsi_pc_intr\n");
 		return ide_do_reset (drive);
 	}
-	if (ireason & IO) {
+	if (((ireason & IO) == IO) == !!(pc->flags & PC_FLAG_WRITING)) {
+		/* Hopefully, we will never get here */
+		printk(KERN_ERR "%s: We wanted to %s, but the device wants us "
+				"to %s!\n", drive->name,
+				(ireason & IO) ? "Write" : "Read",
+				(ireason & IO) ? "Read" : "Write");
+		return ide_do_reset(drive);
+	}
+	if (!(pc->flags & PC_FLAG_WRITING)) {
 		temp = pc->xferred + bcount;
 		if (temp > pc->req_xfer) {
 			if (temp > pc->buf_size) {
@@ -436,7 +444,6 @@ static ide_startstop_t idescsi_pc_intr (
 					"- discarding data\n");
 				temp = pc->buf_size - pc->xferred;
 				if (temp) {
-					pc->flags &= ~PC_FLAG_WRITING;
 					if (pc->sg)
 						idescsi_input_buffers(drive, pc,
 									temp);
@@ -457,15 +464,11 @@ static ide_startstop_t idescsi_pc_intr (
 			printk (KERN_NOTICE "ide-scsi: The scsi wants to send us more data than expected - allowing transfer\n");
 #endif /* IDESCSI_DEBUG_LOG */
 		}
-	}
-	if (ireason & IO) {
-		pc->flags &= ~PC_FLAG_WRITING;
 		if (pc->sg)
 			idescsi_input_buffers(drive, pc, bcount);
 		else
 			hwif->input_data(drive, NULL, pc->cur_pos, bcount);
 	} else {
-		pc->flags |= PC_FLAG_WRITING;
 		if (pc->sg)
 			idescsi_output_buffers(drive, pc, bcount);
 		else
@@ -777,6 +780,8 @@ static int idescsi_queue (struct scsi_cm
 
 	memset (pc->c, 0, 12);
 	pc->flags = 0;
+	if (cmd->sc_data_direction == DMA_TO_DEVICE)
+		pc->flags |= PC_FLAG_WRITING;
 	pc->rq = rq;
 	memcpy (pc->c, cmd->cmnd, cmd->cmd_len);
 	pc->buf = NULL;
