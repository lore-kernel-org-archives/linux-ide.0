From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] sata_mv: don't issue two DMA commands concurrently
Date: Wed, 13 Aug 2008 20:24:16 +0900
Message-ID: <48A2C460.6040504@gmail.com>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca> <48A29E14.3090908@gmail.com> <48A2BBDC.2090201@ngs.ru> <48A2BC5D.5060801@gmail.com> <48A2C35C.7020400@ngs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:30387 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbYHMLZO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 07:25:14 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1519767tic.23
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 04:25:12 -0700 (PDT)
In-Reply-To: <48A2C35C.7020400@ngs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Artem Bokhan <aptem@ngs.ru>, Jeff Garzik <jeff@garzik.org>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

sata_mv allowed issuing two DMA commands concurrently which the
hardware allows.  Unfortunately, libata core layer isn't ready for
this yet and spews ugly warning message and malfunctions on this.
Don't allow concurrent DMA commands for now.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
No problem, Artem.

Mark, does this look good to you?

 drivers/ata/sata_mv.c |   34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index ad169ff..80c655f 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1134,30 +1134,16 @@ static int mv_qc_defer(struct ata_queued_cmd *qc)
 	if (ap->nr_active_links == 0)
 		return 0;
 
-	if (pp->pp_flags & MV_PP_FLAG_EDMA_EN) {
-		/*
-		 * The port is operating in host queuing mode (EDMA).
-		 * It can accomodate a new qc if the qc protocol
-		 * is compatible with the current host queue mode.
-		 */
-		if (pp->pp_flags & MV_PP_FLAG_NCQ_EN) {
-			/*
-			 * The host queue (EDMA) is in NCQ mode.
-			 * If the new qc is also an NCQ command,
-			 * then allow the new qc.
-			 */
-			if (qc->tf.protocol == ATA_PROT_NCQ)
-				return 0;
-		} else {
-			/*
-			 * The host queue (EDMA) is in non-NCQ, DMA mode.
-			 * If the new qc is also a non-NCQ, DMA command,
-			 * then allow the new qc.
-			 */
-			if (qc->tf.protocol == ATA_PROT_DMA)
-				return 0;
-		}
-	}
+	/*
+	 * The port is operating in host queuing mode (EDMA) with NCQ
+	 * enabled, allow multiple NCQ commands.  EDMA also allows
+	 * queueing multiple DMA commands but libata core currently
+	 * doesn't allow it.
+	 */
+	if ((pp->pp_flags & MV_PP_FLAG_EDMA_EN) &&
+	    (pp->pp_flags & MV_PP_FLAG_NCQ_EN) && ata_is_ncq(qc->tf.protocol))
+		return 0;
+
 	return ATA_DEFER_PORT;
 }
 
