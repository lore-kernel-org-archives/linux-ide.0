From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2] ATA: sata_mv: Remove unneeded CONFIG_HAVE_CLK ifdefs
Date: Mon, 29 Jul 2013 23:46:03 -0300
Message-ID: <1375152363-3451-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:51230 "EHLO
	mail.free-electrons.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753230Ab3G3CqD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jul 2013 22:46:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

If CONFIG_HAVE_CLK is not selected, then all the clk API turn out
into no-ops. In other words, there's no need to have the ifdefs.

The only side-effect of this patch is the extra tiny kmalloc,
but that's not enough reason to have such ugly ifdefs all around
the code.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Changes from v1:
 * Add a comment in struct mv_host_priv clarifying the optional clk fields.

 drivers/ata/sata_mv.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 10ea99a..231d510 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -553,10 +553,15 @@ struct mv_host_priv {
 	u32			irq_mask_offset;
 	u32			unmask_all_irqs;
 
-#if defined(CONFIG_HAVE_CLK)
+	/*
+	 * Needed on some devices that require their clocks to be enabled.
+	 * These are optional: if the platform device does not any clocks
+	 * they won't be used. Furthermore, if the underlying hardware does
+	 * not support the common clock framework (CONFIG_HAVE_CLK=n) then
+	 * all the clock operations become no-ops (see clk.h).
+	 */
 	struct clk		*clk;
 	struct clk              **port_clks;
-#endif
 	/*
 	 * These consistent DMA memory pools give us guaranteed
 	 * alignment for hardware-accessed data structures,
@@ -4032,9 +4037,7 @@ static int mv_platform_probe(struct platform_device *pdev)
 	struct resource *res;
 	int n_ports = 0, irq = 0;
 	int rc;
-#if defined(CONFIG_HAVE_CLK)
 	int port;
-#endif
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
 
@@ -4068,13 +4071,11 @@ static int mv_platform_probe(struct platform_device *pdev)
 
 	if (!host || !hpriv)
 		return -ENOMEM;
-#if defined(CONFIG_HAVE_CLK)
 	hpriv->port_clks = devm_kzalloc(&pdev->dev,
 					sizeof(struct clk *) * n_ports,
 					GFP_KERNEL);
 	if (!hpriv->port_clks)
 		return -ENOMEM;
-#endif
 	host->private_data = hpriv;
 	hpriv->n_ports = n_ports;
 	hpriv->board_idx = chip_soc;
@@ -4084,7 +4085,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 				   resource_size(res));
 	hpriv->base -= SATAHC0_REG_BASE;
 
-#if defined(CONFIG_HAVE_CLK)
 	hpriv->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hpriv->clk))
 		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
@@ -4098,7 +4098,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 		if (!IS_ERR(hpriv->port_clks[port]))
 			clk_prepare_enable(hpriv->port_clks[port]);
 	}
-#endif
 
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
@@ -4124,7 +4123,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 		return 0;
 
 err:
-#if defined(CONFIG_HAVE_CLK)
 	if (!IS_ERR(hpriv->clk)) {
 		clk_disable_unprepare(hpriv->clk);
 		clk_put(hpriv->clk);
@@ -4135,7 +4133,6 @@ err:
 			clk_put(hpriv->port_clks[port]);
 		}
 	}
-#endif
 
 	return rc;
 }
@@ -4151,13 +4148,10 @@ err:
 static int mv_platform_remove(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
-#if defined(CONFIG_HAVE_CLK)
 	struct mv_host_priv *hpriv = host->private_data;
 	int port;
-#endif
 	ata_host_detach(host);
 
-#if defined(CONFIG_HAVE_CLK)
 	if (!IS_ERR(hpriv->clk)) {
 		clk_disable_unprepare(hpriv->clk);
 		clk_put(hpriv->clk);
@@ -4168,7 +4162,6 @@ static int mv_platform_remove(struct platform_device *pdev)
 			clk_put(hpriv->port_clks[port]);
 		}
 	}
-#endif
 	return 0;
 }
 
-- 
1.8.1.5

