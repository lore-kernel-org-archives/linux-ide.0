From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 18/18] ide: use flags in IRQ handler
Date: Thu, 12 Jun 2008 08:41:10 +0200
Message-ID: <1213252870-20474-19-git-send-email-petkovbb@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:9461 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbYFLGlM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 02:41:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2381786fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 23:41:10 -0700 (PDT)
In-Reply-To: <1213252870-20474-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Pass pc->flags to the IRQ handler from the drivers (ide-tape/floppy/scsi) thus
making it more pc-unaware.

There should be no functionality change resulting from this.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c  |   25 +++++++++++++------------
 drivers/ide/ide-floppy.c |    3 ++-
 drivers/ide/ide-tape.c   |    3 ++-
 drivers/scsi/ide-scsi.c  |    2 +-
 include/linux/ide.h      |    2 +-
 5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 3a6ae79..dfe1c55 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -19,7 +19,8 @@ ide_startstop_t ide_pc_intr(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	ide_handler_t *handler, unsigned int timeout, ide_expiry_t *expiry,
 	void (*update_buffers)(ide_drive_t *, struct ide_atapi_pc *),
 	void (*retry_pc)(ide_drive_t *), void (*dsc_handle)(ide_drive_t *),
-	void (*io_buffers)(ide_drive_t *, struct ide_atapi_pc *, unsigned, int))
+	void (*io_buffers)(ide_drive_t *, struct ide_atapi_pc *, unsigned, int),
+	unsigned long *flags)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	xfer_func_t *xferfunc;
@@ -35,7 +36,7 @@ ide_startstop_t ide_pc_intr(ide_drive_t *drive, struct ide_atapi_pc *pc,
 
 	debug_log("Enter %s - interrupt handler\n", __func__);
 
-	if (pc->flags & PC_FLAG_TIMEDOUT) {
+	if (*flags & PC_FLAG_TIMEDOUT) {
 		pc->callback(drive);
 		return ide_stopped;
 	}
@@ -43,14 +44,14 @@ ide_startstop_t ide_pc_intr(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	/* Clear the interrupt */
 	stat = ide_read_status(drive);
 
-	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
+	if (*flags & PC_FLAG_DMA_IN_PROGRESS) {
 		if (hwif->dma_ops->dma_end(drive) ||
 		    (drive->media == ide_tape && !scsi && (stat & ERR_STAT))) {
 			if (drive->media == ide_floppy && !scsi)
 				printk(KERN_ERR "%s: DMA %s error\n",
 					drive->name, rq_data_dir(pc->rq)
 						     ? "write" : "read");
-			pc->flags |= PC_FLAG_DMA_ERROR;
+			*flags |= PC_FLAG_DMA_ERROR;
 		} else {
 			pc->xferred = pc->req_xfer;
 			if (update_buffers)
@@ -64,14 +65,14 @@ ide_startstop_t ide_pc_intr(ide_drive_t *drive, struct ide_atapi_pc *pc,
 		debug_log("Packet command completed, %d bytes transferred\n",
 			  pc->xferred);
 
-		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
+		*flags &= ~PC_FLAG_DMA_IN_PROGRESS;
 
 		local_irq_enable_in_hardirq();
 
 		if (drive->media == ide_tape && !scsi &&
 		    (stat & ERR_STAT) && cmd[0] == REQUEST_SENSE)
 			stat &= ~ERR_STAT;
-		if ((stat & ERR_STAT) || (pc->flags & PC_FLAG_DMA_ERROR)) {
+		if ((stat & ERR_STAT) || (*flags & PC_FLAG_DMA_ERROR)) {
 			/* Error detected */
 			debug_log("%s: I/O error\n", drive->name);
 
@@ -96,7 +97,7 @@ ide_startstop_t ide_pc_intr(ide_drive_t *drive, struct ide_atapi_pc *pc,
 		}
 cmd_finished:
 		pc->error = 0;
-		if ((pc->flags & PC_FLAG_WAIT_FOR_DSC) &&
+		if ((*flags & PC_FLAG_WAIT_FOR_DSC) &&
 		    (stat & SEEK_STAT) == 0) {
 			dsc_handle(drive);
 			return ide_stopped;
@@ -106,8 +107,8 @@ cmd_finished:
 		return ide_stopped;
 	}
 
-	if (pc->flags & PC_FLAG_DMA_IN_PROGRESS) {
-		pc->flags &= ~PC_FLAG_DMA_IN_PROGRESS;
+	if (*flags & PC_FLAG_DMA_IN_PROGRESS) {
+		*flags &= ~PC_FLAG_DMA_IN_PROGRESS;
 		printk(KERN_ERR "%s: The device wants to issue more interrupts "
 				"in DMA mode\n", drive->name);
 		ide_dma_off(drive);
@@ -123,7 +124,7 @@ cmd_finished:
 		printk(KERN_ERR "%s: CoD != 0 in %s\n", drive->name, __func__);
 		return ide_do_reset(drive);
 	}
-	if (((ireason & IO) == IO) == !!(pc->flags & PC_FLAG_WRITING)) {
+	if (((ireason & IO) == IO) == !!(*flags & PC_FLAG_WRITING)) {
 		/* Hopefully, we will never get here */
 		printk(KERN_ERR "%s: We wanted to %s, but the device wants us "
 				"to %s!\n", drive->name,
@@ -131,7 +132,7 @@ cmd_finished:
 				(ireason & IO) ? "Read" : "Write");
 		return ide_do_reset(drive);
 	}
-	if (!(pc->flags & PC_FLAG_WRITING)) {
+	if (!(*flags & PC_FLAG_WRITING)) {
 		/* Reading - Check that we have enough space */
 		temp = pc->xferred + bcount;
 		if (temp > pc->req_xfer) {
@@ -172,7 +173,7 @@ cmd_finished:
 	if ((drive->media == ide_floppy && !scsi && !pc->buf) ||
 	    (drive->media == ide_tape && !scsi && pc->bh) ||
 	    (scsi && pc->sg))
-		io_buffers(drive, pc, bcount, !!(pc->flags & PC_FLAG_WRITING));
+		io_buffers(drive, pc, bcount, !!(*flags & PC_FLAG_WRITING));
 	else
 		xferfunc(drive, NULL, pc->cur_pos, bcount);
 
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 8bdef60..d3fcb51 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -395,7 +395,8 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive_t *drive)
 
 	return ide_pc_intr(drive, floppy->pc, idefloppy_pc_intr,
 			   IDEFLOPPY_WAIT_CMD, NULL, idefloppy_update_buffers,
-			   idefloppy_retry_pc, NULL, ide_floppy_io_buffers);
+			   idefloppy_retry_pc, NULL, ide_floppy_io_buffers,
+			   &floppy->pc->flags);
 }
 
 /*
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 6e1233b..0c24426 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -802,7 +802,8 @@ static ide_startstop_t idetape_pc_intr(ide_drive_t *drive)
 
 	return ide_pc_intr(drive, tape->pc, idetape_pc_intr, IDETAPE_WAIT_CMD,
 			   NULL, idetape_update_buffers, idetape_retry_pc,
-			   ide_tape_handle_dsc, ide_tape_io_buffers);
+			   ide_tape_handle_dsc, ide_tape_io_buffers,
+			   &tape->pc->flags);
 }
 
 /*
diff --git a/drivers/scsi/ide-scsi.c b/drivers/scsi/ide-scsi.c
index 683bce3..ef9e693 100644
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -360,7 +360,7 @@ static ide_startstop_t idescsi_pc_intr (ide_drive_t *drive)
 
 	return ide_pc_intr(drive, pc, idescsi_pc_intr, get_timeout(pc),
 			   idescsi_expiry, NULL, NULL, NULL,
-			   ide_scsi_io_buffers);
+			   ide_scsi_io_buffers, &pc->flags);
 }
 
 static ide_startstop_t idescsi_transfer_pc(ide_drive_t *drive)
diff --git a/include/linux/ide.h b/include/linux/ide.h
index df47a5e..09d95c7 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -946,7 +946,7 @@ ide_startstop_t ide_pc_intr(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	void (*update_buffers)(ide_drive_t *, struct ide_atapi_pc *),
 	void (*retry_pc)(ide_drive_t *), void (*dsc_handle)(ide_drive_t *),
 	void (*io_buffers)(ide_drive_t *, struct ide_atapi_pc *, unsigned int,
-			   int));
+			   int), unsigned long *);
 ide_startstop_t ide_transfer_pc(ide_drive_t *, struct ide_atapi_pc *,
 				ide_handler_t *, unsigned int, ide_expiry_t *);
 ide_startstop_t ide_issue_pc(ide_drive_t *, struct ide_atapi_pc *,
-- 
1.5.5.1

