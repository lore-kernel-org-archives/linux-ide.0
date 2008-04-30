From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/10] sata_inic162x: use IDMA for ATA_PROT_DMA
Date: Wed, 30 Apr 2008 16:35:11 +0900
Message-ID: <12095409181733-git-send-email-htejun@gmail.com>
References: <12095409172824-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:39296 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493AbYD3Hf0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 03:35:26 -0400
Received: by py-out-1112.google.com with SMTP id u52so616515pyb.10
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 00:35:26 -0700 (PDT)
In-Reply-To: <12095409172824-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

The modified driver on initio site has enough clue on how to use IDMA.
Use IDMA for ATA_PROT_DMA.

* LBA48 now works as long as it uses DMA (LBA48 devices still aren't
  allowed as it can destroy data if PIO is used for any reason).

* No need to mask IRQs for read DMAs as IDMA_DONE is properly raised
  after transfer to memory is actually completed.  There will be some
  spurious interrupts but host_intr will handle it correctly and
  manipulating port IRQ mask interacts badly with the other port for
  some reason, so command type dependent port IRQ masking is not used
  anymore.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_inic162x.c |  270 +++++++++++++++++++++++++++++++++++++------
 1 files changed, 235 insertions(+), 35 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index db669f2..1f105fe 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -35,6 +35,10 @@ enum {
 
 	NR_PORTS		= 2,
 
+	IDMA_CPB_TBL_SIZE	= 4 * 32,
+
+	INIC_DMA_BOUNDARY	= 0xffffff,
+
 	HOST_ACTRL		= 0x08,
 	HOST_CTL		= 0x7c,
 	HOST_STAT		= 0x7e,
@@ -151,11 +155,57 @@ enum {
 	PRD_END			= (1 << 7),  /* APRD chain end */
 };
 
+/* Comman Parameter Block */
+struct inic_cpb {
+	u8		resp_flags;	/* Response Flags */
+	u8		error;		/* ATA Error */
+	u8		status;		/* ATA Status */
+	u8		ctl_flags;	/* Control Flags */
+	__le32		len;		/* Total Transfer Length */
+	__le32		prd;		/* First PRD pointer */
+	u8		rsvd[4];
+	/* 16 bytes */
+	u8		feature;	/* ATA Feature */
+	u8		hob_feature;	/* ATA Ex. Feature */
+	u8		device;		/* ATA Device/Head */
+	u8		mirctl;		/* Mirror Control */
+	u8		nsect;		/* ATA Sector Count */
+	u8		hob_nsect;	/* ATA Ex. Sector Count */
+	u8		lbal;		/* ATA Sector Number */
+	u8		hob_lbal;	/* ATA Ex. Sector Number */
+	u8		lbam;		/* ATA Cylinder Low */
+	u8		hob_lbam;	/* ATA Ex. Cylinder Low */
+	u8		lbah;		/* ATA Cylinder High */
+	u8		hob_lbah;	/* ATA Ex. Cylinder High */
+	u8		command;	/* ATA Command */
+	u8		ctl;		/* ATA Control */
+	u8		slave_error;	/* Slave ATA Error */
+	u8		slave_status;	/* Slave ATA Status */
+	/* 32 bytes */
+} __packed;
+
+/* Physical Region Descriptor */
+struct inic_prd {
+	__le32		mad;		/* Physical Memory Address */
+	__le16		len;		/* Transfer Length */
+	u8		rsvd;
+	u8		flags;		/* Control Flags */
+} __packed;
+
+struct inic_pkt {
+	struct inic_cpb	cpb;
+	struct inic_prd	prd[LIBATA_MAX_PRD];
+} __packed;
+
 struct inic_host_priv {
 	u16		cached_hctl;
 };
 
 struct inic_port_priv {
+	struct inic_pkt	*pkt;
+	dma_addr_t	pkt_dma;
+	u32		*cpb_tbl;
+	dma_addr_t	cpb_tbl_dma;
 	u8		dfl_prdctl;
 	u8		cached_prdctl;
 	u8		cached_pirq_mask;
@@ -163,6 +213,7 @@ struct inic_port_priv {
 
 static struct scsi_host_template inic_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
+	.dma_boundary	= INIC_DMA_BOUNDARY,
 };
 
 static const int scr_map[] = {
@@ -303,42 +354,112 @@ static u8 inic_bmdma_status(struct ata_port *ap)
 	return ATA_DMA_INTR;
 }
 
-static void inic_host_intr(struct ata_port *ap)
+static void inic_stop_idma(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
+
+	readb(port_base + PORT_RPQ_FIFO);
+	readb(port_base + PORT_RPQ_CNT);
+	writew(0, port_base + PORT_IDMA_CTL);
+}
+
+static void inic_host_err_intr(struct ata_port *ap, u8 irq_stat, u16 idma_stat)
+{
 	struct ata_eh_info *ehi = &ap->link.eh_info;
+	struct inic_port_priv *pp = ap->private_data;
+	struct inic_cpb *cpb = &pp->pkt->cpb;
+	bool freeze = false;
+
+	ata_ehi_clear_desc(ehi);
+	ata_ehi_push_desc(ehi, "irq_stat=0x%x idma_stat=0x%x",
+			  irq_stat, idma_stat);
+
+	inic_stop_idma(ap);
+
+	if (irq_stat & (PIRQ_OFFLINE | PIRQ_ONLINE)) {
+		ata_ehi_push_desc(ehi, "hotplug");
+		ata_ehi_hotplugged(ehi);
+		freeze = true;
+	}
+
+	if (idma_stat & IDMA_STAT_PERR) {
+		ata_ehi_push_desc(ehi, "PCI error");
+		freeze = true;
+	}
+
+	if (idma_stat & IDMA_STAT_CPBERR) {
+		ata_ehi_push_desc(ehi, "CPB error");
+
+		if (cpb->resp_flags & CPB_RESP_IGNORED) {
+			__ata_ehi_push_desc(ehi, " ignored");
+			ehi->err_mask |= AC_ERR_INVALID;
+			freeze = true;
+		}
+
+		if (cpb->resp_flags & CPB_RESP_ATA_ERR)
+			ehi->err_mask |= AC_ERR_DEV;
+
+		if (cpb->resp_flags & CPB_RESP_SPURIOUS) {
+			__ata_ehi_push_desc(ehi, " spurious-intr");
+			ehi->err_mask |= AC_ERR_HSM;
+			freeze = true;
+		}
+
+		if (cpb->resp_flags &
+		    (CPB_RESP_UNDERFLOW | CPB_RESP_OVERFLOW)) {
+			__ata_ehi_push_desc(ehi, " data-over/underflow");
+			ehi->err_mask |= AC_ERR_HSM;
+			freeze = true;
+		}
+	}
+
+	if (freeze)
+		ata_port_freeze(ap);
+	else
+		ata_port_abort(ap);
+}
+
+static void inic_host_intr(struct ata_port *ap)
+{
+	void __iomem *port_base = inic_port_base(ap);
+	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->link.active_tag);
 	u8 irq_stat;
+	u16 idma_stat;
 
-	/* fetch and clear irq */
+	/* read and clear IRQ status */
 	irq_stat = readb(port_base + PORT_IRQ_STAT);
 	writeb(irq_stat, port_base + PORT_IRQ_STAT);
+	idma_stat = readw(port_base + PORT_IDMA_STAT);
+
+	if (unlikely((irq_stat & PIRQ_ERR) || (idma_stat & IDMA_STAT_ERR)))
+		inic_host_err_intr(ap, irq_stat, idma_stat);
+
+	if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
+		ap->ops->sff_check_status(ap); /* clear ATA interrupt */
+		goto spurious;
+	}
+
+	if (qc->tf.protocol == ATA_PROT_DMA) {
+		if (likely(idma_stat & IDMA_STAT_DONE)) {
+			inic_stop_idma(ap);
 
-	if (likely(!(irq_stat & PIRQ_ERR))) {
-		struct ata_queued_cmd *qc =
-			ata_qc_from_tag(ap, ap->link.active_tag);
+			/* Depending on circumstances, device error
+			 * isn't reported by IDMA, check it explicitly.
+			 */
+			if (unlikely(readb(port_base + PORT_TF_COMMAND) &
+				     (ATA_DF | ATA_ERR)))
+				qc->err_mask |= AC_ERR_DEV;
 
-		if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
-			ap->ops->sff_check_status(ap); /* clear ATA interrupt */
+			ata_qc_complete(qc);
 			return;
 		}
-
+	} else {
 		if (likely(ata_sff_host_intr(ap, qc)))
 			return;
-
-		ap->ops->sff_check_status(ap); /* clear ATA interrupt */
-		ata_port_printk(ap, KERN_WARNING, "unhandled "
-				"interrupt, irq_stat=%x\n", irq_stat);
-		return;
 	}
 
-	/* error */
-	ata_ehi_push_desc(ehi, "irq_stat=0x%x", irq_stat);
-
-	if (irq_stat & (PIRQ_OFFLINE | PIRQ_ONLINE)) {
-		ata_ehi_hotplugged(ehi);
-		ata_port_freeze(ap);
-	} else
-		ata_port_abort(ap);
+ spurious:
+	ap->ops->sff_check_status(ap); /* clear ATA interrupt */
 }
 
 static irqreturn_t inic_interrupt(int irq, void *dev_instance)
@@ -378,22 +499,83 @@ static irqreturn_t inic_interrupt(int irq, void *dev_instance)
 	return IRQ_RETVAL(handled);
 }
 
+static void inic_fill_sg(struct inic_prd *prd, struct ata_queued_cmd *qc)
+{
+	struct scatterlist *sg;
+	unsigned int si;
+	u8 flags = PRD_DMA;
+
+	if (qc->tf.flags & ATA_TFLAG_WRITE)
+		flags |= PRD_WRITE;
+
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
+		prd->mad = cpu_to_le32(sg_dma_address(sg));
+		prd->len = cpu_to_le16(sg_dma_len(sg));
+		prd->flags = flags;
+		prd++;
+	}
+
+	WARN_ON(!si);
+	prd[-1].flags |= PRD_END;
+}
+
+static void inic_qc_prep(struct ata_queued_cmd *qc)
+{
+	struct inic_port_priv *pp = qc->ap->private_data;
+	struct inic_pkt *pkt = pp->pkt;
+	struct inic_cpb *cpb = &pkt->cpb;
+	struct inic_prd *prd = pkt->prd;
+
+	VPRINTK("ENTER\n");
+
+	if (qc->tf.protocol != ATA_PROT_DMA)
+		return;
+
+	/* prepare packet, based on initio driver */
+	memset(pkt, 0, sizeof(struct inic_pkt));
+
+	cpb->ctl_flags = CPB_CTL_VALID | CPB_CTL_IEN | CPB_CTL_DATA;
+
+	cpb->len = cpu_to_le32(qc->nbytes);
+	cpb->prd = cpu_to_le32(pp->pkt_dma + offsetof(struct inic_pkt, prd));
+
+	cpb->device = qc->tf.device;
+	cpb->feature = qc->tf.feature;
+	cpb->nsect = qc->tf.nsect;
+	cpb->lbal = qc->tf.lbal;
+	cpb->lbam = qc->tf.lbam;
+	cpb->lbah = qc->tf.lbah;
+
+	if (qc->tf.flags & ATA_TFLAG_LBA48) {
+		cpb->hob_feature = qc->tf.hob_feature;
+		cpb->hob_nsect = qc->tf.hob_nsect;
+		cpb->hob_lbal = qc->tf.hob_lbal;
+		cpb->hob_lbam = qc->tf.hob_lbam;
+		cpb->hob_lbah = qc->tf.hob_lbah;
+	}
+
+	cpb->command = qc->tf.command;
+	/* don't load ctl - dunno why.  it's like that in the initio driver */
+
+	/* setup sg table */
+	inic_fill_sg(prd, qc);
+
+	pp->cpb_tbl[0] = pp->pkt_dma;
+}
+
 static unsigned int inic_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	void __iomem *port_base = inic_port_base(ap);
 
-	/* ATA IRQ doesn't wait for DMA transfer completion and vice
-	 * versa.  Mask IRQ selectively to detect command completion.
-	 * Without it, ATA DMA read command can cause data corruption.
-	 *
-	 * Something similar might be needed for ATAPI writes.  I
-	 * tried a lot of combinations but couldn't find the solution.
-	 */
-	if (qc->tf.protocol == ATA_PROT_DMA &&
-	    !(qc->tf.flags & ATA_TFLAG_WRITE))
-		inic_set_pirq_mask(ap, PIRQ_MASK_DMA_READ);
-	else
-		inic_set_pirq_mask(ap, PIRQ_MASK_OTHER);
+	if (qc->tf.protocol == ATA_PROT_DMA) {
+		/* fire up the ADMA engine */
+		writew(HCTL_FTHD0, port_base + HOST_CTL);
+		writew(IDMA_CTL_GO, port_base + PORT_IDMA_CTL);
+		writeb(0, port_base + PORT_CPB_PTQFIFO);
+
+		return 0;
+	}
 
 	/* Issuing a command to yet uninitialized port locks up the
 	 * controller.  Most of the time, this happens for the first
@@ -570,9 +752,15 @@ static void inic_dev_config(struct ata_device *dev)
 static void init_port(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
+	struct inic_port_priv *pp = ap->private_data;
 
-	/* Setup PRD address */
+	/* clear packet and CPB table */
+	memset(pp->pkt, 0, sizeof(struct inic_pkt));
+	memset(pp->cpb_tbl, 0, IDMA_CPB_TBL_SIZE);
+
+	/* setup PRD and CPB lookup table addresses */
 	writel(ap->prd_dma, port_base + PORT_PRD_ADDR);
+	writel(pp->cpb_tbl_dma, port_base + PORT_CPB_CPBLAR);
 }
 
 static int inic_port_resume(struct ata_port *ap)
@@ -584,12 +772,13 @@ static int inic_port_resume(struct ata_port *ap)
 static int inic_port_start(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
+	struct device *dev = ap->host->dev;
 	struct inic_port_priv *pp;
 	u8 tmp;
 	int rc;
 
 	/* alloc and initialize private data */
-	pp = devm_kzalloc(ap->host->dev, sizeof(*pp), GFP_KERNEL);
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
 	if (!pp)
 		return -ENOMEM;
 	ap->private_data = pp;
@@ -604,6 +793,16 @@ static int inic_port_start(struct ata_port *ap)
 	if (rc)
 		return rc;
 
+	pp->pkt = dmam_alloc_coherent(dev, sizeof(struct inic_pkt),
+				      &pp->pkt_dma, GFP_KERNEL);
+	if (!pp->pkt)
+		return -ENOMEM;
+
+	pp->cpb_tbl = dmam_alloc_coherent(dev, IDMA_CPB_TBL_SIZE,
+					  &pp->cpb_tbl_dma, GFP_KERNEL);
+	if (!pp->cpb_tbl)
+		return -ENOMEM;
+
 	init_port(ap);
 
 	return 0;
@@ -616,6 +815,7 @@ static struct ata_port_operations inic_port_ops = {
 	.bmdma_start		= inic_bmdma_start,
 	.bmdma_stop		= inic_bmdma_stop,
 	.bmdma_status		= inic_bmdma_status,
+	.qc_prep		= inic_qc_prep,
 	.qc_issue		= inic_qc_issue,
 	.qc_fill_rtf		= inic_qc_fill_rtf,
 
-- 
1.5.2.4

