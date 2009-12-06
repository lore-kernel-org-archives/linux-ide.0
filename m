From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH 2/6] sata_mv: support clkdev framework
Date: Sun,  6 Dec 2009 18:26:18 +0200
Message-ID: <1260116782-31714-2-git-send-email-saeed@marvell.com>
References: <1260116782-31714-1-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:50715 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932758AbZLFQ0U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Dec 2009 11:26:20 -0500
In-Reply-To: <1260116782-31714-1-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org
Cc: liml@rtr.ca, nico@fluxnic.net, buytenh@wantstofly.org, Saeed Bishara <saeed@marvell.com>

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 312c3e0..0906df4 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -59,6 +59,7 @@
 #include <linux/dmapool.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
 #include <linux/mbus.h>
@@ -548,6 +549,10 @@ struct mv_host_priv {
 	u32			irq_cause_offset;
 	u32			irq_mask_offset;
 	u32			unmask_all_irqs;
+
+#if defined(CONFIG_HAVE_CLK)
+	struct clk		*clk;
+#endif
 	/*
 	 * These consistent DMA memory pools give us guaranteed
 	 * alignment for hardware-accessed data structures,
@@ -4041,6 +4046,14 @@ static int mv_platform_probe(struct platform_device *pdev)
 				   resource_size(res));
 	hpriv->base -= SATAHC0_REG_BASE;
 
+#if defined(CONFIG_HAVE_CLK)
+	hpriv->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(hpriv->clk))
+		dev_notice(&pdev->dev, "cannot get clkdev\n");
+	else
+		clk_enable(hpriv->clk);
+#endif
+
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
@@ -4049,12 +4062,12 @@ static int mv_platform_probe(struct platform_device *pdev)
 
 	rc = mv_create_dma_pools(hpriv, &pdev->dev);
 	if (rc)
-		return rc;
+		goto err;
 
 	/* initialize adapter */
 	rc = mv_init_host(host, chip_soc);
 	if (rc)
-		return rc;
+		goto err;
 
 	dev_printk(KERN_INFO, &pdev->dev,
 		   "slots %u ports %d\n", (unsigned)MV_MAX_Q_DEPTH,
@@ -4062,6 +4075,15 @@ static int mv_platform_probe(struct platform_device *pdev)
 
 	return ata_host_activate(host, platform_get_irq(pdev, 0), mv_interrupt,
 				 IRQF_SHARED, &mv6_sht);
+err:
+#if defined(CONFIG_HAVE_CLK)
+	if (!IS_ERR(hpriv->clk)) {
+		clk_disable(hpriv->clk);
+		clk_put(hpriv->clk);
+	}
+#endif
+
+	return rc;
 }
 
 /*
@@ -4076,8 +4098,17 @@ static int __devexit mv_platform_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ata_host *host = dev_get_drvdata(dev);
-
+#if defined(CONFIG_HAVE_CLK)
+	struct mv_host_priv *hpriv = host->private_data;
+#endif
 	ata_host_detach(host);
+
+#if defined(CONFIG_HAVE_CLK)
+	if (!IS_ERR(hpriv->clk)) {
+		clk_disable(hpriv->clk);
+		clk_put(hpriv->clk);
+	}
+#endif
 	return 0;
 }
 
-- 
1.6.0.4

