From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] sata_dwc_460ex: fix most of the sparse warnings
Date: Wed,  7 Jan 2015 15:24:22 +0200
Message-ID: <1420637062-15450-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1420637062-15450-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20927 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbbAGNYq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jan 2015 08:24:46 -0500
In-Reply-To: <1420637062-15450-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Miesfeld <mmiesfeld@amcc.com>, Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There are a lot sparse warnings. Most of them related to __iomem keyword which
sometimes absent when it's needed and vise versa.

The patch fixes most of the warnings.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 67 ++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index c1723e0..6c1b649 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -285,7 +285,7 @@ struct sata_dwc_device {
 	struct device		*dev;		/* generic device struct */
 	struct ata_probe_ent	*pe;		/* ptr to probe-ent */
 	struct ata_host		*host;
-	u8			*reg_base;
+	u8 __iomem		*reg_base;
 	struct sata_dwc_regs	*sata_dwc_regs;	/* DW Synopsys SATA specific */
 	int			irq_dma;
 };
@@ -335,7 +335,9 @@ struct sata_dwc_host_priv {
 	struct	device	*dwc_dev;
 	int	dma_channel;
 };
-struct sata_dwc_host_priv host_pvt;
+
+static struct sata_dwc_host_priv host_pvt;
+
 /*
  * Prototypes
  */
@@ -592,9 +594,9 @@ static int map_sg_to_lli(struct scatterlist *sg, int num_elems,
 
 	sms_val = 0;
 	dms_val = 1 + host_pvt.dma_channel;
-	dev_dbg(host_pvt.dwc_dev, "%s: sg=%p nelem=%d lli=%p dma_lli=0x%08x"
-		" dmadr=0x%08x\n", __func__, sg, num_elems, lli, (u32)dma_lli,
-		(u32)dmadr_addr);
+	dev_dbg(host_pvt.dwc_dev,
+		"%s: sg=%p nelem=%d lli=%p dma_lli=0x%pad dmadr=0x%p\n",
+		__func__, sg, num_elems, lli, &dma_lli, dmadr_addr);
 
 	bl = get_burst_length_encode(AHB_DMA_BRST_DFLT);
 
@@ -785,7 +787,7 @@ static void dma_dwc_exit(struct sata_dwc_device *hsdev)
 {
 	dev_dbg(host_pvt.dwc_dev, "%s:\n", __func__);
 	if (host_pvt.sata_dma_regs) {
-		iounmap(host_pvt.sata_dma_regs);
+		iounmap((void __iomem *)host_pvt.sata_dma_regs);
 		host_pvt.sata_dma_regs = NULL;
 	}
 
@@ -830,7 +832,7 @@ static int sata_dwc_scr_read(struct ata_link *link, unsigned int scr, u32 *val)
 		return -EINVAL;
 	}
 
-	*val = in_le32((void *)link->ap->ioaddr.scr_addr + (scr * 4));
+	*val = in_le32(link->ap->ioaddr.scr_addr + (scr * 4));
 	dev_dbg(link->ap->dev, "%s: id=%d reg=%d val=val=0x%08x\n",
 		__func__, link->ap->print_id, scr, *val);
 
@@ -846,21 +848,19 @@ static int sata_dwc_scr_write(struct ata_link *link, unsigned int scr, u32 val)
 			 __func__, scr);
 		return -EINVAL;
 	}
-	out_le32((void *)link->ap->ioaddr.scr_addr + (scr * 4), val);
+	out_le32(link->ap->ioaddr.scr_addr + (scr * 4), val);
 
 	return 0;
 }
 
 static u32 core_scr_read(unsigned int scr)
 {
-	return in_le32((void __iomem *)(host_pvt.scr_addr_sstatus) +\
-			(scr * 4));
+	return in_le32(host_pvt.scr_addr_sstatus + (scr * 4));
 }
 
 static void core_scr_write(unsigned int scr, u32 val)
 {
-	out_le32((void __iomem *)(host_pvt.scr_addr_sstatus) + (scr * 4),
-		val);
+	out_le32(host_pvt.scr_addr_sstatus + (scr * 4), val);
 }
 
 static void clear_serror(void)
@@ -868,7 +868,6 @@ static void clear_serror(void)
 	u32 val;
 	val = core_scr_read(SCR_ERROR);
 	core_scr_write(SCR_ERROR, val);
-
 }
 
 static void clear_interrupt_bit(struct sata_dwc_device *hsdev, u32 bit)
@@ -1268,24 +1267,24 @@ static void sata_dwc_enable_interrupts(struct sata_dwc_device *hsdev)
 
 static void sata_dwc_setup_port(struct ata_ioports *port, unsigned long base)
 {
-	port->cmd_addr = (void *)base + 0x00;
-	port->data_addr = (void *)base + 0x00;
+	port->cmd_addr = (void __iomem *)base + 0x00;
+	port->data_addr = (void __iomem *)base + 0x00;
 
-	port->error_addr = (void *)base + 0x04;
-	port->feature_addr = (void *)base + 0x04;
+	port->error_addr = (void __iomem *)base + 0x04;
+	port->feature_addr = (void __iomem *)base + 0x04;
 
-	port->nsect_addr = (void *)base + 0x08;
+	port->nsect_addr = (void __iomem *)base + 0x08;
 
-	port->lbal_addr = (void *)base + 0x0c;
-	port->lbam_addr = (void *)base + 0x10;
-	port->lbah_addr = (void *)base + 0x14;
+	port->lbal_addr = (void __iomem *)base + 0x0c;
+	port->lbam_addr = (void __iomem *)base + 0x10;
+	port->lbah_addr = (void __iomem *)base + 0x14;
 
-	port->device_addr = (void *)base + 0x18;
-	port->command_addr = (void *)base + 0x1c;
-	port->status_addr = (void *)base + 0x1c;
+	port->device_addr = (void __iomem *)base + 0x18;
+	port->command_addr = (void __iomem *)base + 0x1c;
+	port->status_addr = (void __iomem *)base + 0x1c;
 
-	port->altstatus_addr = (void *)base + 0x20;
-	port->ctl_addr = (void *)base + 0x20;
+	port->altstatus_addr = (void __iomem *)base + 0x20;
+	port->ctl_addr = (void __iomem *)base + 0x20;
 }
 
 /*
@@ -1326,7 +1325,7 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	for (i = 0; i < SATA_DWC_QCMD_MAX; i++)
 		hsdevp->cmd_issued[i] = SATA_DWC_CMD_ISSUED_NOT;
 
-	ap->bmdma_prd = 0;	/* set these so libata doesn't use them */
+	ap->bmdma_prd = NULL;	/* set these so libata doesn't use them */
 	ap->bmdma_prd_dma = 0;
 
 	/*
@@ -1523,8 +1522,8 @@ static void sata_dwc_qc_prep_by_tag(struct ata_queued_cmd *qc, u8 tag)
 
 	dma_chan = dma_dwc_xfer_setup(sg, qc->n_elem, hsdevp->llit[tag],
 				      hsdevp->llit_dma[tag],
-				      (void *__iomem)(&hsdev->sata_dwc_regs->\
-				      dmadr), qc->dma_dir);
+				      (void __iomem *)&hsdev->sata_dwc_regs->dmadr,
+				      qc->dma_dir);
 	if (dma_chan < 0) {
 		dev_err(ap->dev, "%s: dma_dwc_xfer_setup returns err %d\n",
 			__func__, dma_chan);
@@ -1597,8 +1596,8 @@ static void sata_dwc_error_handler(struct ata_port *ap)
 	ata_sff_error_handler(ap);
 }
 
-int sata_dwc_hardreset(struct ata_link *link, unsigned int *class,
-			unsigned long deadline)
+static int sata_dwc_hardreset(struct ata_link *link, unsigned int *class,
+			      unsigned long deadline)
 {
 	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(link->ap);
 	int ret;
@@ -1630,7 +1629,7 @@ static struct scsi_host_template sata_dwc_sht = {
 	 * max of 1. This will get fixed in in a future release.
 	 */
 	.sg_tablesize		= LIBATA_MAX_PRD,
-	.can_queue		= ATA_DEF_QUEUE,	/* ATA_MAX_QUEUE */
+	/* .can_queue		= ATA_MAX_QUEUE, */
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 };
 
@@ -1667,7 +1666,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	struct sata_dwc_device *hsdev;
 	u32 idr, versionr;
 	char *ver = (char *)&versionr;
-	u8 *base = NULL;
+	u8 __iomem *base;
 	int err = 0;
 	int irq;
 	struct ata_host *host;
@@ -1736,7 +1735,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	}
 
 	/* Get physical SATA DMA register base address */
-	host_pvt.sata_dma_regs = of_iomap(ofdev->dev.of_node, 1);
+	host_pvt.sata_dma_regs = (void *)of_iomap(ofdev->dev.of_node, 1);
 	if (!(host_pvt.sata_dma_regs)) {
 		dev_err(&ofdev->dev, "ioremap failed for AHBDMA register"
 			" address\n");
-- 
2.1.3

