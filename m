From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/15] libata: make qc->nbytes include extra buffers
Date: Wed,  5 Dec 2007 16:43:12 +0900
Message-ID: <11968405981339-git-send-email-htejun@gmail.com>
References: <11968405951262-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:34008 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbXLEHn4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 02:43:56 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6895949wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 23:43:56 -0800 (PST)
In-Reply-To: <11968405951262-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>

qc->nbytes didn't use to include extra buffers setup by libata core
layer and my be odd.  This patch makes qc->nbytes include any extra
buffers setup by libata core layer and guaranteed to be aligned on 4
byte boundary.

This value is to be used to program the host controller.  As this
represents the actual length of buffer available to the controller and
the controller must be able to deal with short transfers for ATAPI
commands which can transfer variable length, this shouldn't break any
controllers while making problems like rounding-down and controllers
choking up on odd transfer bytes much less likely.

The unmodified value is stored in new field qc->raw_nbytes.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   14 ++++++++++----
 include/linux/libata.h    |    3 ++-
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6e5e7dd..9bc89a6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4760,13 +4760,15 @@ void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 }
 
 static unsigned int ata_sg_setup_extra(struct ata_queued_cmd *qc,
-				       unsigned int *n_elem_extra)
+				       unsigned int *n_elem_extra,
+				       unsigned int *nbytes_extra)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int n_elem = qc->n_elem;
 	struct scatterlist *lsg, *copy_lsg = NULL, *tsg = NULL, *esg = NULL;
 
 	*n_elem_extra = 0;
+	*nbytes_extra = 0;
 
 	/* needs padding? */
 	qc->pad_len = qc->nbytes & 3;
@@ -4830,6 +4832,7 @@ static unsigned int ata_sg_setup_extra(struct ata_queued_cmd *qc,
 		esg = &qc->extra_sg[1];
 
 		(*n_elem_extra)++;
+		(*nbytes_extra) += 4 - qc->pad_len;
 	}
 
 	if (copy_lsg)
@@ -4863,11 +4866,11 @@ static unsigned int ata_sg_setup_extra(struct ata_queued_cmd *qc,
 static int ata_sg_setup(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	unsigned int n_elem, n_elem_extra;
+	unsigned int n_elem, n_elem_extra, nbytes_extra;
 
 	VPRINTK("ENTER, ata%u\n", ap->print_id);
 
-	n_elem = ata_sg_setup_extra(qc, &n_elem_extra);
+	n_elem = ata_sg_setup_extra(qc, &n_elem_extra, &nbytes_extra);
 
 	if (n_elem) {
 		n_elem = dma_map_sg(ap->dev, qc->sg, n_elem, qc->dma_dir);
@@ -4882,7 +4885,7 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 
 	qc->n_elem = qc->mapped_n_elem = n_elem;
 	qc->n_elem += n_elem_extra;
-
+	qc->nbytes += nbytes_extra;
 	qc->flags |= ATA_QCFLAG_DMAMAP;
 
 	return 0;
@@ -5952,6 +5955,9 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	 */
 	BUG_ON(ata_is_data(prot) && (!qc->sg || !qc->n_elem || !qc->nbytes));
 
+	/* ata_sg_setup() may update nbytes */
+	qc->raw_nbytes = qc->nbytes;
+
 	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
 				 (ap->flags & ATA_FLAG_PIO_DMA)))
 		if (ata_sg_setup(qc))
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bf03577..f0017fc 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -467,6 +467,7 @@ struct ata_queued_cmd {
 	unsigned int		sect_size;
 
 	unsigned int		nbytes;
+	unsigned int		raw_nbytes;
 	unsigned int		curbytes;
 
 	struct scatterlist	*cursg;
@@ -1363,7 +1364,7 @@ static inline void ata_qc_reinit(struct ata_queued_cmd *qc)
 	qc->flags = 0;
 	qc->cursg = NULL;
 	qc->cursg_ofs = 0;
-	qc->nbytes = qc->curbytes = 0;
+	qc->nbytes = qc->raw_nbytes = qc->curbytes = 0;
 	qc->n_elem = 0;
 	qc->mapped_n_elem = 0;
 	qc->n_iter = 0;
-- 
1.5.2.4

