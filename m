From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/10] ide-atapi: kill unused fields and callbacks
Date: Sun, 19 Apr 2009 08:58:41 +0900
Message-ID: <1240099122-18381-10-git-send-email-tj@kernel.org>
References: <1240099122-18381-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57782 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753949AbZDRX67 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Apr 2009 19:58:59 -0400
In-Reply-To: <1240099122-18381-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: remove fields and code paths which are no longer necessary

Now that ide-tape uses standard mechanisms to transfer data, special
case handling for bh handling can be dropped from ide-atapi.  Drop the
followings.

* pc->cur_pos, b_count, bh and b_data
* drive->pc_update_buffers() and pc_io_buffers().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-atapi.c |   17 ++++-------------
 drivers/ide/ide-tape.c  |    1 -
 include/linux/ide.h     |   12 ------------
 3 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index b9dd450..afe5a43 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -359,11 +359,8 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 					drive->name, rq_data_dir(pc->rq)
 						     ? "write" : "read");
 			pc->flags |= PC_FLAG_DMA_ERROR;
-		} else {
+		} else
 			pc->xferred = pc->req_xfer;
-			if (drive->pc_update_buffers)
-				drive->pc_update_buffers(drive, pc);
-		}
 		debug_log("%s: DMA finished\n", drive->name);
 	}
 
@@ -463,16 +460,11 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 		return ide_do_reset(drive);
 	}
 
-	if (drive->media == ide_tape && pc->bh)
-		done = drive->pc_io_buffers(drive, pc, bcount, write);
-	else {
-		done = min_t(unsigned int, bcount, cmd->nleft);
-		ide_pio_bytes(drive, cmd, write, done);
-	}
+	done = min_t(unsigned int, bcount, cmd->nleft);
+	ide_pio_bytes(drive, cmd, write, done);
 
-	/* Update the current position */
+	/* Update transferred byte count */
 	pc->xferred += done;
-	pc->cur_pos += done;
 
 	bcount -= done;
 
@@ -650,7 +642,6 @@ ide_startstop_t ide_issue_pc(ide_drive_t *drive, struct ide_cmd *cmd)
 
 		/* We haven't transferred any data yet */
 		pc->xferred = 0;
-		pc->cur_pos = pc->buf;
 
 		valid_tf = IDE_VALID_DEVICE;
 		bcount = ((drive->media == ide_tape) ?
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 2599579..8dfc688 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -591,7 +591,6 @@ static void ide_tape_create_rw_cmd(idetape_tape_t *tape,
 	ide_init_pc(pc);
 	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
 	pc->c[1] = 1;
-	pc->bh = NULL;
 	pc->buf = NULL;
 	pc->buf_size = length * tape->blk_size;
 	pc->req_xfer = pc->buf_size;
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 1957461..34c128f 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -362,11 +362,7 @@ struct ide_atapi_pc {
 
 	/* data buffer */
 	u8 *buf;
-	/* current buffer position */
-	u8 *cur_pos;
 	int buf_size;
-	/* missing/available data on the current buffer */
-	int b_count;
 
 	/* the corresponding request */
 	struct request *rq;
@@ -379,10 +375,6 @@ struct ide_atapi_pc {
 	 */
 	u8 pc_buf[IDE_PC_BUFFER_SIZE];
 
-	/* idetape only */
-	struct idetape_bh *bh;
-	char *b_data;
-
 	unsigned long timeout;
 };
 
@@ -595,10 +587,6 @@ struct ide_drive_s {
 	/* callback for packet commands */
 	int  (*pc_callback)(struct ide_drive_s *, int);
 
-	void (*pc_update_buffers)(struct ide_drive_s *, struct ide_atapi_pc *);
-	int  (*pc_io_buffers)(struct ide_drive_s *, struct ide_atapi_pc *,
-			      unsigned int, int);
-
 	ide_startstop_t (*irq_handler)(struct ide_drive_s *);
 
 	unsigned long atapi_flags;
-- 
1.6.0.2

