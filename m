From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/10] sata_inic162x: kill now unused bmdma related stuff
Date: Wed, 30 Apr 2008 16:35:12 +0900
Message-ID: <12095409183598-git-send-email-htejun@gmail.com>
References: <12095409172824-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.240]:30073 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755537AbYD3Hf2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 03:35:28 -0400
Received: by rv-out-0506.google.com with SMTP id k29so211428rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 00:35:28 -0700 (PDT)
In-Reply-To: <12095409172824-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

sata_inic162x doesn't use BMDMA anymore.  Kill bmdma related stuff.

* prdctl manipulation

* port IRQ mask manipulation

* inherit ATA_BASE_SHT instead of ATA_BMDMA_SHT

* BMDMA methods

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_inic162x.c |  103 ++----------------------------------------
 1 files changed, 5 insertions(+), 98 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 1f105fe..094b0ed 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -101,9 +101,7 @@ enum {
 	PIRQ_PENDING		= (1 << 7),  /* port IRQ pending (STAT only) */
 
 	PIRQ_ERR		= PIRQ_OFFLINE | PIRQ_ONLINE | PIRQ_FATAL,
-
-	PIRQ_MASK_DMA_READ	= PIRQ_REPLY | PIRQ_ATA,
-	PIRQ_MASK_OTHER		= PIRQ_REPLY | PIRQ_COMPLETE,
+	PIRQ_MASK_DEFAULT	= PIRQ_REPLY,
 	PIRQ_MASK_FREEZE	= 0xff,
 
 	/* PORT_PRD_CTL bits */
@@ -206,13 +204,11 @@ struct inic_port_priv {
 	dma_addr_t	pkt_dma;
 	u32		*cpb_tbl;
 	dma_addr_t	cpb_tbl_dma;
-	u8		dfl_prdctl;
-	u8		cached_prdctl;
-	u8		cached_pirq_mask;
 };
 
 static struct scsi_host_template inic_sht = {
-	ATA_BMDMA_SHT(DRV_NAME),
+	ATA_BASE_SHT(DRV_NAME),
+	.sg_tablesize	= LIBATA_MAX_PRD,	/* maybe it can be larger? */
 	.dma_boundary	= INIC_DMA_BOUNDARY,
 };
 
@@ -227,23 +223,6 @@ static void __iomem *inic_port_base(struct ata_port *ap)
 	return ap->host->iomap[MMIO_BAR] + ap->port_no * PORT_SIZE;
 }
 
-static void __inic_set_pirq_mask(struct ata_port *ap, u8 mask)
-{
-	void __iomem *port_base = inic_port_base(ap);
-	struct inic_port_priv *pp = ap->private_data;
-
-	writeb(mask, port_base + PORT_IRQ_MASK);
-	pp->cached_pirq_mask = mask;
-}
-
-static void inic_set_pirq_mask(struct ata_port *ap, u8 mask)
-{
-	struct inic_port_priv *pp = ap->private_data;
-
-	if (pp->cached_pirq_mask != mask)
-		__inic_set_pirq_mask(ap, mask);
-}
-
 static void inic_reset_port(void __iomem *port_base)
 {
 	void __iomem *idma_ctl = port_base + PORT_IDMA_CTL;
@@ -297,63 +276,6 @@ static int inic_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
 	return 0;
 }
 
-/*
- * In TF mode, inic162x is very similar to SFF device.  TF registers
- * function the same.  DMA engine behaves similary using the same PRD
- * format as BMDMA but different command register, interrupt and event
- * notification methods are used.  The following inic_bmdma_*()
- * functions do the impedance matching.
- */
-static void inic_bmdma_setup(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct inic_port_priv *pp = ap->private_data;
-	void __iomem *port_base = inic_port_base(ap);
-	int rw = qc->tf.flags & ATA_TFLAG_WRITE;
-
-	/* make sure device sees PRD table writes */
-	wmb();
-
-	/* load transfer length */
-	writel(qc->nbytes, port_base + PORT_PRD_XFERLEN);
-
-	/* turn on DMA and specify data direction */
-	pp->cached_prdctl = pp->dfl_prdctl | PRD_CTL_DMAEN;
-	if (!rw)
-		pp->cached_prdctl |= PRD_CTL_WR;
-	writeb(pp->cached_prdctl, port_base + PORT_PRD_CTL);
-
-	/* issue r/w command */
-	ap->ops->sff_exec_command(ap, &qc->tf);
-}
-
-static void inic_bmdma_start(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct inic_port_priv *pp = ap->private_data;
-	void __iomem *port_base = inic_port_base(ap);
-
-	/* start host DMA transaction */
-	pp->cached_prdctl |= PRD_CTL_START;
-	writeb(pp->cached_prdctl, port_base + PORT_PRD_CTL);
-}
-
-static void inic_bmdma_stop(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct inic_port_priv *pp = ap->private_data;
-	void __iomem *port_base = inic_port_base(ap);
-
-	/* stop DMA engine */
-	writeb(pp->dfl_prdctl, port_base + PORT_PRD_CTL);
-}
-
-static u8 inic_bmdma_status(struct ata_port *ap)
-{
-	/* event is already verified by the interrupt handler */
-	return ATA_DMA_INTR;
-}
-
 static void inic_stop_idma(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
@@ -631,8 +553,7 @@ static void inic_freeze(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
 
-	__inic_set_pirq_mask(ap, PIRQ_MASK_FREEZE);
-
+	writeb(PIRQ_MASK_FREEZE, port_base + PORT_IRQ_MASK);
 	ap->ops->sff_check_status(ap);
 	writeb(0xff, port_base + PORT_IRQ_STAT);
 }
@@ -643,8 +564,7 @@ static void inic_thaw(struct ata_port *ap)
 
 	ap->ops->sff_check_status(ap);
 	writeb(0xff, port_base + PORT_IRQ_STAT);
-
-	__inic_set_pirq_mask(ap, PIRQ_MASK_OTHER);
+	writeb(PIRQ_MASK_DEFAULT, port_base + PORT_IRQ_MASK);
 }
 
 static int inic_check_ready(struct ata_link *link)
@@ -713,7 +633,6 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
 static void inic_error_handler(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
-	struct inic_port_priv *pp = ap->private_data;
 	unsigned long flags;
 
 	/* reset PIO HSM and stop DMA engine */
@@ -721,7 +640,6 @@ static void inic_error_handler(struct ata_port *ap)
 
 	spin_lock_irqsave(ap->lock, flags);
 	ap->hsm_task_state = HSM_ST_IDLE;
-	writeb(pp->dfl_prdctl, port_base + PORT_PRD_CTL);
 	spin_unlock_irqrestore(ap->lock, flags);
 
 	/* PIO and DMA engines have been stopped, perform recovery */
@@ -771,10 +689,8 @@ static int inic_port_resume(struct ata_port *ap)
 
 static int inic_port_start(struct ata_port *ap)
 {
-	void __iomem *port_base = inic_port_base(ap);
 	struct device *dev = ap->host->dev;
 	struct inic_port_priv *pp;
-	u8 tmp;
 	int rc;
 
 	/* alloc and initialize private data */
@@ -783,11 +699,6 @@ static int inic_port_start(struct ata_port *ap)
 		return -ENOMEM;
 	ap->private_data = pp;
 
-	/* default PRD_CTL value, DMAEN, WR and START off */
-	tmp = readb(port_base + PORT_PRD_CTL);
-	tmp &= ~(PRD_CTL_DMAEN | PRD_CTL_WR | PRD_CTL_START);
-	pp->dfl_prdctl = tmp;
-
 	/* Alloc resources */
 	rc = ata_port_start(ap);
 	if (rc)
@@ -811,10 +722,6 @@ static int inic_port_start(struct ata_port *ap)
 static struct ata_port_operations inic_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 
-	.bmdma_setup		= inic_bmdma_setup,
-	.bmdma_start		= inic_bmdma_start,
-	.bmdma_stop		= inic_bmdma_stop,
-	.bmdma_status		= inic_bmdma_status,
 	.qc_prep		= inic_qc_prep,
 	.qc_issue		= inic_qc_issue,
 	.qc_fill_rtf		= inic_qc_fill_rtf,
-- 
1.5.2.4

