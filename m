From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata-sff: fix ata_sff_post_internal_cmd()
Date: Mon, 20 Oct 2008 13:10:21 +0900
Message-ID: <48FC04AD.7050309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55636 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbYJTEM1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Oct 2008 00:12:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

ata_sff_post_internal_cmd() needs to grab port lock before calling
ata_bmdma_stop() and also need to clear hsm_task_state.  Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: work/drivers/ata/libata-sff.c
===================================================================
--- work.orig/drivers/ata/libata-sff.c
+++ work/drivers/ata/libata-sff.c
@@ -2153,8 +2153,17 @@ void ata_sff_error_handler(struct ata_po
  */
 void ata_sff_post_internal_cmd(struct ata_queued_cmd *qc)
 {
-	if (qc->ap->ioaddr.bmdma_addr)
+	struct ata_port *ap = qc->ap;
+	unsigned long flags;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	ap->hsm_task_state = HSM_ST_IDLE;
+
+	if (ap->ioaddr.bmdma_addr)
 		ata_bmdma_stop(qc);
+
+	spin_unlock_irqrestore(ap->lock, flags);
 }
 
 /**
