From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/10] sata_inic162x: kill now unused SFF related stuff
Date: Wed, 30 Apr 2008 16:35:15 +0900
Message-ID: <1209540919261-git-send-email-htejun@gmail.com>
References: <12095409172824-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.246]:29953 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755623AbYD3Hf3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 03:35:29 -0400
Received: by rv-out-0506.google.com with SMTP id k29so211429rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 00:35:29 -0700 (PDT)
In-Reply-To: <12095409172824-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

sata_inic162x now doesn't use any SFF features.  Remove all SFF
related stuff.

* Mask unsolicited ATA interrupts.  This removes our primary source of
  spurious interrupts and spurious interrupt handling can be tightened
  up.  There's no need to clear ATA interrupts by reading status
  register either.

* Don't dance with IDMA_CTL_ATA_NIEN and simplify accesses to
  IDMA_CTL.

* Inherit from sata_port_ops instead of ata_sff_port_ops.

* Don't initialize or use ioaddr.  There's no need to map BAR0-4
  anymore.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/sata_inic162x.c |   69 +++++++++++-------------------------------
 1 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index a31dc24..ee67d6e 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -101,7 +101,7 @@ enum {
 	PIRQ_PENDING		= (1 << 7),  /* port IRQ pending (STAT only) */
 
 	PIRQ_ERR		= PIRQ_OFFLINE | PIRQ_ONLINE | PIRQ_FATAL,
-	PIRQ_MASK_DEFAULT	= PIRQ_REPLY,
+	PIRQ_MASK_DEFAULT	= PIRQ_REPLY | PIRQ_ATA,
 	PIRQ_MASK_FREEZE	= 0xff,
 
 	/* PORT_PRD_CTL bits */
@@ -227,31 +227,26 @@ static void __iomem *inic_port_base(struct ata_port *ap)
 static void inic_reset_port(void __iomem *port_base)
 {
 	void __iomem *idma_ctl = port_base + PORT_IDMA_CTL;
-	u16 ctl;
 
-	ctl = readw(idma_ctl);
-	ctl &= ~(IDMA_CTL_RST_IDMA | IDMA_CTL_ATA_NIEN | IDMA_CTL_GO);
+	/* stop IDMA engine */
+	readw(idma_ctl); /* flush */
+	msleep(1);
 
 	/* mask IRQ and assert reset */
-	writew(ctl | IDMA_CTL_RST_IDMA | IDMA_CTL_ATA_NIEN, idma_ctl);
+	writew(IDMA_CTL_RST_IDMA, idma_ctl);
 	readw(idma_ctl); /* flush */
-
-	/* give it some time */
 	msleep(1);
 
 	/* release reset */
-	writew(ctl | IDMA_CTL_ATA_NIEN, idma_ctl);
+	writew(0, idma_ctl);
 
 	/* clear irq */
 	writeb(0xff, port_base + PORT_IRQ_STAT);
-
-	/* reenable ATA IRQ, turn off IDMA mode */
-	writew(ctl, idma_ctl);
 }
 
 static int inic_scr_read(struct ata_port *ap, unsigned sc_reg, u32 *val)
 {
-	void __iomem *scr_addr = ap->ioaddr.scr_addr;
+	void __iomem *scr_addr = inic_port_base(ap) + PORT_SCR;
 	void __iomem *addr;
 
 	if (unlikely(sc_reg >= ARRAY_SIZE(scr_map)))
@@ -268,7 +263,7 @@ static int inic_scr_read(struct ata_port *ap, unsigned sc_reg, u32 *val)
 
 static int inic_scr_write(struct ata_port *ap, unsigned sc_reg, u32 val)
 {
-	void __iomem *scr_addr = ap->ioaddr.scr_addr;
+	void __iomem *scr_addr = inic_port_base(ap) + PORT_SCR;
 
 	if (unlikely(sc_reg >= ARRAY_SIZE(scr_map)))
 		return -EINVAL;
@@ -357,10 +352,8 @@ static void inic_host_intr(struct ata_port *ap)
 	if (unlikely((irq_stat & PIRQ_ERR) || (idma_stat & IDMA_STAT_ERR)))
 		inic_host_err_intr(ap, irq_stat, idma_stat);
 
-	if (unlikely(!qc)) {
-		ap->ops->sff_check_status(ap); /* clear ATA interrupt */
+	if (unlikely(!qc))
 		goto spurious;
-	}
 
 	if (likely(idma_stat & IDMA_STAT_DONE)) {
 		inic_stop_idma(ap);
@@ -377,7 +370,9 @@ static void inic_host_intr(struct ata_port *ap)
 	}
 
  spurious:
-	ap->ops->sff_check_status(ap); /* clear ATA interrupt */
+	ata_port_printk(ap, KERN_WARNING, "unhandled interrupt: "
+			"cmd=0x%x irq_stat=0x%x idma_stat=0x%x\n",
+			qc ? qc->tf.command : 0xff, irq_stat, idma_stat);
 }
 
 static irqreturn_t inic_interrupt(int irq, void *dev_instance)
@@ -568,7 +563,6 @@ static void inic_freeze(struct ata_port *ap)
 	void __iomem *port_base = inic_port_base(ap);
 
 	writeb(PIRQ_MASK_FREEZE, port_base + PORT_IRQ_MASK);
-	ap->ops->sff_check_status(ap);
 	writeb(0xff, port_base + PORT_IRQ_STAT);
 }
 
@@ -576,7 +570,6 @@ static void inic_thaw(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
 
-	ap->ops->sff_check_status(ap);
 	writeb(0xff, port_base + PORT_IRQ_STAT);
 	writeb(PIRQ_MASK_DEFAULT, port_base + PORT_IRQ_MASK);
 }
@@ -599,17 +592,15 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
 	void __iomem *port_base = inic_port_base(ap);
 	void __iomem *idma_ctl = port_base + PORT_IDMA_CTL;
 	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
-	u16 val;
 	int rc;
 
 	/* hammer it into sane state */
 	inic_reset_port(port_base);
 
-	val = readw(idma_ctl);
-	writew(val | IDMA_CTL_RST_ATA, idma_ctl);
+	writew(IDMA_CTL_RST_ATA, idma_ctl);
 	readw(idma_ctl);	/* flush */
 	msleep(1);
-	writew(val & ~IDMA_CTL_RST_ATA, idma_ctl);
+	writew(0, idma_ctl);
 
 	rc = sata_link_resume(link, timing, deadline);
 	if (rc) {
@@ -647,16 +638,8 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
 static void inic_error_handler(struct ata_port *ap)
 {
 	void __iomem *port_base = inic_port_base(ap);
-	unsigned long flags;
 
-	/* reset PIO HSM and stop DMA engine */
 	inic_reset_port(port_base);
-
-	spin_lock_irqsave(ap->lock, flags);
-	ap->hsm_task_state = HSM_ST_IDLE;
-	spin_unlock_irqrestore(ap->lock, flags);
-
-	/* PIO and DMA engines have been stopped, perform recovery */
 	ata_std_error_handler(ap);
 }
 
@@ -720,7 +703,7 @@ static int inic_port_start(struct ata_port *ap)
 }
 
 static struct ata_port_operations inic_port_ops = {
-	.inherits		= &ata_sff_port_ops,
+	.inherits		= &sata_port_ops,
 
 	.check_atapi_dma	= inic_check_atapi_dma,
 	.qc_prep		= inic_qc_prep,
@@ -729,7 +712,6 @@ static struct ata_port_operations inic_port_ops = {
 
 	.freeze			= inic_freeze,
 	.thaw			= inic_thaw,
-	.softreset		= ATA_OP_NULL,	/* softreset is broken */
 	.hardreset		= inic_hardreset,
 	.error_handler		= inic_error_handler,
 	.post_internal_cmd	= inic_post_internal_cmd,
@@ -838,34 +820,19 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions(pdev, 0x3f, DRV_NAME);
+	rc = pcim_iomap_regions(pdev, 1 << MMIO_BAR, DRV_NAME);
 	if (rc)
 		return rc;
 	host->iomap = iomap = pcim_iomap_table(pdev);
+	hpriv->cached_hctl = readw(iomap[MMIO_BAR] + HOST_CTL);
 
 	for (i = 0; i < NR_PORTS; i++) {
 		struct ata_port *ap = host->ports[i];
-		struct ata_ioports *port = &ap->ioaddr;
-		unsigned int offset = i * PORT_SIZE;
-
-		port->cmd_addr = iomap[2 * i];
-		port->altstatus_addr =
-		port->ctl_addr = (void __iomem *)
-			((unsigned long)iomap[2 * i + 1] | ATA_PCI_CTL_OFS);
-		port->scr_addr = iomap[MMIO_BAR] + offset + PORT_SCR;
-
-		ata_sff_std_ports(port);
 
 		ata_port_pbar_desc(ap, MMIO_BAR, -1, "mmio");
-		ata_port_pbar_desc(ap, MMIO_BAR, offset, "port");
-		ata_port_desc(ap, "cmd 0x%llx ctl 0x%llx",
-		  (unsigned long long)pci_resource_start(pdev, 2 * i),
-		  (unsigned long long)pci_resource_start(pdev, (2 * i + 1)) |
-				      ATA_PCI_CTL_OFS);
+		ata_port_pbar_desc(ap, MMIO_BAR, i * PORT_SIZE, "port");
 	}
 
-	hpriv->cached_hctl = readw(iomap[MMIO_BAR] + HOST_CTL);
-
 	/* Set dma_mask.  This devices doesn't support 64bit addressing. */
 	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc) {
-- 
1.5.2.4

