From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/10] libsas: use ata_is_ncq() and ata_has_dma() accessors
Date: Thu, 14 Jul 2016 09:05:44 +0900
Message-ID: <1468454751-12466-4-git-send-email-hch@lst.de>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55696 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcGNAGH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Jul 2016 20:06:07 -0400
In-Reply-To: <1468454751-12466-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

From: Hannes Reinecke <hare@suse.de>

Use accessors instead of the raw protocol value.

Signed-off-by: Hannes Reinecke <hare@suse.com>
[hch: trivial cleanup of the ata_task assignments]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/libsas/sas_ata.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 935c430..497bc15 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -233,15 +233,8 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 	task->task_state_flags = SAS_TASK_STATE_PENDING;
 	qc->lldd_task = task;
 
-	switch (qc->tf.protocol) {
-	case ATA_PROT_NCQ:
-		task->ata_task.use_ncq = 1;
-		/* fall through */
-	case ATAPI_PROT_DMA:
-	case ATA_PROT_DMA:
-		task->ata_task.dma_xfer = 1;
-		break;
-	}
+	task->ata_task.use_ncq = ata_is_ncq(qc->tf.protocol);
+	task->ata_task.dma_xfer = ata_is_dma(qc->tf.protocol);
 
 	if (qc->scsicmd)
 		ASSIGN_SAS_TASK(qc->scsicmd, task);
-- 
2.1.4

