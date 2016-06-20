From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/6] libsas: use ata_is_ncq() and ata_has_dma() accessors
Date: Mon, 20 Jun 2016 13:39:12 +0200
Message-ID: <1466422756-126637-3-git-send-email-hare@suse.de>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35398 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687AbcFTLyE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Jun 2016 07:54:04 -0400
In-Reply-To: <1466422756-126637-1-git-send-email-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>

Use accessors instead of the raw protocol value.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/libsas/sas_ata.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 935c430..e1da52c 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -233,15 +233,10 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 	task->task_state_flags = SAS_TASK_STATE_PENDING;
 	qc->lldd_task = task;
 
-	switch (qc->tf.protocol) {
-	case ATA_PROT_NCQ:
+	if (ata_is_ncq(qc->tf.protocol))
 		task->ata_task.use_ncq = 1;
-		/* fall through */
-	case ATAPI_PROT_DMA:
-	case ATA_PROT_DMA:
+	if (ata_is_dma(qc->tf.protocol))
 		task->ata_task.dma_xfer = 1;
-		break;
-	}
 
 	if (qc->scsicmd)
 		ASSIGN_SAS_TASK(qc->scsicmd, task);
-- 
1.8.5.6

