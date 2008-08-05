From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-floppy: use scatterlists for pio transfers
Date: Tue, 5 Aug 2008 07:11:13 +0200
Message-ID: <20080805051113.GA15834@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:17497 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbYHEFLG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 01:11:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1189202fgg.17
        for <linux-ide@vger.kernel.org>; Mon, 04 Aug 2008 22:11:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bart,

here's my first stab at using scatterlists in ide-floppy. I've adapted your
ide-scsi version to fit in here. The change here is that i use pc->b_count as
a sort-of completion counter to know when i'm at the end of the sg element and
be able to switch to the next/finish transfer. I've tested the patch with the
Iomega ZIP drive i have here - it works. We should do some more testing first
though, before sending it upstream.

---
From: Borislav Petkov <petkovbb@gmail.com>
Date: Tue, 5 Aug 2008 06:57:44 +0200
Subject: [PATCH] ide-floppy: use scatterlists for pio transfers

Use hwif->sg_table for pio transfers instead of fumbling
with block layer internals in the driver. Also, make debug
statements more informative in .._do_request() while at it.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-floppy.c |   58 +++++++++++++++++++++++++++------------------
 1 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index de8d42b..5820d3a 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -224,29 +224,37 @@ static void ide_floppy_io_buffers(ide_drive_t *drive, struct ide_atapi_pc *pc,
 				  unsigned int bcount, int direction)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	struct request *rq = pc->rq;
-	struct req_iterator iter;
-	struct bio_vec *bvec;
-	unsigned long flags;
+	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
+	xfer_func_t *xf = direction ? tp_ops->output_data : tp_ops->input_data;
+	struct scatterlist *sg = hwif->sg_table;
+	char *buf;
 	int count, done = 0;
-	char *data;
 
-	rq_for_each_segment(bvec, rq, iter) {
-		if (!bcount)
-			break;
+	while (bcount) {
 
-		count = min(bvec->bv_len, bcount);
-
-		data = bvec_kmap_irq(bvec, &flags);
-		if (direction)
-			hwif->tp_ops->output_data(drive, NULL, data, count);
-		else
-			hwif->tp_ops->input_data(drive, NULL, data, count);
-		bvec_kunmap_irq(data, &flags);
+		count = min(sg->length - pc->b_count, bcount);
+		if (PageHighMem(sg_page(sg))) {
+			unsigned long flags;
 
+			local_irq_save(flags);
+			buf = kmap_atomic(sg_page(sg), KM_IRQ0) + sg->offset;
+			xf(drive, NULL, buf + pc->b_count, count);
+			kunmap_atomic(buf - sg->offset, KM_IRQ0);
+			local_irq_restore(flags);
+		} else {
+			buf = sg_virt(sg);
+			xf(drive, NULL, buf + pc->b_count, count);
+		}
 		bcount -= count;
 		pc->b_count += count;
 		done += count;
+
+		if (pc->b_count == sg->length) {
+			if (!--hwif->sg_nents)
+				break;
+			sg = sg_next(sg);
+			pc->b_count = 0;
+		}
 	}
 
 	idefloppy_end_request(drive, 1, done >> 9);
@@ -569,7 +577,7 @@ static void idefloppy_create_rw_cmd(idefloppy_floppy_t *floppy,
 	memcpy(rq->cmd, pc->c, 12);
 
 	pc->rq = rq;
-	pc->b_count = cmd == READ ? 0 : rq->bio->bi_size;
+	pc->b_count = 0;
 	if (rq->cmd_flags & REQ_RW)
 		pc->flags |= PC_FLAG_WRITING;
 	pc->buf = NULL;
@@ -603,12 +611,13 @@ static ide_startstop_t idefloppy_do_request(ide_drive_t *drive,
 	struct ide_atapi_pc *pc;
 	unsigned long block = (unsigned long)block_s;
 
-	debug_log("dev: %s, cmd_type: %x, errors: %d\n",
-			rq->rq_disk ? rq->rq_disk->disk_name : "?",
-			rq->cmd_type, rq->errors);
-	debug_log("sector: %ld, nr_sectors: %ld, "
-			"current_nr_sectors: %d\n", (long)rq->sector,
-			rq->nr_sectors, rq->current_nr_sectors);
+	debug_log("%s: dev: %s, cmd: 0x%x, cmd_type: %x, errors: %d\n",
+		  __func__, rq->rq_disk ? rq->rq_disk->disk_name : "?",
+		  rq->cmd[0], rq->cmd_type, rq->errors);
+
+	debug_log("%s: sector: %ld, nr_sectors: %ld, current_nr_sectors: %d\n",
+		  __func__, (long)rq->sector, rq->nr_sectors,
+		  rq->current_nr_sectors);
 
 	if (rq->errors >= ERROR_MAX) {
 		if (floppy->failed_pc)
@@ -643,6 +652,9 @@ static ide_startstop_t idefloppy_do_request(ide_drive_t *drive,
 
 	pc->rq = rq;
 
+	ide_init_sg_cmd(drive, rq);
+	ide_map_sg(drive, rq);
+
 	return idefloppy_issue_pc(drive, pc);
 }
 
-- 
1.5.5.4

-- 
Regards/Gruss,
    Boris.
