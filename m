From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 2/3] ide-atapi: switch to blk_rq_bytes() on do_request() path
Date: Fri,  1 May 2009 22:14:23 +0200
Message-ID: <1241208864-23421-3-git-send-email-petkovbb@gmail.com>
References: <1241208864-23421-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:63266 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbZEAUO3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 May 2009 16:14:29 -0400
Received: by bwz7 with SMTP id 7so2475268bwz.37
        for <linux-ide@vger.kernel.org>; Fri, 01 May 2009 13:14:28 -0700 (PDT)
In-Reply-To: <1241208864-23421-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org

After the recent struct request cleanups, blk_rq_bytes() is guaranteed
to be valid. Use that instead of pc->req_xfer in the do_request() path
after the command has been queued.

The remaining usage of pc->req_xfer now is only until we map the rq to a
bio.

While at it:

- remove local caching of rq completion length in ide_tape_issue_pc()

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c  |   12 +++++++-----
 drivers/ide/ide-floppy.c |    8 ++++----
 drivers/ide/ide-tape.c   |   12 ++++++------
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index 792534d..cacffd4 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -360,7 +360,7 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 						     ? "write" : "read");
 			pc->flags |= PC_FLAG_DMA_ERROR;
 		} else
-			pc->xferred = pc->req_xfer;
+			pc->xferred = blk_rq_bytes(rq);
 		debug_log("%s: DMA finished\n", drive->name);
 	}
 
@@ -617,7 +617,7 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, struct ide_cmd *cmd)
 	ide_hwif_t *hwif = drive->hwif;
 	ide_expiry_t *expiry = NULL;
 	struct request *rq = hwif->rq;
-	unsigned int timeout;
+	unsigned int timeout, bytes;
 	u16 bcount;
 	u8 valid_tf;
 	u8 drq_int = !!(drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT);
@@ -637,9 +637,11 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, struct ide_cmd *cmd)
 		pc->xferred = 0;
 
 		valid_tf = IDE_VALID_DEVICE;
-		bcount = ((drive->media == ide_tape) ?
-				pc->req_xfer :
-				min(pc->req_xfer, 63 * 1024));
+		bytes = blk_rq_bytes(rq);
+
+		bcount = ((drive->media == ide_tape) ? bytes
+						     : min_t(unsigned int,
+							     bytes, 63 * 1024));
 
 		if (pc->flags & PC_FLAG_DMA_ERROR) {
 			pc->flags &= ~PC_FLAG_DMA_ERROR;
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 6509817..a1c5598 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -210,7 +210,7 @@ static void idefloppy_create_rw_cmd(ide_drive_t *drive,
 	if (rq->cmd_flags & REQ_RW)
 		pc->flags |= PC_FLAG_WRITING;
 	pc->buf = NULL;
-	pc->req_xfer = pc->buf_size = blocks * floppy->block_size;
+	pc->buf_size = blk_rq_bytes(rq);
 	pc->flags |= PC_FLAG_DMA_OK;
 }
 
@@ -227,7 +227,7 @@ static void idefloppy_blockpc_cmd(struct ide_disk_obj *floppy,
 	}
 	/* pio will be performed by ide_pio_bytes() which handles sg fine */
 	pc->buf = NULL;
-	pc->req_xfer = pc->buf_size = blk_rq_bytes(rq);
+	pc->buf_size = blk_rq_bytes(rq);
 }
 
 static ide_startstop_t ide_floppy_do_request(ide_drive_t *drive,
@@ -286,8 +286,8 @@ static ide_startstop_t ide_floppy_do_request(ide_drive_t *drive,
 
 	cmd.rq = rq;
 
-	if (blk_fs_request(rq) || pc->req_xfer) {
-		ide_init_sg_cmd(&cmd, pc->req_xfer);
+	if (blk_fs_request(rq) || blk_rq_bytes(rq)) {
+		ide_init_sg_cmd(&cmd, blk_rq_bytes(rq));
 		ide_map_sg(drive, &cmd);
 	}
 
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index fc79cf4..25463c5 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -292,6 +292,7 @@ static void idetape_analyze_error(ide_drive_t *drive, u8 *sense)
 {
 	idetape_tape_t *tape = drive->driver_data;
 	struct ide_atapi_pc *pc = drive->failed_pc;
+	struct request *rq = drive->hwif->rq;
 
 	tape->sense_key = sense[2] & 0xF;
 	tape->asc       = sense[12];
@@ -302,7 +303,7 @@ static void idetape_analyze_error(ide_drive_t *drive, u8 *sense)
 
 	/* Correct pc->xferred by asking the tape.	 */
 	if (pc->flags & PC_FLAG_DMA_ERROR)
-		pc->xferred = pc->req_xfer -
+		pc->xferred = blk_rq_bytes(rq) -
 			tape->blk_size *
 			get_unaligned_be32(&sense[3]);
 
@@ -484,6 +485,7 @@ static ide_startstop_t ide_tape_issue_pc(ide_drive_t *drive,
 					 struct ide_atapi_pc *pc)
 {
 	idetape_tape_t *tape = drive->driver_data;
+	struct request *rq = drive->hwif->rq;
 
 	if (drive->failed_pc == NULL && pc->c[0] != REQUEST_SENSE)
 		drive->failed_pc = pc;
@@ -493,7 +495,6 @@ static ide_startstop_t ide_tape_issue_pc(ide_drive_t *drive,
 
 	if (pc->retries > IDETAPE_MAX_PC_RETRIES ||
 		(pc->flags & PC_FLAG_ABORT)) {
-		unsigned int done = blk_rq_bytes(drive->hwif->rq);
 
 		/*
 		 * We will "abort" retrying a packet command in case legitimate
@@ -517,7 +518,7 @@ static ide_startstop_t ide_tape_issue_pc(ide_drive_t *drive,
 
 		drive->failed_pc = NULL;
 		drive->pc_callback(drive, 0);
-		ide_complete_rq(drive, -EIO, done);
+		ide_complete_rq(drive, -EIO, blk_rq_bytes(rq));
 		return ide_stopped;
 	}
 	debug_log(DBG_SENSE, "Retry #%d, cmd = %02X\n", pc->retries, pc->c[0]);
@@ -592,8 +593,7 @@ static void ide_tape_create_rw_cmd(idetape_tape_t *tape,
 	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
 	pc->c[1] = 1;
 	pc->buf = NULL;
-	pc->buf_size = length * tape->blk_size;
-	pc->req_xfer = pc->buf_size;
+	pc->buf_size = blk_rq_bytes(rq);
 	if (pc->req_xfer == tape->buffer_size)
 		pc->flags |= PC_FLAG_DMA_OK;
 
@@ -718,7 +718,7 @@ out:
 
 	cmd.rq = rq;
 
-	ide_init_sg_cmd(&cmd, pc->req_xfer);
+	ide_init_sg_cmd(&cmd, blk_rq_bytes(rq));
 	ide_map_sg(drive, &cmd);
 
 	return ide_tape_issue_pc(drive, &cmd, pc);
-- 
1.6.2.4

