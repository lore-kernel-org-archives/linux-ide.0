From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/13] libata: add qc->dma_nbytes
Date: Wed, 28 Nov 2007 00:13:56 +0900
Message-ID: <11961764413160-git-send-email-htejun@gmail.com>
References: <11961764391983-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.178]:54869 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294AbXK0PON (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 10:14:13 -0500
Received: by ro-out-1112.google.com with SMTP id p4so1688062roc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 07:14:13 -0800 (PST)
In-Reply-To: <11961764391983-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>

qc->nbytes doesn't include extra buffers setup by libata core layer
and my be odd.  This patch adds qc->dma_nbytes which includes any
extra buffers setup by libata core layer and is guaranteed to be
aligned on 4 byte boundary.

This value is to be used to program the host controller.  As this
represents the actual length of buffer available to the controller and
the controller must be able to deal with short transfers for ATAPI
commands which can transfer variable length, this shouldn't break any
controllers while making problems like rounding-down and controllers
choking up on odd transfer bytes much less likely.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c       |   11 +++++++----
 drivers/ata/pata_pdc202xx_old.c |    2 +-
 drivers/ata/sata_inic162x.c     |    2 +-
 drivers/ata/sata_qstor.c        |    2 +-
 include/linux/libata.h          |    3 ++-
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 165c432..148a11e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4757,13 +4757,15 @@ void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
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
@@ -4827,6 +4829,7 @@ static unsigned int ata_sg_setup_extra(struct ata_queued_cmd *qc,
 		esg = &qc->extra_sg[1];
 
 		(*n_elem_extra)++;
+		(*nbytes_extra) += 4 - qc->pad_len;
 	}
 
 	if (copy_lsg)
@@ -4860,11 +4863,11 @@ static unsigned int ata_sg_setup_extra(struct ata_queued_cmd *qc,
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
@@ -4879,7 +4882,7 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 
 	qc->n_elem = qc->mapped_n_elem = n_elem;
 	qc->n_elem += n_elem_extra;
-
+	qc->dma_nbytes = qc->nbytes + nbytes_extra;
 	qc->flags |= ATA_QCFLAG_DMAMAP;
 
 	return 0;
diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
index 407dbcf..f7790fe 100644
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -169,7 +169,7 @@ static void pdc2026x_bmdma_start(struct ata_queued_cmd *qc)
 
 	/* Cases the state machine will not complete correctly without help */
 	if ((tf->flags & ATA_TFLAG_LBA48) ||  tf->protocol == ATAPI_PROT_DMA) {
-		len = qc->nbytes / 2;
+		len = qc->dma_nbytes / 2;
 
 		if (tf->flags & ATA_TFLAG_WRITE)
 			len |= 0x06000000;
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 96e614a..5d9f9ad 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -238,7 +238,7 @@ static void inic_bmdma_setup(struct ata_queued_cmd *qc)
 	wmb();
 
 	/* load transfer length */
-	writel(qc->nbytes, port_base + PORT_PRD_XFERLEN);
+	writel(qc->dma_nbytes, port_base + PORT_PRD_XFERLEN);
 
 	/* turn on DMA and specify data direction */
 	pp->cached_prdctl = pp->dfl_prdctl | PRD_CTL_DMAEN;
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index c55ab77..b5c0031 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -335,7 +335,7 @@ static void qs_qc_prep(struct ata_queued_cmd *qc)
 	/* host control block (HCB) */
 	buf[ 0] = QS_HCB_HDR;
 	buf[ 1] = hflags;
-	*(__le32 *)(&buf[ 4]) = cpu_to_le32(qc->nbytes);
+	*(__le32 *)(&buf[ 4]) = cpu_to_le32(qc->dma_nbytes);
 	*(__le32 *)(&buf[ 8]) = cpu_to_le32(nelem);
 	addr = ((u64)pp->pkt_dma) + QS_CPB_BYTES;
 	*(__le64 *)(&buf[16]) = cpu_to_le64(addr);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8c43cac..62af1eb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -467,6 +467,7 @@ struct ata_queued_cmd {
 	unsigned int		sect_size;
 
 	unsigned int		nbytes;
+	unsigned int		dma_nbytes;
 	unsigned int		curbytes;
 
 	struct scatterlist	*cursg;
@@ -1362,7 +1363,7 @@ static inline void ata_qc_reinit(struct ata_queued_cmd *qc)
 	qc->flags = 0;
 	qc->cursg = NULL;
 	qc->cursg_ofs = 0;
-	qc->nbytes = qc->curbytes = 0;
+	qc->nbytes = qc->curbytes = qc->dma_nbytes = 0;
 	qc->n_elem = 0;
 	qc->mapped_n_elem = 0;
 	qc->n_iter = 0;
-- 
1.5.2.4

