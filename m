From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH v2] ata: pata_bf54x: Support sg list in bmdma transfer.
Date: Wed, 4 Jan 2012 14:06:51 +0800
Message-ID: <1325657211-21904-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:25682
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754584Ab2ADGSh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jan 2012 01:18:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>, sshtylyov@mvista.com, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

BF54x on-chip ATAPI controller allows maximum 0x1fffe bytes to be transfered
in one ATAPI transfer. So, set the max sg_tablesize to 4.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/ata/pata_bf54x.c |  167 ++++++++++++++++++++++++----------------------
 1 files changed, 88 insertions(+), 79 deletions(-)

diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 9711c2a..d2ecae4 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -251,6 +251,8 @@ static const u32 udma_tenvmin = 20;
 static const u32 udma_tackmin = 20;
 static const u32 udma_tssmin = 50;
 
+#define BFIN_MAX_SG_SEGMENTS 4
+
 /**
  *
  *	Function:       num_clocks_min
@@ -829,79 +831,61 @@ static void bfin_set_devctl(struct ata_port *ap, u8 ctl)
 
 static void bfin_bmdma_setup(struct ata_queued_cmd *qc)
 {
-	unsigned short config = WDSIZE_16;
+	struct ata_port *ap = qc->ap;
+	struct dma_desc_array *dma_desc_cpu = (struct dma_desc_array *)ap->bmdma_prd;
+	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
+	unsigned short config = DMAFLOW_ARRAY | NDSIZE_5 | RESTART | WDSIZE_16 | DMAEN;
 	struct scatterlist *sg;
 	unsigned int si;
+	unsigned int channel;
+	unsigned int dir;
+	unsigned int size = 0;
 
 	dev_dbg(qc->ap->dev, "in atapi dma setup\n");
 	/* Program the ATA_CTRL register with dir */
 	if (qc->tf.flags & ATA_TFLAG_WRITE) {
-		/* fill the ATAPI DMA controller */
-		set_dma_config(CH_ATAPI_TX, config);
-		set_dma_x_modify(CH_ATAPI_TX, 2);
-		for_each_sg(qc->sg, sg, qc->n_elem, si) {
-			set_dma_start_addr(CH_ATAPI_TX, sg_dma_address(sg));
-			set_dma_x_count(CH_ATAPI_TX, sg_dma_len(sg) >> 1);
-		}
+		channel = CH_ATAPI_TX;
+		dir = DMA_TO_DEVICE;
 	} else {
+		channel = CH_ATAPI_RX;
+		dir = DMA_FROM_DEVICE;
 		config |= WNR;
-		/* fill the ATAPI DMA controller */
-		set_dma_config(CH_ATAPI_RX, config);
-		set_dma_x_modify(CH_ATAPI_RX, 2);
-		for_each_sg(qc->sg, sg, qc->n_elem, si) {
-			set_dma_start_addr(CH_ATAPI_RX, sg_dma_address(sg));
-			set_dma_x_count(CH_ATAPI_RX, sg_dma_len(sg) >> 1);
-		}
 	}
-}
 
-/**
- *	bfin_bmdma_start - Start an IDE DMA transaction
- *	@qc: Info associated with this ATA transaction.
- *
- *	Note: Original code is ata_bmdma_start().
- */
+	dma_map_sg(ap->dev, qc->sg, qc->n_elem, dir);
 
-static void bfin_bmdma_start(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
-	struct scatterlist *sg;
-	unsigned int si;
+	/* fill the ATAPI DMA controller */
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
+		dma_desc_cpu[si].start_addr = sg_dma_address(sg);
+		dma_desc_cpu[si].cfg = config;
+		dma_desc_cpu[si].x_count = sg_dma_len(sg) >> 1;
+		dma_desc_cpu[si].x_modify = 2;
+		size += sg_dma_len(sg);
+	}
 
-	dev_dbg(qc->ap->dev, "in atapi dma start\n");
-	if (!(ap->udma_mask || ap->mwdma_mask))
-		return;
+	/* Set the last descriptor to stop mode */
+	dma_desc_cpu[qc->n_elem - 1].cfg &= ~(DMAFLOW | NDSIZE);
 
-	/* start ATAPI DMA controller*/
-	if (qc->tf.flags & ATA_TFLAG_WRITE) {
-		/*
-		 * On blackfin arch, uncacheable memory is not
-		 * allocated with flag GFP_DMA. DMA buffer from
-		 * common kenel code should be flushed if WB
-		 * data cache is enabled. Otherwise, this loop
-		 * is an empty loop and optimized out.
-		 */
-		for_each_sg(qc->sg, sg, qc->n_elem, si) {
-			flush_dcache_range(sg_dma_address(sg),
-				sg_dma_address(sg) + sg_dma_len(sg));
-		}
-		enable_dma(CH_ATAPI_TX);
-		dev_dbg(qc->ap->dev, "enable udma write\n");
+	flush_dcache_range((unsigned int)dma_desc_cpu,
+		(unsigned int)dma_desc_cpu +
+			qc->n_elem * sizeof(struct dma_desc_array));
 
-		/* Send ATA DMA write command */
-		bfin_exec_command(ap, &qc->tf);
+	/* Enable ATA DMA operation*/
+	set_dma_curr_desc_addr(channel, (unsigned long *)ap->bmdma_prd_dma);
+	set_dma_x_count(channel, 0);
+	set_dma_x_modify(channel, 0);
+	set_dma_config(channel, config);
+
+	SSYNC();
+
+	/* Send ATA DMA command */
+	bfin_exec_command(ap, &qc->tf);
 
+	if (qc->tf.flags & ATA_TFLAG_WRITE) {
 		/* set ATA DMA write direction */
 		ATAPI_SET_CONTROL(base, (ATAPI_GET_CONTROL(base)
 			| XFER_DIR));
 	} else {
-		enable_dma(CH_ATAPI_RX);
-		dev_dbg(qc->ap->dev, "enable udma read\n");
-
-		/* Send ATA DMA read command */
-		bfin_exec_command(ap, &qc->tf);
-
 		/* set ATA DMA read direction */
 		ATAPI_SET_CONTROL(base, (ATAPI_GET_CONTROL(base)
 			& ~XFER_DIR));
@@ -913,12 +897,28 @@ static void bfin_bmdma_start(struct ata_queued_cmd *qc)
 	/* Set ATAPI state machine contorl in terminate sequence */
 	ATAPI_SET_CONTROL(base, ATAPI_GET_CONTROL(base) | END_ON_TERM);
 
-	/* Set transfer length to buffer len */
-	for_each_sg(qc->sg, sg, qc->n_elem, si) {
-		ATAPI_SET_XFER_LEN(base, (sg_dma_len(sg) >> 1));
-	}
+	/* Set transfer length to the total size of sg buffers */
+	ATAPI_SET_XFER_LEN(base, size >> 1);
+}
 
-	/* Enable ATA DMA operation*/
+/**
+ *	bfin_bmdma_start - Start an IDE DMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	Note: Original code is ata_bmdma_start().
+ */
+
+static void bfin_bmdma_start(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
+
+	dev_dbg(qc->ap->dev, "in atapi dma start\n");
+
+	if (!(ap->udma_mask || ap->mwdma_mask))
+		return;
+
+	/* start ATAPI transfer*/
 	if (ap->udma_mask)
 		ATAPI_SET_CONTROL(base, ATAPI_GET_CONTROL(base)
 			| ULTRA_START);
@@ -935,34 +935,23 @@ static void bfin_bmdma_start(struct ata_queued_cmd *qc)
 static void bfin_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct scatterlist *sg;
-	unsigned int si;
+	unsigned int dir;
 
 	dev_dbg(qc->ap->dev, "in atapi dma stop\n");
+
 	if (!(ap->udma_mask || ap->mwdma_mask))
 		return;
 
 	/* stop ATAPI DMA controller*/
-	if (qc->tf.flags & ATA_TFLAG_WRITE)
+	if (qc->tf.flags & ATA_TFLAG_WRITE) {
+		dir = DMA_TO_DEVICE;
 		disable_dma(CH_ATAPI_TX);
-	else {
+	} else {
+		dir = DMA_FROM_DEVICE;
 		disable_dma(CH_ATAPI_RX);
-		if (ap->hsm_task_state & HSM_ST_LAST) {
-			/*
-			 * On blackfin arch, uncacheable memory is not
-			 * allocated with flag GFP_DMA. DMA buffer from
-			 * common kenel code should be invalidated if
-			 * data cache is enabled. Otherwise, this loop
-			 * is an empty loop and optimized out.
-			 */
-			for_each_sg(qc->sg, sg, qc->n_elem, si) {
-				invalidate_dcache_range(
-					sg_dma_address(sg),
-					sg_dma_address(sg)
-					+ sg_dma_len(sg));
-			}
-		}
 	}
+
+	dma_unmap_sg(ap->dev, qc->sg, qc->n_elem, dir);
 }
 
 /**
@@ -1261,6 +1250,11 @@ static void bfin_port_stop(struct ata_port *ap)
 {
 	dev_dbg(ap->dev, "in atapi port stop\n");
 	if (ap->udma_mask != 0 || ap->mwdma_mask != 0) {
+		dma_free_coherent(ap->dev,
+			BFIN_MAX_SG_SEGMENTS * sizeof(struct dma_desc_array),
+			ap->bmdma_prd,
+			ap->bmdma_prd_dma);
+
 		free_dma(CH_ATAPI_RX);
 		free_dma(CH_ATAPI_TX);
 	}
@@ -1272,14 +1266,29 @@ static int bfin_port_start(struct ata_port *ap)
 	if (!(ap->udma_mask || ap->mwdma_mask))
 		return 0;
 
+	ap->bmdma_prd = dma_alloc_coherent(ap->dev,
+				BFIN_MAX_SG_SEGMENTS * sizeof(struct dma_desc_array),
+				&ap->bmdma_prd_dma,
+				GFP_KERNEL);
+
+	if (ap->bmdma_prd == NULL) {
+		dev_info(ap->dev, "Unable to allocate DMA descriptor array.\n");
+		goto out;
+	}
+
 	if (request_dma(CH_ATAPI_RX, "BFIN ATAPI RX DMA") >= 0) {
 		if (request_dma(CH_ATAPI_TX,
 			"BFIN ATAPI TX DMA") >= 0)
 			return 0;
 
 		free_dma(CH_ATAPI_RX);
+		dma_free_coherent(ap->dev,
+			BFIN_MAX_SG_SEGMENTS * sizeof(struct dma_desc_array),
+			ap->bmdma_prd,
+			ap->bmdma_prd_dma);
 	}
 
+out:
 	ap->udma_mask = 0;
 	ap->mwdma_mask = 0;
 	dev_err(ap->dev, "Unable to request ATAPI DMA!"
@@ -1401,7 +1410,7 @@ static irqreturn_t bfin_ata_interrupt(int irq, void *dev_instance)
 
 static struct scsi_host_template bfin_sht = {
 	ATA_BASE_SHT(DRV_NAME),
-	.sg_tablesize		= SG_NONE,
+	.sg_tablesize		= BFIN_MAX_SG_SEGMENTS,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 };
 
-- 
1.7.0.4


