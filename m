From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/22] ide-scsi: cleanup ide_scsi_io_buffers()
Date: Sun, 10 Aug 2008 17:35:41 +0200
Message-ID: <20080810153541.16255.81614.sendpatchset@localhost.localdomain>
References: <20080810153527.16255.2504.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:13064 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbYHJPhy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Aug 2008 11:37:54 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1414994fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 10 Aug 2008 08:37:52 -0700 (PDT)
In-Reply-To: <20080810153527.16255.2504.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Preparation for ide_{floppy,scsi}_io_buffers() unification.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/scsi/ide-scsi.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -139,29 +139,29 @@ static void ide_scsi_io_buffers(ide_driv
 	ide_hwif_t *hwif = drive->hwif;
 	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
 	xfer_func_t *xf = write ? tp_ops->output_data : tp_ops->input_data;
+	struct scatterlist *sg = pc->sg;
 	char *buf;
 	int count;
 
 	while (bcount) {
-		count = min(pc->sg->length - pc->b_count, bcount);
-		if (PageHighMem(sg_page(pc->sg))) {
+		count = min(sg->length - pc->b_count, bcount);
+		if (PageHighMem(sg_page(sg))) {
 			unsigned long flags;
 
 			local_irq_save(flags);
-			buf = kmap_atomic(sg_page(pc->sg), KM_IRQ0) +
-					  pc->sg->offset;
+			buf = kmap_atomic(sg_page(sg), KM_IRQ0) + sg->offset;
 			xf(drive, NULL, buf + pc->b_count, count);
-			kunmap_atomic(buf - pc->sg->offset, KM_IRQ0);
+			kunmap_atomic(buf - sg->offset, KM_IRQ0);
 			local_irq_restore(flags);
 		} else {
-			buf = sg_virt(pc->sg);
+			buf = sg_virt(sg);
 			xf(drive, NULL, buf + pc->b_count, count);
 		}
 		bcount -= count; pc->b_count += count;
-		if (pc->b_count == pc->sg->length) {
+		if (pc->b_count == sg->length) {
 			if (!--pc->sg_cnt)
 				break;
-			pc->sg = sg_next(pc->sg);
+			pc->sg = sg = sg_next(sg);
 			pc->b_count = 0;
 		}
 	}
