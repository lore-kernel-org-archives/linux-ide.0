From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 17/40] ide-tape: merge callbacks
Date: Sun, 18 May 2008 20:57:01 +0200
Message-ID: <20080518185701.5636.26650.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:28172 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757350AbYERSji (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:39:38 -0400
Received: by mu-out-0910.google.com with SMTP id w8so773343mue.1
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:39:35 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

The appropriate functionality of the callback is established through querying
the ATAPI packet command in pc->c[0].

While at it:
- add uptodate variable + leave just one idetape_end_request() call
- don't use HWGROUP() macro

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-tape.c |  168 ++++++++++++++++++-------------------------------
 1 file changed, 64 insertions(+), 104 deletions(-)

Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -503,18 +503,6 @@ static struct request *idetape_next_rq_s
 	return (&tape->rq_stack[tape->rq_stack_index++]);
 }
 
-static void idetape_init_pc(struct ide_atapi_pc *pc)
-{
-	memset(pc->c, 0, 12);
-	pc->retries = 0;
-	pc->flags = 0;
-	pc->req_xfer = 0;
-	pc->buf = pc->pc_buf;
-	pc->buf_size = IDETAPE_PC_BUFFER_SIZE;
-	pc->bh = NULL;
-	pc->b_data = NULL;
-}
-
 /*
  * called on each failed packet command retry to analyze the request sense. We
  * currently do not utilize this information.
@@ -631,30 +619,85 @@ static int idetape_end_request(ide_drive
 	return 0;
 }
 
-static ide_startstop_t idetape_request_sense_callback(ide_drive_t *drive)
+static ide_startstop_t ide_tape_callback(ide_drive_t *drive)
 {
 	idetape_tape_t *tape = drive->driver_data;
+	struct ide_atapi_pc *pc = tape->pc;
+	int uptodate = pc->error ? 0 : 1;
 
 	debug_log(DBG_PROCS, "Enter %s\n", __func__);
 
-	if (!tape->pc->error) {
-		idetape_analyze_error(drive, tape->pc->buf);
-		idetape_end_request(drive, 1, 0);
-	} else {
-		printk(KERN_ERR "ide-tape: Error in REQUEST SENSE itself - "
-				"Aborting request!\n");
-		idetape_end_request(drive, 0, 0);
+	if (pc->c[0] == REQUEST_SENSE) {
+		if (uptodate)
+			idetape_analyze_error(drive, pc->buf);
+		else
+			printk(KERN_ERR "ide-tape: Error in REQUEST SENSE "
+					"itself - Aborting request!\n");
+	} else if (pc->c[0] == READ_6 || pc->c[0] == WRITE_6) {
+		struct request *rq = drive->hwif->hwgroup->rq;
+		int blocks = pc->xferred / tape->blk_size;
+
+		tape->avg_size += blocks * tape->blk_size;
+
+		if (time_after_eq(jiffies, tape->avg_time + HZ)) {
+			tape->avg_speed = tape->avg_size * HZ /
+				(jiffies - tape->avg_time) / 1024;
+			tape->avg_size = 0;
+			tape->avg_time = jiffies;
+		}
+
+		tape->first_frame += blocks;
+		rq->current_nr_sectors -= blocks;
+
+		if (pc->error)
+			uptodate = pc->error;
+	} else if (pc->c[0] == READ_POSITION && uptodate) {
+		u8 *readpos = tape->pc->buf;
+
+		debug_log(DBG_SENSE, "BOP - %s\n",
+				(readpos[0] & 0x80) ? "Yes" : "No");
+		debug_log(DBG_SENSE, "EOP - %s\n",
+				(readpos[0] & 0x40) ? "Yes" : "No");
+
+		if (readpos[0] & 0x4) {
+			printk(KERN_INFO "ide-tape: Block location is unknown"
+					 "to the tape\n");
+			clear_bit(IDETAPE_FLAG_ADDRESS_VALID, &tape->flags);
+			uptodate = 0;
+		} else {
+			debug_log(DBG_SENSE, "Block Location - %u\n",
+					be32_to_cpu(*(u32 *)&readpos[4]));
+
+			tape->partition = readpos[1];
+			tape->first_frame = be32_to_cpu(*(u32 *)&readpos[4]);
+			set_bit(IDETAPE_FLAG_ADDRESS_VALID, &tape->flags);
+		}
 	}
+
+	idetape_end_request(drive, uptodate, 0);
+
 	return ide_stopped;
 }
 
+static void idetape_init_pc(struct ide_atapi_pc *pc)
+{
+	memset(pc->c, 0, 12);
+	pc->retries = 0;
+	pc->flags = 0;
+	pc->req_xfer = 0;
+	pc->buf = pc->pc_buf;
+	pc->buf_size = IDETAPE_PC_BUFFER_SIZE;
+	pc->bh = NULL;
+	pc->b_data = NULL;
+	pc->idetape_callback = ide_tape_callback;
+}
+
 static void idetape_create_request_sense_cmd(struct ide_atapi_pc *pc)
 {
 	idetape_init_pc(pc);
 	pc->c[0] = REQUEST_SENSE;
 	pc->c[4] = 20;
 	pc->req_xfer = 20;
-	pc->idetape_callback = &idetape_request_sense_callback;
 }
 
 static void idetape_init_rq(struct request *rq, u8 cmd)
@@ -1025,16 +1068,6 @@ static ide_startstop_t idetape_issue_pc(
 	}
 }
 
-static ide_startstop_t idetape_pc_callback(ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-
-	debug_log(DBG_PROCS, "Enter %s\n", __func__);
-
-	idetape_end_request(drive, tape->pc->error ? 0 : 1, 0);
-	return ide_stopped;
-}
-
 /* A mode sense command is used to "sense" tape parameters. */
 static void idetape_create_mode_sense_cmd(struct ide_atapi_pc *pc, u8 page_code)
 {
@@ -1060,7 +1093,6 @@ static void idetape_create_mode_sense_cm
 		pc->req_xfer = 24;
 	else
 		pc->req_xfer = 50;
-	pc->idetape_callback = &idetape_pc_callback;
 }
 
 static ide_startstop_t idetape_media_access_finished(ide_drive_t *drive)
@@ -1091,32 +1123,6 @@ static ide_startstop_t idetape_media_acc
 	return pc->idetape_callback(drive);
 }
 
-static ide_startstop_t idetape_rw_callback(ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	struct request *rq = HWGROUP(drive)->rq;
-	int blocks = tape->pc->xferred / tape->blk_size;
-
-	tape->avg_size += blocks * tape->blk_size;
-
-	if (time_after_eq(jiffies, tape->avg_time + HZ)) {
-		tape->avg_speed = tape->avg_size * HZ /
-				(jiffies - tape->avg_time) / 1024;
-		tape->avg_size = 0;
-		tape->avg_time = jiffies;
-	}
-	debug_log(DBG_PROCS, "Enter %s\n", __func__);
-
-	tape->first_frame += blocks;
-	rq->current_nr_sectors -= blocks;
-
-	if (!tape->pc->error)
-		idetape_end_request(drive, 1, 0);
-	else
-		idetape_end_request(drive, tape->pc->error, 0);
-	return ide_stopped;
-}
-
 static void idetape_create_read_cmd(idetape_tape_t *tape,
 		struct ide_atapi_pc *pc,
 		unsigned int length, struct idetape_bh *bh)
@@ -1125,7 +1131,6 @@ static void idetape_create_read_cmd(idet
 	pc->c[0] = READ_6;
 	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
 	pc->c[1] = 1;
-	pc->idetape_callback = &idetape_rw_callback;
 	pc->bh = bh;
 	atomic_set(&bh->b_count, 0);
 	pc->buf = NULL;
@@ -1143,7 +1148,6 @@ static void idetape_create_write_cmd(ide
 	pc->c[0] = WRITE_6;
 	put_unaligned(cpu_to_be32(length), (unsigned int *) &pc->c[1]);
 	pc->c[1] = 1;
-	pc->idetape_callback = &idetape_rw_callback;
 	pc->flags |= PC_FLAG_WRITING;
 	pc->bh = bh;
 	pc->b_data = bh->b_data;
@@ -1412,40 +1416,6 @@ static void idetape_init_merge_buffer(id
 	}
 }
 
-static ide_startstop_t idetape_read_position_callback(ide_drive_t *drive)
-{
-	idetape_tape_t *tape = drive->driver_data;
-	u8 *readpos = tape->pc->buf;
-
-	debug_log(DBG_PROCS, "Enter %s\n", __func__);
-
-	if (!tape->pc->error) {
-		debug_log(DBG_SENSE, "BOP - %s\n",
-				(readpos[0] & 0x80) ? "Yes" : "No");
-		debug_log(DBG_SENSE, "EOP - %s\n",
-				(readpos[0] & 0x40) ? "Yes" : "No");
-
-		if (readpos[0] & 0x4) {
-			printk(KERN_INFO "ide-tape: Block location is unknown"
-					 "to the tape\n");
-			clear_bit(IDETAPE_FLAG_ADDRESS_VALID, &tape->flags);
-			idetape_end_request(drive, 0, 0);
-		} else {
-			debug_log(DBG_SENSE, "Block Location - %u\n",
-					be32_to_cpu(*(u32 *)&readpos[4]));
-
-			tape->partition = readpos[1];
-			tape->first_frame =
-				be32_to_cpu(*(u32 *)&readpos[4]);
-			set_bit(IDETAPE_FLAG_ADDRESS_VALID, &tape->flags);
-			idetape_end_request(drive, 1, 0);
-		}
-	} else {
-		idetape_end_request(drive, 0, 0);
-	}
-	return ide_stopped;
-}
-
 /*
  * Write a filemark if write_filemark=1. Flush the device buffers without
  * writing a filemark otherwise.
@@ -1457,14 +1427,12 @@ static void idetape_create_write_filemar
 	pc->c[0] = WRITE_FILEMARKS;
 	pc->c[4] = write_filemark;
 	pc->flags |= PC_FLAG_WAIT_FOR_DSC;
-	pc->idetape_callback = &idetape_pc_callback;
 }
 
 static void idetape_create_test_unit_ready_cmd(struct ide_atapi_pc *pc)
 {
 	idetape_init_pc(pc);
 	pc->c[0] = TEST_UNIT_READY;
-	pc->idetape_callback = &idetape_pc_callback;
 }
 
 /*
@@ -1502,7 +1470,6 @@ static void idetape_create_load_unload_c
 	pc->c[0] = START_STOP;
 	pc->c[4] = cmd;
 	pc->flags |= PC_FLAG_WAIT_FOR_DSC;
-	pc->idetape_callback = &idetape_pc_callback;
 }
 
 static int idetape_wait_ready(ide_drive_t *drive, unsigned long timeout)
@@ -1554,7 +1521,6 @@ static void idetape_create_read_position
 	idetape_init_pc(pc);
 	pc->c[0] = READ_POSITION;
 	pc->req_xfer = 20;
-	pc->idetape_callback = &idetape_read_position_callback;
 }
 
 static int idetape_read_position(ide_drive_t *drive)
@@ -1582,7 +1548,6 @@ static void idetape_create_locate_cmd(id
 	put_unaligned(cpu_to_be32(block), (unsigned int *) &pc->c[3]);
 	pc->c[8] = partition;
 	pc->flags |= PC_FLAG_WAIT_FOR_DSC;
-	pc->idetape_callback = &idetape_pc_callback;
 }
 
 static int idetape_create_prevent_cmd(ide_drive_t *drive,
@@ -1597,7 +1562,6 @@ static int idetape_create_prevent_cmd(id
 	idetape_init_pc(pc);
 	pc->c[0] = ALLOW_MEDIUM_REMOVAL;
 	pc->c[4] = prevent;
-	pc->idetape_callback = &idetape_pc_callback;
 	return 1;
 }
 
@@ -1704,7 +1668,6 @@ static void idetape_create_inquiry_cmd(s
 	pc->c[0] = INQUIRY;
 	pc->c[4] = 254;
 	pc->req_xfer = 254;
-	pc->idetape_callback = &idetape_pc_callback;
 }
 
 static void idetape_create_rewind_cmd(ide_drive_t *drive,
@@ -1713,7 +1676,6 @@ static void idetape_create_rewind_cmd(id
 	idetape_init_pc(pc);
 	pc->c[0] = REZERO_UNIT;
 	pc->flags |= PC_FLAG_WAIT_FOR_DSC;
-	pc->idetape_callback = &idetape_pc_callback;
 }
 
 static void idetape_create_erase_cmd(struct ide_atapi_pc *pc)
@@ -1722,7 +1684,6 @@ static void idetape_create_erase_cmd(str
 	pc->c[0] = ERASE;
 	pc->c[1] = 1;
 	pc->flags |= PC_FLAG_WAIT_FOR_DSC;
-	pc->idetape_callback = &idetape_pc_callback;
 }
 
 static void idetape_create_space_cmd(struct ide_atapi_pc *pc, int count, u8 cmd)
@@ -1732,7 +1693,6 @@ static void idetape_create_space_cmd(str
 	put_unaligned(cpu_to_be32(count), (unsigned int *) &pc->c[1]);
 	pc->c[1] = cmd;
 	pc->flags |= PC_FLAG_WAIT_FOR_DSC;
-	pc->idetape_callback = &idetape_pc_callback;
 }
 
 /* Queue up a character device originated write request. */
