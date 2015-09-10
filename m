From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] ata: pata_pxa: dmaengine conversion
Date: Thu, 10 Sep 2015 21:07:49 +0200
Message-ID: <1441912069-620-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:42448 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbbIJTMs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Sep 2015 15:12:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>

The PXA architecture was offered a slave dmaengine support. As a
consequence the direct DMA registers are progressively replaced by
dmaengine support.

This makes the pata_pxa change, which brings this driver to almost a
generic ATA 40-wires driver relying on dmaengine for transfers.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/ata/pata_pxa.c | 171 +++++++++++++++++--------------------------------
 1 file changed, 59 insertions(+), 112 deletions(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index c36b3e6531d8..f6c46e9a4dc0 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -24,79 +24,36 @@
 #include <linux/ata.h>
 #include <linux/libata.h>
 #include <linux/platform_device.h>
+#include <linux/dmaengine.h>
+#include <linux/dma/pxa-dma.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
 
 #include <scsi/scsi_host.h>
 
-#include <mach/pxa2xx-regs.h>
 #include <linux/platform_data/ata-pxa.h>
-#include <mach/dma.h>
 
 #define DRV_NAME	"pata_pxa"
 #define DRV_VERSION	"0.1"
 
 struct pata_pxa_data {
-	uint32_t		dma_channel;
-	struct pxa_dma_desc	*dma_desc;
-	dma_addr_t		dma_desc_addr;
-	uint32_t		dma_desc_id;
-
-	/* DMA IO physical address */
-	uint32_t		dma_io_addr;
-	/* PXA DREQ<0:2> pin selector */
-	uint32_t		dma_dreq;
-	/* DMA DCSR register value */
-	uint32_t		dma_dcsr;
-
+	struct dma_chan		*dma_chan;
+	dma_cookie_t		dma_cookie;
 	struct completion	dma_done;
 };
 
 /*
- * Setup the DMA descriptors. The size is transfer capped at 4k per descriptor,
- * if the transfer is longer, it is split into multiple chained descriptors.
+ * DMA interrupt handler.
  */
-static void pxa_load_dmac(struct scatterlist *sg, struct ata_queued_cmd *qc)
+static void pxa_ata_dma_irq(void *d)
 {
-	struct pata_pxa_data *pd = qc->ap->private_data;
-
-	uint32_t cpu_len, seg_len;
-	dma_addr_t cpu_addr;
-
-	cpu_addr = sg_dma_address(sg);
-	cpu_len = sg_dma_len(sg);
-
-	do {
-		seg_len = (cpu_len > 0x1000) ? 0x1000 : cpu_len;
-
-		pd->dma_desc[pd->dma_desc_id].ddadr = pd->dma_desc_addr +
-			((pd->dma_desc_id + 1) * sizeof(struct pxa_dma_desc));
-
-		pd->dma_desc[pd->dma_desc_id].dcmd = DCMD_BURST32 |
-					DCMD_WIDTH2 | (DCMD_LENGTH & seg_len);
-
-		if (qc->tf.flags & ATA_TFLAG_WRITE) {
-			pd->dma_desc[pd->dma_desc_id].dsadr = cpu_addr;
-			pd->dma_desc[pd->dma_desc_id].dtadr = pd->dma_io_addr;
-			pd->dma_desc[pd->dma_desc_id].dcmd |= DCMD_INCSRCADDR |
-						DCMD_FLOWTRG;
-		} else {
-			pd->dma_desc[pd->dma_desc_id].dsadr = pd->dma_io_addr;
-			pd->dma_desc[pd->dma_desc_id].dtadr = cpu_addr;
-			pd->dma_desc[pd->dma_desc_id].dcmd |= DCMD_INCTRGADDR |
-						DCMD_FLOWSRC;
-		}
-
-		cpu_len -= seg_len;
-		cpu_addr += seg_len;
-		pd->dma_desc_id++;
+	struct pata_pxa_data *pd = d;
+	enum dma_status status;
 
-	} while (cpu_len);
-
-	/* Should not happen */
-	if (seg_len & 0x1f)
-		DALGN |= (1 << pd->dma_dreq);
+	status = dmaengine_tx_status(pd->dma_chan, pd->dma_cookie, NULL);
+	if (status == DMA_ERROR || status == DMA_COMPLETE)
+		complete(&pd->dma_done);
 }
 
 /*
@@ -105,28 +62,22 @@ static void pxa_load_dmac(struct scatterlist *sg, struct ata_queued_cmd *qc)
 static void pxa_qc_prep(struct ata_queued_cmd *qc)
 {
 	struct pata_pxa_data *pd = qc->ap->private_data;
-	int si = 0;
-	struct scatterlist *sg;
+	struct dma_async_tx_descriptor *tx;
+	enum dma_transfer_direction dir;
 
 	if (!(qc->flags & ATA_QCFLAG_DMAMAP))
 		return;
 
-	pd->dma_desc_id = 0;
-
-	DCSR(pd->dma_channel) = 0;
-	DALGN &= ~(1 << pd->dma_dreq);
-
-	for_each_sg(qc->sg, sg, qc->n_elem, si)
-		pxa_load_dmac(sg, qc);
-
-	pd->dma_desc[pd->dma_desc_id - 1].ddadr = DDADR_STOP;
-
-	/* Fire IRQ only at the end of last block */
-	pd->dma_desc[pd->dma_desc_id - 1].dcmd |= DCMD_ENDIRQEN;
-
-	DDADR(pd->dma_channel) = pd->dma_desc_addr;
-	DRCMR(pd->dma_dreq) = DRCMR_MAPVLD | pd->dma_channel;
-
+	dir = (qc->dma_dir == DMA_TO_DEVICE ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM);
+	tx = dmaengine_prep_slave_sg(pd->dma_chan, qc->sg, qc->n_elem, dir,
+				     DMA_PREP_INTERRUPT);
+	if (!tx) {
+		ata_dev_err(qc->dev, "prep_slave_sg() failed\n");
+		return;
+	}
+	tx->callback = pxa_ata_dma_irq;
+	tx->callback_param = pd;
+	pd->dma_cookie = dmaengine_submit(tx);
 }
 
 /*
@@ -145,7 +96,7 @@ static void pxa_bmdma_start(struct ata_queued_cmd *qc)
 {
 	struct pata_pxa_data *pd = qc->ap->private_data;
 	init_completion(&pd->dma_done);
-	DCSR(pd->dma_channel) = DCSR_RUN;
+	dma_async_issue_pending(pd->dma_chan);
 }
 
 /*
@@ -154,12 +105,14 @@ static void pxa_bmdma_start(struct ata_queued_cmd *qc)
 static void pxa_bmdma_stop(struct ata_queued_cmd *qc)
 {
 	struct pata_pxa_data *pd = qc->ap->private_data;
+	enum dma_status status;
 
-	if ((DCSR(pd->dma_channel) & DCSR_RUN) &&
-		wait_for_completion_timeout(&pd->dma_done, HZ))
-		dev_err(qc->ap->dev, "Timeout waiting for DMA completion!");
+	status = dmaengine_tx_status(pd->dma_chan, pd->dma_cookie, NULL);
+	if (status != DMA_ERROR && status != DMA_COMPLETE &&
+	    wait_for_completion_timeout(&pd->dma_done, HZ))
+		ata_dev_err(qc->dev, "Timeout waiting for DMA completion!");
 
-	DCSR(pd->dma_channel) = 0;
+	dmaengine_terminate_all(pd->dma_chan);
 }
 
 /*
@@ -170,8 +123,11 @@ static unsigned char pxa_bmdma_status(struct ata_port *ap)
 {
 	struct pata_pxa_data *pd = ap->private_data;
 	unsigned char ret = ATA_DMA_INTR;
+	struct dma_tx_state state;
+	enum dma_status status;
 
-	if (pd->dma_dcsr & DCSR_BUSERR)
+	status = dmaengine_tx_status(pd->dma_chan, pd->dma_cookie, &state);
+	if (status != DMA_COMPLETE)
 		ret |= ATA_DMA_ERR;
 
 	return ret;
@@ -213,21 +169,6 @@ static struct ata_port_operations pxa_ata_port_ops = {
 	.qc_prep		= pxa_qc_prep,
 };
 
-/*
- * DMA interrupt handler.
- */
-static void pxa_ata_dma_irq(int dma, void *port)
-{
-	struct ata_port *ap = port;
-	struct pata_pxa_data *pd = ap->private_data;
-
-	pd->dma_dcsr = DCSR(dma);
-	DCSR(dma) = pd->dma_dcsr;
-
-	if (pd->dma_dcsr & DCSR_STOPSTATE)
-		complete(&pd->dma_done);
-}
-
 static int pxa_ata_probe(struct platform_device *pdev)
 {
 	struct ata_host *host;
@@ -238,6 +179,9 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	struct resource *dma_res;
 	struct resource *irq_res;
 	struct pata_pxa_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct dma_slave_config	config;
+	dma_cap_mask_t mask;
+	struct pxad_param param;
 	int ret = 0;
 
 	/*
@@ -333,29 +277,32 @@ static int pxa_ata_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ap->private_data = data;
-	data->dma_dreq = pdata->dma_dreq;
-	data->dma_io_addr = dma_res->start;
 
-	/*
-	 * Allocate space for the DMA descriptors
-	 */
-	data->dma_desc = dmam_alloc_coherent(&pdev->dev, PAGE_SIZE,
-					&data->dma_desc_addr, GFP_KERNEL);
-	if (!data->dma_desc)
-		return -EINVAL;
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+	param.prio = PXAD_PRIO_LOWEST;
+	param.drcmr = pdata->dma_dreq;
+	memset(&config, 0, sizeof(config));
+	config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	config.src_addr = dma_res->start;
+	config.dst_addr = dma_res->start;
+	config.src_maxburst = 32;
+	config.dst_maxburst = 32;
 
 	/*
 	 * Request the DMA channel
 	 */
-	data->dma_channel = pxa_request_dma(DRV_NAME, DMA_PRIO_LOW,
-						pxa_ata_dma_irq, ap);
-	if (data->dma_channel < 0)
+	data->dma_chan =
+		dma_request_slave_channel_compat(mask, pxad_filter_fn,
+						 &param, &pdev->dev, "data");
+	if (!data->dma_chan)
 		return -EBUSY;
-
-	/*
-	 * Stop and clear the DMA channel
-	 */
-	DCSR(data->dma_channel) = 0;
+	ret = dmaengine_slave_config(data->dma_chan, &config);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "dma configuration failed: %d\n", ret);
+		return ret;
+	}
 
 	/*
 	 * Activate the ATA host
@@ -363,7 +310,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	ret = ata_host_activate(host, irq_res->start, ata_sff_interrupt,
 				pdata->irq_flags, &pxa_ata_sht);
 	if (ret)
-		pxa_free_dma(data->dma_channel);
+		dma_release_channel(data->dma_chan);
 
 	return ret;
 }
@@ -373,7 +320,7 @@ static int pxa_ata_remove(struct platform_device *pdev)
 	struct ata_host *host = platform_get_drvdata(pdev);
 	struct pata_pxa_data *data = host->ports[0]->private_data;
 
-	pxa_free_dma(data->dma_channel);
+	dma_release_channel(data->dma_chan);
 
 	ata_host_detach(host);
 
-- 
2.1.4

