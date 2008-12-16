From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 6/9] ide-atapi: remove pc arg to drive->pc_io_buffers
Date: Tue, 16 Dec 2008 08:36:06 +0100
Message-ID: <1229412969-3552-7-git-send-email-petkovbb@gmail.com>
References: <1229412969-3552-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63034 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbYLPHgR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 02:36:17 -0500
Received: by mail-bw0-f21.google.com with SMTP id 14so3324979bwz.13
        for <linux-ide@vger.kernel.org>; Mon, 15 Dec 2008 23:36:16 -0800 (PST)
In-Reply-To: <1229412969-3552-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

... and get the ptr from drive->pc.

There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-atapi.c |    6 +++---
 drivers/ide/ide-tape.c  |   16 ++++++++--------
 include/linux/ide.h     |    5 ++---
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
index f299d8e..89ce8f0 100644
--- a/drivers/ide/ide-atapi.c
+++ b/drivers/ide/ide-atapi.c
@@ -68,9 +68,9 @@ int ide_check_atapi_device(ide_drive_t *drive, const char *s)
 EXPORT_SYMBOL_GPL(ide_check_atapi_device);
 
 /* PIO data transfer routine using the scatter gather table. */
-int ide_io_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
-		    unsigned int bcount, int write)
+int ide_io_buffers(ide_drive_t *drive, unsigned int bcount, int write)
 {
+	struct ide_atapi_pc *pc = drive->pc;
 	ide_hwif_t *hwif = drive->hwif;
 	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
 	xfer_func_t *xf = write ? tp_ops->output_data : tp_ops->input_data;
@@ -438,7 +438,7 @@ static ide_startstop_t ide_pc_intr(ide_drive_t *drive)
 	if ((drive->media == ide_floppy && !rq->data) ||
 	    (drive->media == ide_tape && pc->bh)) {
 
-		drive->pc_io_buffers(drive, pc, bcount, write);
+		drive->pc_io_buffers(drive, bcount, write);
 
 		if (drive->media == ide_floppy)
 			blk_end_request_callback(rq, 0, bcount,
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index fef9a78..2bfa612 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -313,9 +313,9 @@ static struct ide_tape_obj *ide_tape_chrdev_get(unsigned int i)
 	return tape;
 }
 
-static void idetape_input_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
-				  unsigned int bcount)
+static void idetape_input_buffers(ide_drive_t *drive, unsigned int bcount)
 {
+	struct ide_atapi_pc *pc = drive->pc;
 	struct idetape_bh *bh = pc->bh;
 	int count;
 
@@ -342,9 +342,9 @@ static void idetape_input_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	pc->bh = bh;
 }
 
-static void idetape_output_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
-				   unsigned int bcount)
+static void idetape_output_buffers(ide_drive_t *drive, unsigned int bcount)
 {
+	struct ide_atapi_pc *pc = drive->pc;
 	struct idetape_bh *bh = pc->bh;
 	int count;
 
@@ -601,13 +601,13 @@ static void ide_tape_handle_dsc(ide_drive_t *drive)
 	idetape_postpone_request(drive);
 }
 
-static int ide_tape_io_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
-				unsigned int bcount, int write)
+static int ide_tape_io_buffers(ide_drive_t *drive, unsigned int bcount,
+			       int write)
 {
 	if (write)
-		idetape_output_buffers(drive, pc, bcount);
+		idetape_output_buffers(drive, bcount);
 	else
-		idetape_input_buffers(drive, pc, bcount);
+		idetape_input_buffers(drive, bcount);
 
 	return bcount;
 }
diff --git a/include/linux/ide.h b/include/linux/ide.h
index dac382b..0940db9 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -663,8 +663,7 @@ struct ide_drive_s {
 	void (*pc_callback)(struct ide_drive_s *, int);
 
 	void (*pc_update_buffers)(struct ide_drive_s *, struct ide_atapi_pc *);
-	int  (*pc_io_buffers)(struct ide_drive_s *, struct ide_atapi_pc *,
-			      unsigned int, int);
+	int  (*pc_io_buffers)(struct ide_drive_s *, unsigned int, int);
 
 	unsigned long atapi_flags;
 
@@ -1206,7 +1205,7 @@ void ide_tf_read(ide_drive_t *, ide_task_t *);
 void ide_input_data(ide_drive_t *, struct request *, void *, unsigned int);
 void ide_output_data(ide_drive_t *, struct request *, void *, unsigned int);
 
-int ide_io_buffers(ide_drive_t *, struct ide_atapi_pc *, unsigned int, int);
+int ide_io_buffers(ide_drive_t *, unsigned int, int);
 
 extern void SELECT_DRIVE(ide_drive_t *);
 void SELECT_MASK(ide_drive_t *, int);
-- 
1.6.0.4

