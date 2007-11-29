From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/14] libata: convert to chained sg
Date: Thu, 29 Nov 2007 23:33:33 +0900
Message-ID: <11963468191350-git-send-email-htejun@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:41590 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762147AbXK2OeH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 09:34:07 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2204926wah
        for <linux-ide@vger.kernel.org>; Thu, 29 Nov 2007 06:34:07 -0800 (PST)
In-Reply-To: <1196346817387-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <jens.axboe@oracle.com>

libata used private sg iterator to handle padding sg.  Now that sg can
be chained, padding can be handled using standard sg ops.  Convert to
chained sg.

* s/qc->__sg/qc->sg/

* s/qc->pad_sgent/qc->extra_sg[]/.  Because chaining consumes one sg
  entry.  There need to be two extra sg entries.  The renaming is also
  for future addition of other extra sg entries.

* Padding setup is moved into ata_sg_setup_extra() which is organized
  in a way that future addition of other extra sg entries is easy.

* qc->orig_n_elem is unused and removed.

* qc->n_elem now contains the number of sg entries that LLDs should
  map.  qc->mapped_n_elem is added to carry the original number of
  mapped sgs for unmapping.

* The last sg of the original sg list is used to chain to extra sg
  list.  The original last sg is pointed to by qc->last_sg and the
  content is stored in qc->saved_last_sg.  It's restored during
  ata_sg_clean().

* All sg walking code has been updated.  Unnecessary assertions and
  checks for conditions the core layer already guarantees are removed.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
---
 drivers/ata/ahci.c            |   18 ++---
 drivers/ata/libata-core.c     |  201 ++++++++++++++++++++++++-----------------
 drivers/ata/libata-scsi.c     |    2 +-
 drivers/ata/pata_bf54x.c      |   13 ++-
 drivers/ata/pata_icside.c     |    3 +-
 drivers/ata/pdc_adma.c        |    3 +-
 drivers/ata/sata_fsl.c        |    4 +-
 drivers/ata/sata_mv.c         |    3 +-
 drivers/ata/sata_nv.c         |   25 ++----
 drivers/ata/sata_promise.c    |   40 ++++-----
 drivers/ata/sata_qstor.c      |   13 +--
 drivers/ata/sata_sil24.c      |    6 +-
 drivers/ata/sata_sx4.c        |    4 +-
 drivers/scsi/ipr.c            |    3 +-
 drivers/scsi/libsas/sas_ata.c |   10 +--
 include/linux/libata.h        |   42 ++-------
 16 files changed, 193 insertions(+), 197 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a8fc9c0..6fb67ba 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1477,28 +1477,24 @@ static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
 {
 	struct scatterlist *sg;
-	struct ahci_sg *ahci_sg;
-	unsigned int n_sg = 0;
+	struct ahci_sg *ahci_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
+	unsigned int si;
 
 	VPRINTK("ENTER\n");
 
 	/*
 	 * Next, the S/G list.
 	 */
-	ahci_sg = cmd_tbl + AHCI_CMD_TBL_HDR_SZ;
-	ata_for_each_sg(sg, qc) {
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		dma_addr_t addr = sg_dma_address(sg);
 		u32 sg_len = sg_dma_len(sg);
 
-		ahci_sg->addr = cpu_to_le32(addr & 0xffffffff);
-		ahci_sg->addr_hi = cpu_to_le32((addr >> 16) >> 16);
-		ahci_sg->flags_size = cpu_to_le32(sg_len - 1);
-
-		ahci_sg++;
-		n_sg++;
+		ahci_sg[si].addr = cpu_to_le32(addr & 0xffffffff);
+		ahci_sg[si].addr_hi = cpu_to_le32((addr >> 16) >> 16);
+		ahci_sg[si].flags_size = cpu_to_le32(sg_len - 1);
 	}
 
-	return n_sg;
+	return si;
 }
 
 static void ahci_qc_prep(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1bc4edb..652c5c5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4480,13 +4480,13 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 void ata_sg_clean(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct scatterlist *sg = qc->__sg;
+	struct scatterlist *sg = qc->sg;
 	int dir = qc->dma_dir;
 	void *pad_buf = NULL;
 
 	WARN_ON(sg == NULL);
 
-	VPRINTK("unmapping %u sg elements\n", qc->n_elem);
+	VPRINTK("unmapping %u sg elements\n", qc->mapped_n_elem);
 
 	/* if we padded the buffer out to 32-bit bound, and data
 	 * xfer direction is from-device, we must copy from the
@@ -4495,19 +4495,20 @@ void ata_sg_clean(struct ata_queued_cmd *qc)
 	if (qc->pad_len && !(qc->tf.flags & ATA_TFLAG_WRITE))
 		pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
 
-	if (qc->n_elem)
-		dma_unmap_sg(ap->dev, sg, qc->n_elem, dir);
+	if (qc->mapped_n_elem)
+		dma_unmap_sg(ap->dev, sg, qc->mapped_n_elem, dir);
 	/* restore last sg */
-	sg_last(sg, qc->orig_n_elem)->length += qc->pad_len;
+	if (qc->last_sg)
+		*qc->last_sg = qc->saved_last_sg;
 	if (pad_buf) {
-		struct scatterlist *psg = &qc->pad_sgent;
+		struct scatterlist *psg = &qc->extra_sg[1];
 		void *addr = kmap_atomic(sg_page(psg), KM_IRQ0);
 		memcpy(addr + psg->offset, pad_buf, qc->pad_len);
 		kunmap_atomic(addr, KM_IRQ0);
 	}
 
 	qc->flags &= ~ATA_QCFLAG_DMAMAP;
-	qc->__sg = NULL;
+	qc->sg = NULL;
 }
 
 /**
@@ -4525,13 +4526,10 @@ static void ata_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg;
-	unsigned int idx;
+	unsigned int si, pi;
 
-	WARN_ON(qc->__sg == NULL);
-	WARN_ON(qc->n_elem == 0 && qc->pad_len == 0);
-
-	idx = 0;
-	ata_for_each_sg(sg, qc) {
+	pi = 0;
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		u32 addr, offset;
 		u32 sg_len, len;
 
@@ -4548,18 +4546,17 @@ static void ata_fill_sg(struct ata_queued_cmd *qc)
 			if ((offset + sg_len) > 0x10000)
 				len = 0x10000 - offset;
 
-			ap->prd[idx].addr = cpu_to_le32(addr);
-			ap->prd[idx].flags_len = cpu_to_le32(len & 0xffff);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
+			ap->prd[pi].addr = cpu_to_le32(addr);
+			ap->prd[pi].flags_len = cpu_to_le32(len & 0xffff);
+			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
 
-			idx++;
+			pi++;
 			sg_len -= len;
 			addr += len;
 		}
 	}
 
-	if (idx)
-		ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+	ap->prd[pi - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
 
 /**
@@ -4579,13 +4576,10 @@ static void ata_fill_sg_dumb(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg;
-	unsigned int idx;
-
-	WARN_ON(qc->__sg == NULL);
-	WARN_ON(qc->n_elem == 0 && qc->pad_len == 0);
+	unsigned int si, pi;
 
-	idx = 0;
-	ata_for_each_sg(sg, qc) {
+	pi = 0;
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		u32 addr, offset;
 		u32 sg_len, len, blen;
 
@@ -4603,25 +4597,24 @@ static void ata_fill_sg_dumb(struct ata_queued_cmd *qc)
 				len = 0x10000 - offset;
 
 			blen = len & 0xffff;
-			ap->prd[idx].addr = cpu_to_le32(addr);
+			ap->prd[pi].addr = cpu_to_le32(addr);
 			if (blen == 0) {
 			   /* Some PATA chipsets like the CS5530 can't
 			      cope with 0x0000 meaning 64K as the spec says */
-				ap->prd[idx].flags_len = cpu_to_le32(0x8000);
+				ap->prd[pi].flags_len = cpu_to_le32(0x8000);
 				blen = 0x8000;
-				ap->prd[++idx].addr = cpu_to_le32(addr + 0x8000);
+				ap->prd[++pi].addr = cpu_to_le32(addr + 0x8000);
 			}
-			ap->prd[idx].flags_len = cpu_to_le32(blen);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
+			ap->prd[pi].flags_len = cpu_to_le32(blen);
+			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", pi, addr, len);
 
-			idx++;
+			pi++;
 			sg_len -= len;
 			addr += len;
 		}
 	}
 
-	if (idx)
-		ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+	ap->prd[pi - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
 
 /**
@@ -4758,54 +4751,48 @@ void ata_noop_qc_prep(struct ata_queued_cmd *qc) { }
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem)
 {
-	qc->__sg = sg;
+	qc->sg = sg;
 	qc->n_elem = n_elem;
-	qc->orig_n_elem = n_elem;
-	qc->cursg = qc->__sg;
+	qc->cursg = qc->sg;
 }
 
-/**
- *	ata_sg_setup - DMA-map the scatter-gather table associated with a command.
- *	@qc: Command with scatter-gather table to be mapped.
- *
- *	DMA-map the scatter-gather table associated with queued_cmd @qc.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- *
- *	RETURNS:
- *	Zero on success, negative on error.
- *
- */
-
-static int ata_sg_setup(struct ata_queued_cmd *qc)
+static unsigned int ata_sg_setup_extra(struct ata_queued_cmd *qc,
+				       unsigned int *n_elem_extra)
 {
 	struct ata_port *ap = qc->ap;
-	struct scatterlist *sg = qc->__sg;
-	struct scatterlist *lsg = sg_last(qc->__sg, qc->n_elem);
-	int n_elem, pre_n_elem, dir, trim_sg = 0;
+	unsigned int n_elem = qc->n_elem;
+	struct scatterlist *lsg, *copy_lsg = NULL, *tsg = NULL, *esg = NULL;
 
-	VPRINTK("ENTER, ata%u\n", ap->print_id);
+	*n_elem_extra = 0;
+
+	/* needs padding? */
+	qc->pad_len = qc->nbytes & 3;
+
+	if (likely(!qc->pad_len))
+		return n_elem;
+
+	/* locate last sg and save it */
+	lsg = sg_last(qc->sg, n_elem);
+	qc->last_sg = lsg;
+	qc->saved_last_sg = *lsg;
+
+	sg_init_table(qc->extra_sg, ARRAY_SIZE(qc->extra_sg));
 
-	/* we must lengthen transfers to end on a 32-bit boundary */
-	qc->pad_len = lsg->length & 3;
 	if (qc->pad_len) {
+		struct scatterlist *psg = &qc->extra_sg[1];
 		void *pad_buf = ap->pad + (qc->tag * ATA_DMA_PAD_SZ);
-		struct scatterlist *psg = &qc->pad_sgent;
 		unsigned int offset;
 
 		WARN_ON(qc->dev->class != ATA_DEV_ATAPI);
 
 		memset(pad_buf, 0, ATA_DMA_PAD_SZ);
 
-		/*
-		 * psg->page/offset are used to copy to-be-written
+		/* psg->page/offset are used to copy to-be-written
 		 * data in this function or read data in ata_sg_clean.
 		 */
 		offset = lsg->offset + lsg->length - qc->pad_len;
-		sg_init_table(psg, 1);
 		sg_set_page(psg, nth_page(sg_page(lsg), offset >> PAGE_SHIFT),
-				qc->pad_len, offset_in_page(offset));
+			    qc->pad_len, offset_in_page(offset));
 
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
 			void *addr = kmap_atomic(sg_page(psg), KM_IRQ0);
@@ -4815,36 +4802,84 @@ static int ata_sg_setup(struct ata_queued_cmd *qc)
 
 		sg_dma_address(psg) = ap->pad_dma + (qc->tag * ATA_DMA_PAD_SZ);
 		sg_dma_len(psg) = ATA_DMA_PAD_SZ;
-		/* trim last sg */
+
+		/* Trim the last sg entry and chain the original and
+		 * padding sg lists.
+		 *
+		 * Because chaining consumes one sg entry, one extra
+		 * sg entry is allocated and the last sg entry is
+		 * copied to it if the length isn't zero after padded
+		 * amount is removed.
+		 *
+		 * If the last sg entry is completely replaced by
+		 * padding sg entry, the first sg entry is skipped
+		 * while chaining.
+		 */
 		lsg->length -= qc->pad_len;
-		if (lsg->length == 0)
-			trim_sg = 1;
+		if (lsg->length) {
+			copy_lsg = &qc->extra_sg[0];
+			tsg = &qc->extra_sg[0];
+		} else {
+			n_elem--;
+			tsg = &qc->extra_sg[1];
+		}
+
+		esg = &qc->extra_sg[1];
 
-		DPRINTK("padding done, sg[%d].length=%u pad_len=%u\n",
-			qc->n_elem - 1, lsg->length, qc->pad_len);
+		(*n_elem_extra)++;
 	}
 
-	pre_n_elem = qc->n_elem;
-	if (trim_sg && pre_n_elem)
-		pre_n_elem--;
+	if (copy_lsg)
+		sg_set_page(copy_lsg, sg_page(lsg), lsg->length, lsg->offset);
 
-	if (!pre_n_elem) {
-		n_elem = 0;
-		goto skip_map;
+	sg_chain(lsg, 1, tsg);
+	sg_mark_end(esg);
+
+	/* sglist can't start with chaining sg entry, fast forward */
+	if (qc->sg == lsg) {
+		qc->sg = tsg;
+		qc->cursg = tsg;
 	}
 
-	dir = qc->dma_dir;
-	n_elem = dma_map_sg(ap->dev, sg, pre_n_elem, dir);
-	if (n_elem < 1) {
-		/* restore last sg */
-		lsg->length += qc->pad_len;
-		return -1;
+	return n_elem;
+}
+
+/**
+ *	ata_sg_setup - DMA-map the scatter-gather table associated with a command.
+ *	@qc: Command with scatter-gather table to be mapped.
+ *
+ *	DMA-map the scatter-gather table associated with queued_cmd @qc.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	Zero on success, negative on error.
+ *
+ */
+static int ata_sg_setup(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned int n_elem, n_elem_extra;
+
+	VPRINTK("ENTER, ata%u\n", ap->print_id);
+
+	n_elem = ata_sg_setup_extra(qc, &n_elem_extra);
+
+	if (n_elem) {
+		n_elem = dma_map_sg(ap->dev, qc->sg, n_elem, qc->dma_dir);
+		if (n_elem < 1) {
+			/* restore last sg */
+			if (qc->last_sg)
+				*qc->last_sg = qc->saved_last_sg;
+			return -1;
+		}
+		DPRINTK("%d sg elements mapped\n", n_elem);
 	}
 
-	DPRINTK("%d sg elements mapped\n", n_elem);
+	qc->n_elem = qc->mapped_n_elem = n_elem;
+	qc->n_elem += n_elem_extra;
 
-skip_map:
-	qc->n_elem = n_elem;
 	qc->flags |= ATA_QCFLAG_DMAMAP;
 
 	return 0;
@@ -5909,7 +5944,7 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	/* We guarantee to LLDs that they will have at least one
 	 * non-zero sg if the command is a data command.
 	 */
-	BUG_ON(ata_is_data(prot) && (!qc->__sg || !qc->n_elem || !qc->nbytes));
+	BUG_ON(ata_is_data(prot) && (!qc->sg || !qc->n_elem || !qc->nbytes));
 
 	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
 				 (ap->flags & ATA_FLAG_PIO_DMA)))
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 6251caa..f523e66 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -517,7 +517,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
 		qc->scsicmd = cmd;
 		qc->scsidone = done;
 
-		qc->__sg = scsi_sglist(cmd);
+		qc->sg = scsi_sglist(cmd);
 		qc->n_elem = scsi_sg_count(cmd);
 	} else {
 		cmd->result = (DID_OK << 16) | (QUEUE_FULL << 1);
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 53ae7d3..d00d219 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -832,6 +832,7 @@ static void bfin_bmdma_setup(struct ata_queued_cmd *qc)
 {
 	unsigned short config = WDSIZE_16;
 	struct scatterlist *sg;
+	unsigned int si;
 
 	pr_debug("in atapi dma setup\n");
 	/* Program the ATA_CTRL register with dir */
@@ -839,7 +840,7 @@ static void bfin_bmdma_setup(struct ata_queued_cmd *qc)
 		/* fill the ATAPI DMA controller */
 		set_dma_config(CH_ATAPI_TX, config);
 		set_dma_x_modify(CH_ATAPI_TX, 2);
-		ata_for_each_sg(sg, qc) {
+		for_each_sg(qc->sg, sg, qc->n_elem, si) {
 			set_dma_start_addr(CH_ATAPI_TX, sg_dma_address(sg));
 			set_dma_x_count(CH_ATAPI_TX, sg_dma_len(sg) >> 1);
 		}
@@ -848,7 +849,7 @@ static void bfin_bmdma_setup(struct ata_queued_cmd *qc)
 		/* fill the ATAPI DMA controller */
 		set_dma_config(CH_ATAPI_RX, config);
 		set_dma_x_modify(CH_ATAPI_RX, 2);
-		ata_for_each_sg(sg, qc) {
+		for_each_sg(qc->sg, sg, qc->n_elem, si) {
 			set_dma_start_addr(CH_ATAPI_RX, sg_dma_address(sg));
 			set_dma_x_count(CH_ATAPI_RX, sg_dma_len(sg) >> 1);
 		}
@@ -867,6 +868,7 @@ static void bfin_bmdma_start(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
 	struct scatterlist *sg;
+	unsigned int si;
 
 	pr_debug("in atapi dma start\n");
 	if (!(ap->udma_mask || ap->mwdma_mask))
@@ -881,7 +883,7 @@ static void bfin_bmdma_start(struct ata_queued_cmd *qc)
 		 * data cache is enabled. Otherwise, this loop
 		 * is an empty loop and optimized out.
 		 */
-		ata_for_each_sg(sg, qc) {
+		for_each_sg(qc->sg, sg, qc->n_elem, si) {
 			flush_dcache_range(sg_dma_address(sg),
 				sg_dma_address(sg) + sg_dma_len(sg));
 		}
@@ -910,7 +912,7 @@ static void bfin_bmdma_start(struct ata_queued_cmd *qc)
 	ATAPI_SET_CONTROL(base, ATAPI_GET_CONTROL(base) | TFRCNT_RST);
 
 		/* Set transfer length to buffer len */
-	ata_for_each_sg(sg, qc) {
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		ATAPI_SET_XFER_LEN(base, (sg_dma_len(sg) >> 1));
 	}
 
@@ -932,6 +934,7 @@ static void bfin_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg;
+	unsigned int si;
 
 	pr_debug("in atapi dma stop\n");
 	if (!(ap->udma_mask || ap->mwdma_mask))
@@ -950,7 +953,7 @@ static void bfin_bmdma_stop(struct ata_queued_cmd *qc)
 			 * data cache is enabled. Otherwise, this loop
 			 * is an empty loop and optimized out.
 			 */
-			ata_for_each_sg(sg, qc) {
+			for_each_sg(qc->sg, sg, qc->n_elem, si) {
 				invalidate_dcache_range(
 					sg_dma_address(sg),
 					sg_dma_address(sg)
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index 842fe08..5b8586d 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -224,6 +224,7 @@ static void pata_icside_bmdma_setup(struct ata_queued_cmd *qc)
 	struct pata_icside_state *state = ap->host->private_data;
 	struct scatterlist *sg, *rsg = state->sg;
 	unsigned int write = qc->tf.flags & ATA_TFLAG_WRITE;
+	unsigned int si;
 
 	/*
 	 * We are simplex; BUG if we try to fiddle with DMA
@@ -234,7 +235,7 @@ static void pata_icside_bmdma_setup(struct ata_queued_cmd *qc)
 	/*
 	 * Copy ATAs scattered sg list into a contiguous array of sg
 	 */
-	ata_for_each_sg(sg, qc) {
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		memcpy(rsg, sg, sizeof(*sg));
 		rsg++;
 	}
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 459cb7b..8e1b7e9 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -321,8 +321,9 @@ static int adma_fill_sg(struct ata_queued_cmd *qc)
 	u8  *buf = pp->pkt, *last_buf = NULL;
 	int i = (2 + buf[3]) * 8;
 	u8 pFLAGS = pORD | ((qc->tf.flags & ATA_TFLAG_WRITE) ? pDIRO : 0);
+	unsigned int si;
 
-	ata_for_each_sg(sg, qc) {
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		u32 addr;
 		u32 len;
 
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index a3c33f1..d041709 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -323,6 +323,7 @@ static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
 	struct scatterlist *sg;
 	unsigned int num_prde = 0;
 	u32 ttl_dwords = 0;
+	unsigned int si;
 
 	/*
 	 * NOTE : direct & indirect prdt's are contigiously allocated
@@ -333,13 +334,14 @@ static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
 	struct prde *prd_ptr_to_indirect_ext = NULL;
 	unsigned indirect_ext_segment_sz = 0;
 	dma_addr_t indirect_ext_segment_paddr;
+	unsigned int si;
 
 	VPRINTK("SATA FSL : cd = 0x%x, prd = 0x%x\n", cmd_desc, prd);
 
 	indirect_ext_segment_paddr = cmd_desc_paddr +
 	    SATA_FSL_CMD_DESC_OFFSET_TO_PRDT + SATA_FSL_MAX_PRD_DIRECT * 16;
 
-	ata_for_each_sg(sg, qc) {
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		dma_addr_t sg_addr = sg_dma_address(sg);
 		u32 sg_len = sg_dma_len(sg);
 
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index a43f64d..503d3d4 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1127,9 +1127,10 @@ static void mv_fill_sg(struct ata_queued_cmd *qc)
 	struct mv_port_priv *pp = qc->ap->private_data;
 	struct scatterlist *sg;
 	struct mv_sg *mv_sg, *last_sg = NULL;
+	unsigned int si;
 
 	mv_sg = pp->sg_tbl;
-	ata_for_each_sg(sg, qc) {
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		dma_addr_t addr = sg_dma_address(sg);
 		u32 sg_len = sg_dma_len(sg);
 
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 44f9e5d..b7b5945 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1334,21 +1334,18 @@ static void nv_adma_fill_aprd(struct ata_queued_cmd *qc,
 static void nv_adma_fill_sg(struct ata_queued_cmd *qc, struct nv_adma_cpb *cpb)
 {
 	struct nv_adma_port_priv *pp = qc->ap->private_data;
-	unsigned int idx;
 	struct nv_adma_prd *aprd;
 	struct scatterlist *sg;
+	unsigned int si;
 
 	VPRINTK("ENTER\n");
 
-	idx = 0;
-
-	ata_for_each_sg(sg, qc) {
-		aprd = (idx < 5) ? &cpb->aprd[idx] :
-			       &pp->aprd[NV_ADMA_SGTBL_LEN * qc->tag + (idx-5)];
-		nv_adma_fill_aprd(qc, sg, idx, aprd);
-		idx++;
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
+		aprd = (si < 5) ? &cpb->aprd[si] :
+			       &pp->aprd[NV_ADMA_SGTBL_LEN * qc->tag + (si-5)];
+		nv_adma_fill_aprd(qc, sg, si, aprd);
 	}
-	if (idx > 5)
+	if (si > 5)
 		cpb->next_aprd = cpu_to_le64(((u64)(pp->aprd_dma + NV_ADMA_SGTBL_SZ * qc->tag)));
 	else
 		cpb->next_aprd = cpu_to_le64(0);
@@ -1981,17 +1978,14 @@ static void nv_swncq_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg;
-	unsigned int idx;
 	struct nv_swncq_port_priv *pp = ap->private_data;
 	struct ata_prd *prd;
-
-	WARN_ON(qc->__sg == NULL);
-	WARN_ON(qc->n_elem == 0 && qc->pad_len == 0);
+	unsigned int si, idx;
 
 	prd = pp->prd + ATA_MAX_PRD * qc->tag;
 
 	idx = 0;
-	ata_for_each_sg(sg, qc) {
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		u32 addr, offset;
 		u32 sg_len, len;
 
@@ -2013,8 +2007,7 @@ static void nv_swncq_fill_sg(struct ata_queued_cmd *qc)
 		}
 	}
 
-	if (idx)
-		prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+	prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
 
 static unsigned int nv_swncq_issue_atacmd(struct ata_port *ap,
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 25b34d6..2ab20a2 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -541,17 +541,15 @@ static void pdc_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct scatterlist *sg;
-	unsigned int idx;
 	const u32 SG_COUNT_ASIC_BUG = 41*4;
+	unsigned int si, idx;
+	u32 len;
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;
 
-	WARN_ON(qc->__sg == NULL);
-	WARN_ON(qc->n_elem == 0 && qc->pad_len == 0);
-
 	idx = 0;
-	ata_for_each_sg(sg, qc) {
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		u32 addr, offset;
 		u32 sg_len, len;
 
@@ -578,29 +576,27 @@ static void pdc_fill_sg(struct ata_queued_cmd *qc)
 		}
 	}
 
-	if (idx) {
-		u32 len = le32_to_cpu(ap->prd[idx - 1].flags_len);
+	len = le32_to_cpu(ap->prd[idx - 1].flags_len);
 
-		if (len > SG_COUNT_ASIC_BUG) {
-			u32 addr;
+	if (len > SG_COUNT_ASIC_BUG) {
+		u32 addr;
 
-			VPRINTK("Splitting last PRD.\n");
+		VPRINTK("Splitting last PRD.\n");
 
-			addr = le32_to_cpu(ap->prd[idx - 1].addr);
-			ap->prd[idx - 1].flags_len = cpu_to_le32(len - SG_COUNT_ASIC_BUG);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx - 1, addr, SG_COUNT_ASIC_BUG);
+		addr = le32_to_cpu(ap->prd[idx - 1].addr);
+		ap->prd[idx - 1].flags_len = cpu_to_le32(len - SG_COUNT_ASIC_BUG);
+		VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx - 1, addr, SG_COUNT_ASIC_BUG);
 
-			addr = addr + len - SG_COUNT_ASIC_BUG;
-			len = SG_COUNT_ASIC_BUG;
-			ap->prd[idx].addr = cpu_to_le32(addr);
-			ap->prd[idx].flags_len = cpu_to_le32(len);
-			VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
+		addr = addr + len - SG_COUNT_ASIC_BUG;
+		len = SG_COUNT_ASIC_BUG;
+		ap->prd[idx].addr = cpu_to_le32(addr);
+		ap->prd[idx].flags_len = cpu_to_le32(len);
+		VPRINTK("PRD[%u] = (0x%X, 0x%X)\n", idx, addr, len);
 
-			idx++;
-		}
-
-		ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
+		idx++;
 	}
+
+	ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
 
 static void pdc_qc_prep(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 2875549..c55ab77 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -287,14 +287,10 @@ static unsigned int qs_fill_sg(struct ata_queued_cmd *qc)
 	struct scatterlist *sg;
 	struct ata_port *ap = qc->ap;
 	struct qs_port_priv *pp = ap->private_data;
-	unsigned int nelem;
 	u8 *prd = pp->pkt + QS_CPB_BYTES;
+	unsigned int si;
 
-	WARN_ON(qc->__sg == NULL);
-	WARN_ON(qc->n_elem == 0 && qc->pad_len == 0);
-
-	nelem = 0;
-	ata_for_each_sg(sg, qc) {
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		u64 addr;
 		u32 len;
 
@@ -306,12 +302,11 @@ static unsigned int qs_fill_sg(struct ata_queued_cmd *qc)
 		*(__le32 *)prd = cpu_to_le32(len);
 		prd += sizeof(u64);
 
-		VPRINTK("PRD[%u] = (0x%llX, 0x%X)\n", nelem,
+		VPRINTK("PRD[%u] = (0x%llX, 0x%X)\n", si,
 					(unsigned long long)addr, len);
-		nelem++;
 	}
 
-	return nelem;
+	return si;
 }
 
 static void qs_qc_prep(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 4f25209..b3c4f44 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -813,8 +813,9 @@ static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
 {
 	struct scatterlist *sg;
 	struct sil24_sge *last_sge = NULL;
+	unsigned int si;
 
-	ata_for_each_sg(sg, qc) {
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		sge->addr = cpu_to_le64(sg_dma_address(sg));
 		sge->cnt = cpu_to_le32(sg_dma_len(sg));
 		sge->flags = 0;
@@ -823,8 +824,7 @@ static inline void sil24_fill_sg(struct ata_queued_cmd *qc,
 		sge++;
 	}
 
-	if (likely(last_sge))
-		last_sge->flags = cpu_to_le32(SGE_TRM);
+	last_sge->flags = cpu_to_le32(SGE_TRM);
 }
 
 static int sil24_qc_defer(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 3de0c27..211ba8d 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -473,7 +473,7 @@ static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 	void __iomem *mmio = ap->host->iomap[PDC_MMIO_BAR];
 	void __iomem *dimm_mmio = ap->host->iomap[PDC_DIMM_BAR];
 	unsigned int portno = ap->port_no;
-	unsigned int i, idx, total_len = 0, sgt_len;
+	unsigned int i, si, idx, total_len = 0, sgt_len;
 	u32 *buf = (u32 *) &pp->dimm_buf[PDC_DIMM_HEADER_SZ];
 
 	WARN_ON(!(qc->flags & ATA_QCFLAG_DMAMAP));
@@ -487,7 +487,7 @@ static void pdc20621_dma_prep(struct ata_queued_cmd *qc)
 	 * Build S/G table
 	 */
 	idx = 0;
-	ata_for_each_sg(sg, qc) {
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		buf[idx++] = cpu_to_le32(sg_dma_address(sg));
 		buf[idx++] = cpu_to_le32(sg_dma_len(sg));
 		total_len += sg_dma_len(sg);
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 3e78bc2..aa0df0a 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -5142,6 +5142,7 @@ static void ipr_build_ata_ioadl(struct ipr_cmnd *ipr_cmd,
 	struct ipr_ioadl_desc *last_ioadl = NULL;
 	int len = qc->nbytes + qc->pad_len;
 	struct scatterlist *sg;
+	unsigned int si;
 
 	if (len == 0)
 		return;
@@ -5159,7 +5160,7 @@ static void ipr_build_ata_ioadl(struct ipr_cmnd *ipr_cmd,
 			cpu_to_be32(sizeof(struct ipr_ioadl_desc) * ipr_cmd->dma_use_sg);
 	}
 
-	ata_for_each_sg(sg, qc) {
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
 		ioadl->flags_and_data_len = cpu_to_be32(ioadl_flags | sg_dma_len(sg));
 		ioadl->address = cpu_to_be32(sg_dma_address(sg));
 
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index f78d060..827cfb1 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -158,8 +158,8 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 	struct Scsi_Host *host = sas_ha->core.shost;
 	struct sas_internal *i = to_sas_internal(host->transportt);
 	struct scatterlist *sg;
-	unsigned int num = 0;
 	unsigned int xfer = 0;
+	unsigned int si;
 
 	task = sas_alloc_task(GFP_ATOMIC);
 	if (!task)
@@ -181,17 +181,15 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 		task->total_xfer_len = qc->nbytes + qc->pad_len;
 		task->num_scatter = qc->pad_len ? qc->n_elem + 1 : qc->n_elem;
 	} else {
-		ata_for_each_sg(sg, qc) {
-			num++;
+		for_each_sg(qc->sg, sg, qc->n_elem, si)
 			xfer += sg->length;
-		}
 
 		task->total_xfer_len = xfer;
-		task->num_scatter = num;
+		task->num_scatter = si;
 	}
 
 	task->data_dir = qc->dma_dir;
-	task->scatter = qc->__sg;
+	task->scatter = qc->sg;
 	task->ata_task.retry_count = 1;
 	task->task_state_flags = SAS_TASK_STATE_PENDING;
 	qc->lldd_task = task;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6869900..7bd1cc2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -459,7 +459,7 @@ struct ata_queued_cmd {
 	unsigned int		tag;
 	unsigned int		n_elem;
 	unsigned int		n_iter;
-	unsigned int		orig_n_elem;
+	unsigned int		mapped_n_elem;
 
 	int			dma_dir;
 
@@ -472,11 +472,12 @@ struct ata_queued_cmd {
 	struct scatterlist	*cursg;
 	unsigned int		cursg_ofs;
 
+	struct scatterlist	*last_sg;
+	struct scatterlist	saved_last_sg;
 	struct scatterlist	sgent;
-	struct scatterlist	pad_sgent;
+	struct scatterlist	extra_sg[2];
 
-	/* DO NOT iterate over __sg manually, use ata_for_each_sg() */
-	struct scatterlist	*__sg;
+	struct scatterlist	*sg;
 
 	unsigned int		err_mask;
 	struct ata_taskfile	result_tf;
@@ -1124,35 +1125,6 @@ extern void ata_port_pbar_desc(struct ata_port *ap, int bar, ssize_t offset,
 			       const char *name);
 #endif
 
-/*
- * qc helpers
- */
-static inline struct scatterlist *
-ata_qc_first_sg(struct ata_queued_cmd *qc)
-{
-	qc->n_iter = 0;
-	if (qc->n_elem)
-		return qc->__sg;
-	if (qc->pad_len)
-		return &qc->pad_sgent;
-	return NULL;
-}
-
-static inline struct scatterlist *
-ata_qc_next_sg(struct scatterlist *sg, struct ata_queued_cmd *qc)
-{
-	if (sg == &qc->pad_sgent)
-		return NULL;
-	if (++qc->n_iter < qc->n_elem)
-		return sg_next(sg);
-	if (qc->pad_len)
-		return &qc->pad_sgent;
-	return NULL;
-}
-
-#define ata_for_each_sg(sg, qc) \
-	for (sg = ata_qc_first_sg(qc); sg; sg = ata_qc_next_sg(sg, qc))
-
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
@@ -1387,15 +1359,17 @@ static inline void ata_tf_init(struct ata_device *dev, struct ata_taskfile *tf)
 static inline void ata_qc_reinit(struct ata_queued_cmd *qc)
 {
 	qc->dma_dir = DMA_NONE;
-	qc->__sg = NULL;
+	qc->sg = NULL;
 	qc->flags = 0;
 	qc->cursg = NULL;
 	qc->cursg_ofs = 0;
 	qc->nbytes = qc->curbytes = 0;
 	qc->n_elem = 0;
+	qc->mapped_n_elem = 0;
 	qc->n_iter = 0;
 	qc->err_mask = 0;
 	qc->pad_len = 0;
+	qc->last_sg = NULL;
 	qc->sect_size = ATA_SECT_SIZE;
 
 	ata_tf_init(qc->dev, &qc->tf);
-- 
1.5.2.4

