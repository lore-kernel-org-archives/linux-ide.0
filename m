From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/22] ide-floppy: fixup ide_floppy_io_buffers()
Date: Sun, 10 Aug 2008 17:35:34 +0200
Message-ID: <20080810153534.16255.96320.sendpatchset@localhost.localdomain>
References: <20080810153527.16255.2504.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:3925 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333AbYHJPhq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Aug 2008 11:37:46 -0400
Received: by mu-out-0910.google.com with SMTP id w8so3058470mue.1
        for <linux-ide@vger.kernel.org>; Sun, 10 Aug 2008 08:37:45 -0700 (PDT)
In-Reply-To: <20080810153527.16255.2504.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

map hwif->sg_{table,nents} on pc->{sg,sg_cnt} (multi-IRQs-per-sg fix)

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
I will fold this into the original patch later.

 drivers/ide/ide-floppy.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -213,12 +213,11 @@ static void ide_floppy_io_buffers(ide_dr
 	ide_hwif_t *hwif = drive->hwif;
 	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
 	xfer_func_t *xf = direction ? tp_ops->output_data : tp_ops->input_data;
-	struct scatterlist *sg = hwif->sg_table;
+	struct scatterlist *sg = pc->sg;
 	char *buf;
 	int count, done = 0;
 
 	while (bcount) {
-
 		count = min(sg->length - pc->b_count, bcount);
 		if (PageHighMem(sg_page(sg))) {
 			unsigned long flags;
@@ -237,9 +236,9 @@ static void ide_floppy_io_buffers(ide_dr
 		done += count;
 
 		if (pc->b_count == sg->length) {
-			if (!--hwif->sg_nents)
+			if (!--pc->sg_cnt)
 				break;
-			sg = sg_next(sg);
+			pc->sg = sg = sg_next(sg);
 			pc->b_count = 0;
 		}
 	}
@@ -576,6 +575,7 @@ static ide_startstop_t idefloppy_do_requ
 		struct request *rq, sector_t block_s)
 {
 	idefloppy_floppy_t *floppy = drive->driver_data;
+	ide_hwif_t *hwif = drive->hwif;
 	struct ide_atapi_pc *pc;
 	unsigned long block = (unsigned long)block_s;
 
@@ -618,11 +618,14 @@ static ide_startstop_t idefloppy_do_requ
 		return ide_stopped;
 	}
 
-	pc->rq = rq;
-
 	ide_init_sg_cmd(drive, rq);
 	ide_map_sg(drive, rq);
 
+	pc->sg = hwif->sg_table;
+	pc->sg_cnt = hwif->sg_nents;
+
+	pc->rq = rq;
+
 	return idefloppy_issue_pc(drive, pc);
 }
 
