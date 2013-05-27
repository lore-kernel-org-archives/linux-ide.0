From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH 3/3] sata_rcar: add 'base' local variable to some functions
Date: Tue, 28 May 2013 02:46:41 +0400
Message-ID: <201305280246.41380.sergei.shtylyov@cogentembedded.com>
References: <201305280238.17867.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:58858 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab3E0Wqn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 May 2013 18:46:43 -0400
Received: by mail-la0-f45.google.com with SMTP id ec20so6896283lab.18
        for <linux-ide@vger.kernel.org>; Mon, 27 May 2013 15:46:41 -0700 (PDT)
In-Reply-To: <201305280238.17867.sergei.shtylyov@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org
Cc: linux-sh@vger.kernel.org

The 'base' field of 'struct sata_rcar_priv' is used very often throughout the
driver, so it seems worth loading it into a local variable  if it's used more
than once in a function.

While at it, put some unitialized variables after intialized ones for aesthetic
reasons. :-)

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/ata/sata_rcar.c |  102 ++++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 45 deletions(-)

Index: libata/drivers/ata/sata_rcar.c
===================================================================
--- libata.orig/drivers/ata/sata_rcar.c
+++ libata/drivers/ata/sata_rcar.c
@@ -130,41 +130,44 @@ struct sata_rcar_priv {
 
 static void sata_rcar_phy_initialize(struct sata_rcar_priv *priv)
 {
+	void __iomem *base = priv->base;
+
 	/* idle state */
-	iowrite32(0, priv->base + SATAPHYADDR_REG);
+	iowrite32(0, base + SATAPHYADDR_REG);
 	/* reset */
-	iowrite32(SATAPHYRESET_PHYRST, priv->base + SATAPHYRESET_REG);
+	iowrite32(SATAPHYRESET_PHYRST, base + SATAPHYRESET_REG);
 	udelay(10);
 	/* deassert reset */
-	iowrite32(0, priv->base + SATAPHYRESET_REG);
+	iowrite32(0, base + SATAPHYRESET_REG);
 }
 
 static void sata_rcar_phy_write(struct sata_rcar_priv *priv, u16 reg, u32 val,
 				int group)
 {
+	void __iomem *base = priv->base;
 	int timeout;
 
 	/* deassert reset */
-	iowrite32(0, priv->base + SATAPHYRESET_REG);
+	iowrite32(0, base + SATAPHYRESET_REG);
 	/* lane 1 */
-	iowrite32(SATAPHYACCEN_PHYLANE, priv->base + SATAPHYACCEN_REG);
+	iowrite32(SATAPHYACCEN_PHYLANE, base + SATAPHYACCEN_REG);
 	/* write phy register value */
-	iowrite32(val, priv->base + SATAPHYWDATA_REG);
+	iowrite32(val, base + SATAPHYWDATA_REG);
 	/* set register group */
 	if (group)
 		reg |= SATAPHYADDR_PHYRATEMODE;
 	/* write command */
-	iowrite32(SATAPHYADDR_PHYCMD_WRITE | reg, priv->base + SATAPHYADDR_REG);
+	iowrite32(SATAPHYADDR_PHYCMD_WRITE | reg, base + SATAPHYADDR_REG);
 	/* wait for ack */
 	for (timeout = 0; timeout < 100; timeout++) {
-		val = ioread32(priv->base + SATAPHYACK_REG);
+		val = ioread32(base + SATAPHYACK_REG);
 		if (val & SATAPHYACK_PHYACK)
 			break;
 	}
 	if (timeout >= 100)
 		pr_err("%s timeout\n", __func__);
 	/* idle state */
-	iowrite32(0, priv->base + SATAPHYADDR_REG);
+	iowrite32(0, base + SATAPHYADDR_REG);
 }
 
 static void sata_rcar_freeze(struct ata_port *ap)
@@ -180,14 +183,15 @@ static void sata_rcar_freeze(struct ata_
 static void sata_rcar_thaw(struct ata_port *ap)
 {
 	struct sata_rcar_priv *priv = ap->host->private_data;
+	void __iomem *base = priv->base;
 
 	/* ack */
-	iowrite32(~SATA_RCAR_INT_MASK, priv->base + SATAINTSTAT_REG);
+	iowrite32(~SATA_RCAR_INT_MASK, base + SATAINTSTAT_REG);
 
 	ata_sff_thaw(ap);
 
 	/* unmask */
-	iowrite32(0x7ff & ~SATA_RCAR_INT_MASK, priv->base + SATAINTMASK_REG);
+	iowrite32(0x7ff & ~SATA_RCAR_INT_MASK, base + SATAINTMASK_REG);
 }
 
 static void sata_rcar_ioread16_rep(void __iomem *reg, void *buffer, int count)
@@ -509,15 +513,16 @@ static void sata_rcar_bmdma_setup(struct
 {
 	struct ata_port *ap = qc->ap;
 	unsigned int rw = qc->tf.flags & ATA_TFLAG_WRITE;
-	u32 dmactl;
 	struct sata_rcar_priv *priv = ap->host->private_data;
+	void __iomem *base = priv->base;
+	u32 dmactl;
 
 	/* load PRD table addr. */
 	mb();   /* make sure PRD table writes are visible to controller */
-	iowrite32(ap->bmdma_prd_dma, priv->base + ATAPI_DTB_ADR_REG);
+	iowrite32(ap->bmdma_prd_dma, base + ATAPI_DTB_ADR_REG);
 
 	/* specify data direction, triple-check start bit is clear */
-	dmactl = ioread32(priv->base + ATAPI_CONTROL1_REG);
+	dmactl = ioread32(base + ATAPI_CONTROL1_REG);
 	dmactl &= ~(ATAPI_CONTROL1_RW | ATAPI_CONTROL1_STOP);
 	if (dmactl & ATAPI_CONTROL1_START) {
 		dmactl &= ~ATAPI_CONTROL1_START;
@@ -525,7 +530,7 @@ static void sata_rcar_bmdma_setup(struct
 	}
 	if (!rw)
 		dmactl |= ATAPI_CONTROL1_RW;
-	iowrite32(dmactl, priv->base + ATAPI_CONTROL1_REG);
+	iowrite32(dmactl, base + ATAPI_CONTROL1_REG);
 
 	/* issue r/w command */
 	ap->ops->sff_exec_command(ap, &qc->tf);
@@ -534,27 +539,29 @@ static void sata_rcar_bmdma_setup(struct
 static void sata_rcar_bmdma_start(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	u32 dmactl;
 	struct sata_rcar_priv *priv = ap->host->private_data;
+	void __iomem *base = priv->base;
+	u32 dmactl;
 
 	/* start host DMA transaction */
-	dmactl = ioread32(priv->base + ATAPI_CONTROL1_REG);
+	dmactl = ioread32(base + ATAPI_CONTROL1_REG);
 	dmactl |= ATAPI_CONTROL1_START;
-	iowrite32(dmactl, priv->base + ATAPI_CONTROL1_REG);
+	iowrite32(dmactl, base + ATAPI_CONTROL1_REG);
 }
 
 static void sata_rcar_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	struct sata_rcar_priv *priv = ap->host->private_data;
+	void __iomem *base = priv->base;
 	u32 dmactl;
 
 	/* force termination of DMA transfer if active */
-	dmactl = ioread32(priv->base + ATAPI_CONTROL1_REG);
+	dmactl = ioread32(base + ATAPI_CONTROL1_REG);
 	if (dmactl & ATAPI_CONTROL1_START) {
 		dmactl &= ~ATAPI_CONTROL1_START;
 		dmactl |= ATAPI_CONTROL1_STOP;
-		iowrite32(dmactl, priv->base + ATAPI_CONTROL1_REG);
+		iowrite32(dmactl, base + ATAPI_CONTROL1_REG);
 	}
 
 	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
@@ -564,8 +571,8 @@ static void sata_rcar_bmdma_stop(struct 
 static u8 sata_rcar_bmdma_status(struct ata_port *ap)
 {
 	struct sata_rcar_priv *priv = ap->host->private_data;
-	u32 status;
 	u8 host_stat = 0;
+	u32 status;
 
 	status = ioread32(priv->base + ATAPI_STATUS_REG);
 	if (status & ATAPI_STATUS_DEVINT)
@@ -666,19 +673,19 @@ static irqreturn_t sata_rcar_interrupt(i
 {
 	struct ata_host *host = dev_instance;
 	struct sata_rcar_priv *priv = host->private_data;
-	struct ata_port *ap;
+	void __iomem *base = priv->base;
 	unsigned int handled = 0;
+	struct ata_port *ap;
 	u32 sataintstat;
 	unsigned long flags;
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	sataintstat = ioread32(priv->base + SATAINTSTAT_REG);
+	sataintstat = ioread32(base + SATAINTSTAT_REG);
 	if (!sataintstat)
 		goto done;
 	/* ack */
-	iowrite32(sataintstat & ~SATA_RCAR_INT_MASK,
-		 priv->base + SATAINTSTAT_REG);
+	iowrite32(sataintstat & ~SATA_RCAR_INT_MASK, base + SATAINTSTAT_REG);
 
 	ap = host->ports[0];
 
@@ -699,15 +706,16 @@ static void sata_rcar_setup_port(struct 
 	struct ata_port *ap = host->ports[0];
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	struct sata_rcar_priv *priv = host->private_data;
+	void __iomem *base = priv->base;
 
 	ap->ops		= &sata_rcar_port_ops;
 	ap->pio_mask	= ATA_PIO4;
 	ap->udma_mask	= ATA_UDMA6;
 	ap->flags	|= ATA_FLAG_SATA;
 
-	ioaddr->cmd_addr = priv->base + SDATA_REG;
-	ioaddr->ctl_addr = priv->base + SSDEVCON_REG;
-	ioaddr->scr_addr = priv->base + SCRSSTS_REG;
+	ioaddr->cmd_addr = base + SDATA_REG;
+	ioaddr->ctl_addr = base + SSDEVCON_REG;
+	ioaddr->scr_addr = base + SCRSSTS_REG;
 	ioaddr->altstatus_addr = ioaddr->ctl_addr;
 
 	ioaddr->data_addr	= ioaddr->cmd_addr + (ATA_REG_DATA << 2);
@@ -725,6 +733,7 @@ static void sata_rcar_setup_port(struct 
 static void sata_rcar_init_controller(struct ata_host *host)
 {
 	struct sata_rcar_priv *priv = host->private_data;
+	void __iomem *base = priv->base;
 	u32 val;
 
 	/* reset and setup phy */
@@ -737,27 +746,27 @@ static void sata_rcar_init_controller(st
 	sata_rcar_phy_write(priv, SATAPCTLR4_REG, 0x28E80000, 0);
 
 	/* SATA-IP reset state */
-	val = ioread32(priv->base + ATAPI_CONTROL1_REG);
+	val = ioread32(base + ATAPI_CONTROL1_REG);
 	val |= ATAPI_CONTROL1_RESET;
-	iowrite32(val, priv->base + ATAPI_CONTROL1_REG);
+	iowrite32(val, base + ATAPI_CONTROL1_REG);
 
 	/* ISM mode, PRD mode, DTEND flag at bit 0 */
-	val = ioread32(priv->base + ATAPI_CONTROL1_REG);
+	val = ioread32(base + ATAPI_CONTROL1_REG);
 	val |= ATAPI_CONTROL1_ISM;
 	val |= ATAPI_CONTROL1_DESE;
 	val |= ATAPI_CONTROL1_DTA32M;
-	iowrite32(val, priv->base + ATAPI_CONTROL1_REG);
+	iowrite32(val, base + ATAPI_CONTROL1_REG);
 
 	/* Release the SATA-IP from the reset state */
-	val = ioread32(priv->base + ATAPI_CONTROL1_REG);
+	val = ioread32(base + ATAPI_CONTROL1_REG);
 	val &= ~ATAPI_CONTROL1_RESET;
-	iowrite32(val, priv->base + ATAPI_CONTROL1_REG);
+	iowrite32(val, base + ATAPI_CONTROL1_REG);
 
 	/* ack and mask */
-	iowrite32(0, priv->base + SATAINTSTAT_REG);
-	iowrite32(0x7ff, priv->base + SATAINTMASK_REG);
+	iowrite32(0, base + SATAINTSTAT_REG);
+	iowrite32(0x7ff, base + SATAINTMASK_REG);
 	/* enable interrupts */
-	iowrite32(ATAPI_INT_ENABLE_SATAINT, priv->base + ATAPI_INT_ENABLE_REG);
+	iowrite32(ATAPI_INT_ENABLE_SATAINT, base + ATAPI_INT_ENABLE_REG);
 }
 
 static int sata_rcar_probe(struct platform_device *pdev)
@@ -824,14 +833,15 @@ static int sata_rcar_remove(struct platf
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
 	struct sata_rcar_priv *priv = host->private_data;
+	void __iomem *base = priv->base;
 
 	ata_host_detach(host);
 
 	/* disable interrupts */
-	iowrite32(0, priv->base + ATAPI_INT_ENABLE_REG);
+	iowrite32(0, base + ATAPI_INT_ENABLE_REG);
 	/* ack and mask */
-	iowrite32(0, priv->base + SATAINTSTAT_REG);
-	iowrite32(0x7ff, priv->base + SATAINTMASK_REG);
+	iowrite32(0, base + SATAINTSTAT_REG);
+	iowrite32(0x7ff, base + SATAINTMASK_REG);
 
 	clk_disable(priv->clk);
 
@@ -843,14 +853,15 @@ static int sata_rcar_suspend(struct devi
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct sata_rcar_priv *priv = host->private_data;
+	void __iomem *base = priv->base;
 	int ret;
 
 	ret = ata_host_suspend(host, PMSG_SUSPEND);
 	if (!ret) {
 		/* disable interrupts */
-		iowrite32(0, priv->base + ATAPI_INT_ENABLE_REG);
+		iowrite32(0, base + ATAPI_INT_ENABLE_REG);
 		/* mask */
-		iowrite32(0x7ff, priv->base + SATAINTMASK_REG);
+		iowrite32(0x7ff, base + SATAINTMASK_REG);
 
 		clk_disable(priv->clk);
 	}
@@ -862,14 +873,15 @@ static int sata_rcar_resume(struct devic
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct sata_rcar_priv *priv = host->private_data;
+	void __iomem *base = priv->base;
 
 	clk_enable(priv->clk);
 
 	/* ack and mask */
-	iowrite32(0, priv->base + SATAINTSTAT_REG);
-	iowrite32(0x7ff, priv->base + SATAINTMASK_REG);
+	iowrite32(0, base + SATAINTSTAT_REG);
+	iowrite32(0x7ff, base + SATAINTMASK_REG);
 	/* enable interrupts */
-	iowrite32(ATAPI_INT_ENABLE_SATAINT, priv->base + ATAPI_INT_ENABLE_REG);
+	iowrite32(ATAPI_INT_ENABLE_SATAINT, base + ATAPI_INT_ENABLE_REG);
 
 	ata_host_resume(host);
 
