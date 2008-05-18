From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 29/40] ide-scsi: move idescsi_map_sg() call out from idescsi_issue_pc()
Date: Sun, 18 May 2008 20:58:49 +0200
Message-ID: <20080518185849.5636.74499.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:17236 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384AbYERSlX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:41:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1473278fkq.5
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:41:22 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Move idescsi_map_sg() call out from idescsi_issue_pc()
to idescsi_do_request() as a preparation to adding generic
ide_issue_pc() helper.

There should be no functional changes caused by this patch.

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/scsi/ide-scsi.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

Index: b/drivers/scsi/ide-scsi.c
===================================================================
--- a/drivers/scsi/ide-scsi.c
+++ b/drivers/scsi/ide-scsi.c
@@ -514,16 +514,16 @@ static ide_startstop_t idescsi_issue_pc(
 	/* Request to transfer the entire buffer at once */
 	bcount = min(pc->req_xfer, 63 * 1024);
 
-	if (drive->using_dma && !idescsi_map_sg(drive, pc)) {
+	if ((pc->flags & PC_FLAG_DMA_OK) && drive->using_dma) {
 		hwif->sg_mapped = 1;
 		dma = !hwif->dma_ops->dma_setup(drive);
 		hwif->sg_mapped = 0;
 	}
 
-	ide_pktcmd_tf_load(drive, 0, bcount, dma);
+	if (!dma)
+		pc->flags &= ~PC_FLAG_DMA_OK;
 
-	if (dma)
-		pc->flags |= PC_FLAG_DMA_OK;
+	ide_pktcmd_tf_load(drive, 0, bcount, dma);
 
 	if (test_bit(IDESCSI_DRQ_INTERRUPT, &scsi->flags)) {
 		ide_execute_command(drive, WIN_PACKETCMD, &idescsi_transfer_pc,
@@ -547,8 +547,12 @@ static ide_startstop_t idescsi_do_reques
 		  rq->sector, rq->nr_sectors, rq->current_nr_sectors);
 
 	if (blk_sense_request(rq) || blk_special_request(rq)) {
-		return idescsi_issue_pc(drive,
-				(struct ide_atapi_pc *) rq->special);
+		struct ide_atapi_pc *pc = (struct ide_atapi_pc *)rq->special;
+
+		if (drive->using_dma && !idescsi_map_sg(drive, pc))
+			pc->flags |= PC_FLAG_DMA_OK;
+
+		return idescsi_issue_pc(drive, pc);
 	}
 	blk_dump_rq_flags(rq, "ide-scsi: unsup command");
 	idescsi_end_request (drive, 0, 0);
