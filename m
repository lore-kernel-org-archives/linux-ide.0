From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/15] libata: change ATA_QCFLAG_DMAMAP semantics
Date: Wed,  5 Dec 2007 16:43:10 +0900
Message-ID: <11968405971396-git-send-email-htejun@gmail.com>
References: <11968405951262-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:33171 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbXLEHny (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 02:43:54 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6895624wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 23:43:53 -0800 (PST)
In-Reply-To: <11968405951262-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>

ATA_QCFLAG_DMAMAP was a bit peculiar in that it got set during qc
initialization and cleared if DMA mapping wasn't necessary.  Make it
more straight forward by making the following changes.

* Don't set it during initialization.  Set it after DMA is actually
  mapped.

* Add BUG_ON() to guarantee that there is data to transfer if DMAMAP
  is set.  This always holds for the current code.  The BUG_ON() is
  for docummentation and sanity check.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5d21cc7..8478fd6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4487,7 +4487,6 @@ void ata_sg_clean(struct ata_queued_cmd *qc)
 	int dir = qc->dma_dir;
 	void *pad_buf = NULL;
 
-	WARN_ON(!(qc->flags & ATA_QCFLAG_DMAMAP));
 	WARN_ON(sg == NULL);
 
 	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
@@ -4759,11 +4758,9 @@ void ata_noop_qc_prep(struct ata_queued_cmd *qc) { }
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem)
 {
-	qc->flags |= ATA_QCFLAG_DMAMAP;
 	qc->__sg = sg;
 	qc->n_elem = n_elem;
 	qc->orig_n_elem = n_elem;
@@ -4792,7 +4789,6 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 	int n_elem, pre_n_elem, dir, trim_sg = 0;
 
 	VPRINTK("ENTER, ata%u\n", ap->print_id);
-	WARN_ON(!(qc->flags & ATA_QCFLAG_DMAMAP));
 
 	/* we must lengthen transfers to end on a 32-bit boundary */
 	qc->pad_len = lsg->length & 3;
@@ -4852,6 +4848,7 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 
 skip_map:
 	qc->n_elem = n_elem;
+	qc->flags |= ATA_QCFLAG_DMAMAP;
 
 	return 0;
 }
@@ -5915,12 +5912,15 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	qc->flags |= ATA_QCFLAG_ACTIVE;
 	ap->qc_active |= 1 << qc->tag;
 
+	/* We guarantee to LLDs that they will have at least one
+	 * non-zero sg if the command is a data command.
+	 */
+	BUG_ON(ata_is_data(prot) && (!qc->__sg || !qc->n_elem || !qc->nbytes));
+
 	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
-				 (ap->flags & ATA_FLAG_PIO_DMA))) {
+				 (ap->flags & ATA_FLAG_PIO_DMA)))
 		if (ata_sg_setup(qc))
 			goto sg_err;
-	} else
-		qc->flags &= ATA_QCFLAG_DMAMAP;
 
 	/* if device is sleeping, schedule softreset and abort the link */
 	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
@@ -5938,7 +5938,6 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	return;
 
 sg_err:
-	qc->flags &= ~ATA_QCFLAG_DMAMAP;
 	qc->err_mask |= AC_ERR_SYSTEM;
 err:
 	ata_qc_complete(qc);
-- 
1.5.2.4

