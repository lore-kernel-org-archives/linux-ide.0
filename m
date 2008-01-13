From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 8/12] ide-floppy: merge idefloppy_{input,output}_buffers
Date: Sun, 13 Jan 2008 21:18:21 +0100
Message-ID: <1200255505-31418-9-git-send-email-bbpetkov@yahoo.de>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-2-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-3-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-4-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-5-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-6-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-7-git-send-email-bbpetkov@yahoo.de>
 <1200255505-31418-8-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp115.plus.mail.re1.yahoo.com ([69.147.102.78]:35764 "HELO
	smtp115.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753640AbYAMUWM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 15:22:12 -0500
In-Reply-To: <1200255505-31418-8-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

We merge idefloppy_{input,output}_buffers() into idefloppy_io_buffers() by
introducing a 4th arg. called direction. According to its value
we atapi_input_bytes() or atapi_output_bytes(). Also, this simplifies the
interrupt handler logic a bit. Finally, rename idefloppy_io_buffers() to
ide_floppy_io_buffers().

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |   67 +++++++++++++--------------------------------
 1 files changed, 20 insertions(+), 47 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index e7cc9dd..6c917fc 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -321,39 +321,8 @@ static int idefloppy_do_end_request(ide_drive_t *drive, int uptodate, int nsecs)
 	return 0;
 }
 
-static void idefloppy_input_buffers (ide_drive_t *drive, idefloppy_pc_t *pc, unsigned int bcount)
-{
-	struct request *rq = pc->rq;
-	struct bio_vec *bvec;
-	struct req_iterator iter;
-	unsigned long flags;
-	char *data;
-	int count, done = 0;
-
-	rq_for_each_segment(bvec, rq, iter) {
-		if (!bcount)
-			break;
-
-		count = min(bvec->bv_len, bcount);
-
-		data = bvec_kmap_irq(bvec, &flags);
-		drive->hwif->atapi_input_bytes(drive, data, count);
-		bvec_kunmap_irq(data, &flags);
-
-		bcount -= count;
-		pc->b_count += count;
-		done += count;
-	}
-
-	idefloppy_do_end_request(drive, 1, done >> 9);
-
-	if (bcount) {
-		printk(KERN_ERR "%s: leftover data in idefloppy_input_buffers, bcount == %d\n", drive->name, bcount);
-		idefloppy_discard_data(drive, bcount);
-	}
-}
-
-static void idefloppy_output_buffers (ide_drive_t *drive, idefloppy_pc_t *pc, unsigned int bcount)
+static void ide_floppy_io_buffers(ide_drive_t *drive, idefloppy_pc_t *pc,
+		unsigned int bcount, int direction)
 {
 	struct request *rq = pc->rq;
 	struct req_iterator iter;
@@ -369,7 +338,10 @@ static void idefloppy_output_buffers (ide_drive_t *drive, idefloppy_pc_t *pc, un
 		count = min(bvec->bv_len, bcount);
 
 		data = bvec_kmap_irq(bvec, &flags);
-		drive->hwif->atapi_output_bytes(drive, data, count);
+		if (direction)
+			drive->hwif->atapi_output_bytes(drive, data, count);
+		else
+			drive->hwif->atapi_input_bytes(drive, data, count);
 		bvec_kunmap_irq(data, &flags);
 
 		bcount -= count;
@@ -380,8 +352,13 @@ static void idefloppy_output_buffers (ide_drive_t *drive, idefloppy_pc_t *pc, un
 	idefloppy_do_end_request(drive, 1, done >> 9);
 
 	if (bcount) {
-		printk(KERN_ERR "%s: leftover data in idefloppy_output_buffers, bcount == %d\n", drive->name, bcount);
-		idefloppy_write_zeros(drive, bcount);
+		printk(KERN_ERR "%s: leftover data in idefloppy_output_buffers,"
+			" bcount == %d\n", drive->name, bcount);
+		if (direction)
+			idefloppy_write_zeros(drive, bcount);
+		else
+			idefloppy_discard_data(drive, bcount);
+
 	}
 }
 
@@ -516,8 +493,6 @@ static void idefloppy_retry_pc (ide_drive_t *drive)
 	idefloppy_queue_pc_head(drive, pc, rq);
 }
 
-typedef void (io_buf_t)(ide_drive_t *, idefloppy_pc_t *, unsigned int);
-
 static ide_startstop_t idefloppy_pc_intr(ide_drive_t *drive)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
@@ -525,7 +500,6 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive_t *drive)
 	idefloppy_pc_t *pc = floppy->pc;
 	struct request *rq = pc->rq;
 	xfer_func_t *xferfunc;
-	io_buf_t *iobuf_func;
 	unsigned int temp;
 	u16 bcount;
 	u8 stat, ireason;
@@ -625,24 +599,23 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive_t *drive)
 					" expected - allowing transfer\n");
 		}
 	}
-	if (test_bit(PC_WRITING, &pc->flags)) {
+	if (test_bit(PC_WRITING, &pc->flags))
 		xferfunc = hwif->atapi_output_bytes;
-		iobuf_func = &idefloppy_output_buffers;
-	} else {
+	else
 		xferfunc = hwif->atapi_input_bytes;
-		iobuf_func = &idefloppy_input_buffers;
-	}
 
-	if (pc->buffer != NULL)
+	if (pc->buffer)
 		xferfunc(drive, pc->current_position, bcount);
 	else
-		iobuf_func(drive, pc, bcount);
+		ide_floppy_io_buffers(drive, pc, bcount,
+				test_bit(PC_WRITING, &pc->flags));
 
 	/* Update the current position */
 	pc->actually_transferred += bcount;
 	pc->current_position += bcount;
 
-	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);		/* And set the interrupt handler again */
+	/* And set the interrupt handler again */
+	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);
 	return ide_started;
 }
 
-- 
1.5.3.7

