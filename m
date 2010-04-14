From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: fix locking around blk_abort_request()
Date: Thu, 15 Apr 2010 08:57:37 +0900
Message-ID: <4BC65671.6000309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33593 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597Ab0DNXyQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Apr 2010 19:54:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

blk_abort_request() expectes queue lock to be held by the caller.
Grab it before calling the function.

Lack of this synchronization led to infinite loop on corrupt
q->timeout_list.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@kernel.org
---
 drivers/ata/libata-eh.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9f6cfac..9e18cc9 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -879,6 +879,8 @@ static void ata_eh_set_pending(struct ata_port *ap, int fastdrain)
 void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct request_queue *q = qc->scsicmd->device->request_queue;
+	unsigned long flags;

 	WARN_ON(!ap->ops->error_handler);

@@ -890,7 +892,9 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 	 * Note that ATA_QCFLAG_FAILED is unconditionally set after
 	 * this function completes.
 	 */
+	spin_lock_irqsave(q->queue_lock, flags);
 	blk_abort_request(qc->scsicmd->request);
+	spin_unlock_irqrestore(q->queue_lock, flags);
 }

 /**
