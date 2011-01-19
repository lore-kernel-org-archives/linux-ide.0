From: Xulei <B33228@freescale.com>
Subject: [PATCH 1/2] ATA: Add FSL sata v2 controller support
Date: Wed, 19 Jan 2011 17:07:29 +0800
Message-ID: <1295428050-21934-1-git-send-email-B33228@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from msnbot-157-55-116-158.search.msn.com ([157.55.116.158]:7226
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753736Ab1ASJua (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jan 2011 04:50:30 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, kumar.gala@freescale.com, Xulei <B33228@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>

In FSL sata v2 block, the snoop bit of PRDT Word3 description
information is at bit28 instead of bit22.

This patch adds FSL sata v2 probe and resolve this difference.

Signed-off-by: Lei Xu <B33228@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Acked-by: Jeff Garzik <jgarzik@redhat.com>
---
 drivers/ata/sata_fsl.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index b0214d0..01a5400 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -6,7 +6,7 @@
  * Author: Ashish Kalra <ashish.kalra@freescale.com>
  * Li Yang <leoli@freescale.com>
  *
- * Copyright (c) 2006-2007 Freescale Semiconductor, Inc.
+ * Copyright (c) 2006-2007, 2011 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -158,7 +158,8 @@ enum {
 	    IE_ON_SINGL_DEVICE_ERR | IE_ON_CMD_COMPLETE,
 
 	EXT_INDIRECT_SEG_PRD_FLAG = (1 << 31),
-	DATA_SNOOP_ENABLE = (1 << 22),
+	DATA_SNOOP_ENABLE_V1 = (1 << 22),
+	DATA_SNOOP_ENABLE_V2 = (1 << 28),
 };
 
 /*
@@ -256,6 +257,7 @@ struct sata_fsl_host_priv {
 	void __iomem *ssr_base;
 	void __iomem *csr_base;
 	int irq;
+	int data_snoop;
 };
 
 static inline unsigned int sata_fsl_tag(unsigned int tag,
@@ -308,7 +310,8 @@ static void sata_fsl_setup_cmd_hdr_entry(struct sata_fsl_port_priv *pp,
 }
 
 static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
-				     u32 *ttl, dma_addr_t cmd_desc_paddr)
+				     u32 *ttl, dma_addr_t cmd_desc_paddr,
+				     int data_snoop)
 {
 	struct scatterlist *sg;
 	unsigned int num_prde = 0;
@@ -358,8 +361,7 @@ static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
 
 		ttl_dwords += sg_len;
 		prd->dba = cpu_to_le32(sg_addr);
-		prd->ddc_and_ext =
-		    cpu_to_le32(DATA_SNOOP_ENABLE | (sg_len & ~0x03));
+		prd->ddc_and_ext = cpu_to_le32(data_snoop | (sg_len & ~0x03));
 
 		VPRINTK("sg_fill, ttl=%d, dba=0x%x, ddc=0x%x\n",
 			ttl_dwords, prd->dba, prd->ddc_and_ext);
@@ -374,7 +376,7 @@ static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
 		/* set indirect extension flag along with indirect ext. size */
 		prd_ptr_to_indirect_ext->ddc_and_ext =
 		    cpu_to_le32((EXT_INDIRECT_SEG_PRD_FLAG |
-				 DATA_SNOOP_ENABLE |
+				 data_snoop |
 				 (indirect_ext_segment_sz & ~0x03)));
 	}
 
@@ -417,7 +419,8 @@ static void sata_fsl_qc_prep(struct ata_queued_cmd *qc)
 
 	if (qc->flags & ATA_QCFLAG_DMAMAP)
 		num_prde = sata_fsl_fill_sg(qc, (void *)cd,
-					    &ttl_dwords, cd_paddr);
+					    &ttl_dwords, cd_paddr,
+					    host_priv->data_snoop);
 
 	if (qc->tf.protocol == ATA_PROT_NCQ)
 		desc_info |= FPDMA_QUEUED_CMD;
@@ -1336,6 +1339,11 @@ static int sata_fsl_probe(struct platform_device *ofdev,
 	}
 	host_priv->irq = irq;
 
+	if (of_device_is_compatible(ofdev->dev.of_node, "fsl,pq-sata-v2"))
+		host_priv->data_snoop = DATA_SNOOP_ENABLE_V2;
+	else
+		host_priv->data_snoop = DATA_SNOOP_ENABLE_V1;
+
 	/* allocate host structure */
 	host = ata_host_alloc_pinfo(&ofdev->dev, ppi, SATA_FSL_MAX_PORTS);
 
@@ -1418,6 +1426,9 @@ static struct of_device_id fsl_sata_match[] = {
 	{
 		.compatible = "fsl,pq-sata",
 	},
+	{
+		.compatible = "fsl,pq-sata-v2",
+	},
 	{},
 };
 
-- 
1.7.0.4


