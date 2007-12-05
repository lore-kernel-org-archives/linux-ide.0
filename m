From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/15] libata: kill non-sg DMA interface
Date: Wed,  5 Dec 2007 16:43:09 +0900
Message-ID: <1196840597299-git-send-email-htejun@gmail.com>
References: <11968405951262-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:33171 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbXLEHn5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 02:43:57 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6895624wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 23:43:56 -0800 (PST)
In-Reply-To: <11968405951262-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>, Rusty Russel <rusty@rustcorp.com.au>

With atapi_request_sense() converted to use sg, there's no user of
non-sg interface.  Kill non-sg interface.

* ATA_QCFLAG_SINGLE and ATA_QCFLAG_SG are removed.  ATA_QCFLAG_DMAMAP
  is used instead.  (this way no LLD change is necessary)

* qc->buf_virt is removed.

* ata_sg_init_one() and ata_sg_setup_one() are removed.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Rusty Russel <rusty@rustcorp.com.au>
---
 drivers/ata/libata-core.c |  148 +++++----------------------------------------
 include/linux/libata.h    |    7 +--
 2 files changed, 16 insertions(+), 139 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 399f085..5d21cc7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4490,9 +4490,6 @@ void ata_sg_clean(struct ata_queued_cmd *qc)
 	WARN_ON(!(qc->flags & ATA_QCFLAG_DMAMAP));
 	WARN_ON(sg == NULL);
 
-	if (qc->flags & ATA_QCFLAG_SINGLE)
-		WARN_ON(qc->n_elem > 1);
-
 	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
 
 	/* if we padded the buffer out to 32-bit bound, and data
@@ -4502,27 +4499,15 @@ void ata_sg_clean(struct ata_queued_cmd *qc)
 	if (qc->pad_len && !(qc->tf.flags & ATA_TFLAG_WRITE))
 		pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
 
-	if (qc->flags & ATA_QCFLAG_SG) {
-		if (qc->n_elem)
-			dma_unmap_sg(ap->dev, sg, qc->n_elem, dir);
-		/* restore last sg */
-		sg_last(sg, qc->orig_n_elem)->length += qc->pad_len;
-		if (pad_buf) {
-			struct scatterlist *psg = &qc->pad_sgent;
-			void *addr = kmap_atomic(sg_page(psg), KM_IRQ0);
-			memcpy(addr + psg->offset, pad_buf, qc->pad_len);
-			kunmap_atomic(addr, KM_IRQ0);
-		}
-	} else {
-		if (qc->n_elem)
-			dma_unmap_single(ap->dev,
-				sg_dma_address(&sg[0]), sg_dma_len(&sg[0]),
-				dir);
-		/* restore sg */
-		sg->length += qc->pad_len;
-		if (pad_buf)
-			memcpy(qc->buf_virt + sg->length - qc->pad_len,
-			       pad_buf, qc->pad_len);
+	if (qc->n_elem)
+		dma_unmap_sg(ap->dev, sg, qc->n_elem, dir);
+	/* restore last sg */
+	sg_last(sg, qc->orig_n_elem)->length += qc->pad_len;
+	if (pad_buf) {
+		struct scatterlist *psg = &qc->pad_sgent;
+		void *addr = kmap_atomic(sg_page(psg), KM_IRQ0);
+		memcpy(addr + psg->offset, pad_buf, qc->pad_len);
+		kunmap_atomic(addr, KM_IRQ0);
 	}
 
 	qc->flags &= ~ATA_QCFLAG_DMAMAP;
@@ -4762,33 +4747,6 @@ void ata_dumb_qc_prep(struct ata_queued_cmd *qc)
 void ata_noop_qc_prep(struct ata_queued_cmd *qc) { }
 
 /**
- *	ata_sg_init_one - Associate command with memory buffer
- *	@qc: Command to be associated
- *	@buf: Memory buffer
- *	@buflen: Length of memory buffer, in bytes.
- *
- *	Initialize the data-related elements of queued_cmd @qc
- *	to point to a single memory buffer, @buf of byte length @buflen.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-
-void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf, unsigned int buflen)
-{
-	qc->flags |= ATA_QCFLAG_SINGLE;
-
-	qc->__sg = &qc->sgent;
-	qc->n_elem = 1;
-	qc->orig_n_elem = 1;
-	qc->buf_virt = buf;
-	qc->nbytes = buflen;
-	qc->cursg = qc->__sg;
-
-	sg_init_one(&qc->sgent, buf, buflen);
-}
-
-/**
  *	ata_sg_init - Associate command with scatter-gather table.
  *	@qc: Command to be associated
  *	@sg: Scatter-gather table.
@@ -4805,7 +4763,7 @@ void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf, unsigned int buflen)
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem)
 {
-	qc->flags |= ATA_QCFLAG_SG;
+	qc->flags |= ATA_QCFLAG_DMAMAP;
 	qc->__sg = sg;
 	qc->n_elem = n_elem;
 	qc->orig_n_elem = n_elem;
@@ -4813,75 +4771,6 @@ void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 }
 
 /**
- *	ata_sg_setup_one - DMA-map the memory buffer associated with a command.
- *	@qc: Command with memory buffer to be mapped.
- *
- *	DMA-map the memory buffer associated with queued_cmd @qc.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- *	RETURNS:
- *	Zero on success, negative on error.
- */
-
-static int ata_sg_setup_one(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	int dir = qc->dma_dir;
-	struct scatterlist *sg = qc->__sg;
-	dma_addr_t dma_address;
-	int trim_sg = 0;
-
-	/* we must lengthen transfers to end on a 32-bit boundary */
-	qc->pad_len = sg->length & 3;
-	if (qc->pad_len) {
-		void *pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
-		struct scatterlist *psg = &qc->pad_sgent;
-
-		WARN_ON(qc->dev->class != ATA_DEV_ATAPI);
-
-		memset(pad_buf, 0, ATA_DMA_PAD_SZ);
-
-		if (qc->tf.flags & ATA_TFLAG_WRITE)
-			memcpy(pad_buf, qc->buf_virt + sg->length - qc->pad_len,
-			       qc->pad_len);
-
-		sg_dma_address(psg) = ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ);
-		sg_dma_len(psg) = ATA_DMA_PAD_SZ;
-		/* trim sg */
-		sg->length -= qc->pad_len;
-		if (sg->length == 0)
-			trim_sg = 1;
-
-		DPRINTK("padding done, sg->length=%u pad_len=%u\n",
-			sg->length, qc->pad_len);
-	}
-
-	if (trim_sg) {
-		qc->n_elem--;
-		goto skip_map;
-	}
-
-	dma_address = dma_map_single(ap->dev, qc->buf_virt,
-				     sg->length, dir);
-	if (dma_mapping_error(dma_address)) {
-		/* restore sg */
-		sg->length += qc->pad_len;
-		return -1;
-	}
-
-	sg_dma_address(sg) = dma_address;
-	sg_dma_len(sg) = sg->length;
-
-skip_map:
-	DPRINTK("mapped buffer of %d bytes for %s\n", sg_dma_len(sg),
-		qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
-
-	return 0;
-}
-
-/**
  *	ata_sg_setup - DMA-map the scatter-gather table associated with a command.
  *	@qc: Command with scatter-gather table to be mapped.
  *
@@ -4903,7 +4792,7 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 	int n_elem, pre_n_elem, dir, trim_sg = 0;
 
 	VPRINTK("ENTER, ata%u\n", ap->print_id);
-	WARN_ON(!(qc->flags & ATA_QCFLAG_SG));
+	WARN_ON(!(qc->flags & ATA_QCFLAG_DMAMAP));
 
 	/* we must lengthen transfers to end on a 32-bit boundary */
 	qc->pad_len = lsg->length & 3;
@@ -6028,16 +5917,10 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 
 	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
 				 (ap->flags & ATA_FLAG_PIO_DMA))) {
-		if (qc->flags & ATA_QCFLAG_SG) {
-			if (ata_sg_setup(qc))
-				goto sg_err;
-		} else if (qc->flags & ATA_QCFLAG_SINGLE) {
-			if (ata_sg_setup_one(qc))
-				goto sg_err;
-		}
-	} else {
-		qc->flags &= ~ATA_QCFLAG_DMAMAP;
-	}
+		if (ata_sg_setup(qc))
+			goto sg_err;
+	} else
+		qc->flags &= ATA_QCFLAG_DMAMAP;
 
 	/* if device is sleeping, schedule softreset and abort the link */
 	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
@@ -7625,7 +7508,6 @@ EXPORT_SYMBOL_GPL(ata_host_register);
 EXPORT_SYMBOL_GPL(ata_host_activate);
 EXPORT_SYMBOL_GPL(ata_host_detach);
 EXPORT_SYMBOL_GPL(ata_sg_init);
-EXPORT_SYMBOL_GPL(ata_sg_init_one);
 EXPORT_SYMBOL_GPL(ata_hsm_move);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 31e2cbf..87bf14b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -220,9 +220,7 @@ enum {
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
-	ATA_QCFLAG_SG		= (1 << 1), /* have s/g table? */
-	ATA_QCFLAG_SINGLE	= (1 << 2), /* no s/g, just a single buffer */
-	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
+	ATA_QCFLAG_DMAMAP	= (1 << 1), /* SG table is DMA mapped */
 	ATA_QCFLAG_IO		= (1 << 3), /* standard IO command */
 	ATA_QCFLAG_RESULT_TF	= (1 << 4), /* result TF requested */
 	ATA_QCFLAG_CLEAR_EXCL	= (1 << 5), /* clear excl_link on completion */
@@ -476,7 +474,6 @@ struct ata_queued_cmd {
 
 	struct scatterlist	sgent;
 	struct scatterlist	pad_sgent;
-	void			*buf_virt;
 
 	/* DO NOT iterate over __sg manually, use ata_for_each_sg() */
 	struct scatterlist	*__sg;
@@ -892,8 +889,6 @@ extern void ata_dumb_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_noop_qc_prep(struct ata_queued_cmd *qc);
 extern unsigned int ata_qc_issue_prot(struct ata_queued_cmd *qc);
-extern void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf,
-		unsigned int buflen);
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem);
 extern unsigned int ata_dev_classify(const struct ata_taskfile *tf);
-- 
1.5.2.4

