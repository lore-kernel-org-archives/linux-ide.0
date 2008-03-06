From: Hamish Moffatt <hamish@cloud.net.au>
Subject: [PATCH] pata_ixp4xx_cf: support single chip-select operation
Date: Thu, 6 Mar 2008 16:19:15 +1100
Message-ID: <20080306051915.GA18841@cloud.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from risingsoftware01.propagation.net ([66.221.33.65]:4142 "EHLO
	risingsoftware01.propagation.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754679AbYCFGNJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 01:13:09 -0500
Received: from c122-107-142-134.eburwd5.vic.optusnet.com.au ([122.107.142.134] helo=noddy.cloud.net.au)
	by risingsoftware01.propagation.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <hamish@cloud.net.au>)
	id 1JX8Vk-0006un-3p
	for linux-ide@vger.kernel.org; Wed, 05 Mar 2008 23:19:20 -0600
Received: from hamish by noddy.cloud.net.au with local (Exim 4.69)
	(envelope-from <hamish@cloud.net.au>)
	id 1JX8Vf-00050s-Ue
	for linux-ide@vger.kernel.org; Thu, 06 Mar 2008 16:19:15 +1100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Compact flash cards require two chip selects, and pata_ixp4xx_cf
currently maps these to two IXP4XX chip selects. On our board we use a
single IXP4XX CS line and decode an address line to split it into two.

This patch allows this by allowing you to specify the second CS region
as an offset from the first.

Signed-off-by: Hamish Moffatt <hamish@cloud.net.au>

Index: 2.6.24/drivers/ata/pata_ixp4xx_cf.c
===================================================================
--- 2.6.24/drivers/ata/pata_ixp4xx_cf.c	(revision 3791)
+++ 2.6.24/drivers/ata/pata_ixp4xx_cf.c	(working copy)
@@ -178,11 +178,13 @@ static __devinit int ixp4xx_pata_probe(s
 	struct ata_host *host;
 	struct ata_port *ap;
 	struct ixp4xx_pata_data *data = pdev->dev.platform_data;
+	unsigned long raw_cs1, cs1_offset;
 
 	cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	cs1_offset = data->cs1_offset;
 
-	if (!cs0 || !cs1)
+	if (!cs0 || (!cs1 && !cs1_offset))
 		return -EINVAL;
 
 	/* allocate host */
@@ -193,19 +195,28 @@ static __devinit int ixp4xx_pata_probe(s
 	/* acquire resources and fill host */
 	pdev->dev.coherent_dma_mask = DMA_32BIT_MASK;
 
-	data->cs0 = devm_ioremap(&pdev->dev, cs0->start, 0x1000);
-	data->cs1 = devm_ioremap(&pdev->dev, cs1->start, 0x1000);
-
-	if (!data->cs0 || !data->cs1)
+	data->cs0 = devm_ioremap(&pdev->dev, cs0->start, (cs1_offset + 0x8 + PAGE_SIZE - 1) & PAGE_MASK);
+	if (!data->cs0)
 		return -ENOMEM;
 
+	if (cs1) {
+		data->cs1 = devm_ioremap(&pdev->dev, cs1->start, PAGE_SIZE);
+		if (!data->cs1)
+			return -ENOMEM;
+		raw_cs1 = cs1->start;
+	} else {
+		data->cs1 = data->cs0 + cs1_offset;
+		raw_cs1 = cs0->start + cs1_offset;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq)
 		set_irq_type(irq, IRQT_RISING);
 
 	/* Setup expansion bus chip selects */
 	*data->cs0_cfg = data->cs0_bits;
-	*data->cs1_cfg = data->cs1_bits;
+	if (data->cs1_bits & IXP4XX_EXP_BUS_CS_EN)
+		*data->cs1_cfg = data->cs1_bits;
 
 	ap = host->ports[0];
 
@@ -213,7 +224,7 @@ static __devinit int ixp4xx_pata_probe(s
 	ap->pio_mask = 0x1f; /* PIO4 */
 	ap->flags |= ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY | ATA_FLAG_NO_ATAPI;
 
-	ixp4xx_setup_port(ap, data, cs0->start, cs1->start);
+	ixp4xx_setup_port(ap, data, cs0->start, raw_cs1);
 
 	dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
 
Index: 2.6.24/include/asm-arm/arch-ixp4xx/platform.h
===================================================================
--- 2.6.24/include/asm-arm/arch-ixp4xx/platform.h	(revision 3791)
+++ 2.6.24/include/asm-arm/arch-ixp4xx/platform.h	(working copy)
@@ -98,6 +98,7 @@ struct ixp4xx_pata_data {
 	unsigned long	cs1_bits;
 	void __iomem	*cs0;
 	void __iomem	*cs1;
+	unsigned long	cs1_offset;
 };
 
 struct ixp4xx_ide_port {
-- 
Hamish Moffatt VK3SB <hamish@debian.org> <hamish@cloud.net.au>
