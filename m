From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH 2/3] sata_mv: support clkdev framework
Date: Tue, 23 Jun 2009 18:43:57 +0300
Message-ID: <1245771838-1332-2-git-send-email-saeed@marvell.com>
References: <1245771838-1332-1-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:6241 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759079AbZFWPoA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Jun 2009 11:44:00 -0400
In-Reply-To: <1245771838-1332-1-git-send-email-saeed@marvell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, liml@rtr.ca
Cc: saeed.bishara@gmail.com, Saeed Bishara <saeed@marvell.com>


Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)
 mode change 100644 => 100755 drivers/ata/sata_mv.c

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
old mode 100644
new mode 100755
index 644436e..ca9157d
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
@@ -4016,6 +4021,14 @@ static int mv_platform_probe(struct platform_device *pdev)
 				   res->end - res->start + 1);
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
@@ -4024,12 +4037,12 @@ static int mv_platform_probe(struct platform_device *pdev)
 
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
@@ -4037,6 +4050,15 @@ static int mv_platform_probe(struct platform_device *pdev)
 
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
@@ -4051,8 +4073,17 @@ static int __devexit mv_platform_remove(struct platform_device *pdev)
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

