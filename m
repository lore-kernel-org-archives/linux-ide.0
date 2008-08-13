From: Tejun Heo <htejun@gmail.com>
Subject: Re: bad sectors, suspicious behaviour
Date: Wed, 13 Aug 2008 17:40:52 +0900
Message-ID: <48A29E14.3090908@gmail.com>
References: <489C19CE.6030708@ngs.ru> <489C4B6E.9070306@rtr.ca> <489C4F29.6020007@rtr.ca> <489C54D1.5080901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:42367 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149AbYHMIlb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Aug 2008 04:41:31 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1144061yxm.1
        for <linux-ide@vger.kernel.org>; Wed, 13 Aug 2008 01:41:30 -0700 (PDT)
In-Reply-To: <489C54D1.5080901@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Artem Bokhan <aptem@ngs.ru>, linux-ide@vger.kernel.org

Hello, Mark, Artem.

Mark Lord wrote:
> Mmm.. since it happens only once in a while, and not on every EH action,
> one might assume that it's a race of some kind.
> 
> One possibility, might be due to .qc_defer.
> 
> The stock ata_qc_defer relies heavily on ata_tag_valid(),
> which matches what the above WARN_ON uses.
> 
> But sata_mv doesn't use ata_tag_valid, because it wants to know
> about the entire port and not just a single individual link on the port.
> So instead, it uses ap->nr_active_links for the test.
> 
> My guess is that these two items are not kept in sync during EH.

The culprit is mv_qc_defer().  If the controller is in host queueing
mode, it allows multiple non-NCQ commands to be queued, which
currently isn't allowed by the current libata core.  Allowing it
shouldn't be too difficult but it would incur some core layer changes.
For the time being, can you please test whether the following patch
fixes the problem?

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
