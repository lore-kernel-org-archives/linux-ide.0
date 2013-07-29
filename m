From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH] ATA: sata_mv: Remove uneeded CONFIG_HAVE_CLK ifdefs
Date: Mon, 29 Jul 2013 12:21:22 -0300
Message-ID: <1375111282-22624-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1375111282-22624-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375111282-22624-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, tj@kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

If CONFIG_HAVE_CLK is not selected, then all the clk API turn out
into stubs, so there's no need to have the ifdefs.
The only side-effect of this patch is the extra tiny kmalloc,
but that's not enough reason to have such ugly ifdefs all around
the code.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/ata/sata_mv.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 10ea99a..3519987 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -553,10 +553,8 @@ struct mv_host_priv {
 	u32			irq_mask_offset;
 	u32			unmask_all_irqs;
 
-#if defined(CONFIG_HAVE_CLK)
 	struct clk		*clk;
 	struct clk              **port_clks;
-#endif
 	/*
 	 * These consistent DMA memory pools give us guaranteed
 	 * alignment for hardware-accessed data structures,
@@ -4032,9 +4030,7 @@ static int mv_platform_probe(struct platform_device *pdev)
 	struct resource *res;
 	int n_ports = 0, irq = 0;
 	int rc;
-#if defined(CONFIG_HAVE_CLK)
 	int port;
-#endif
 
 	ata_print_version_once(&pdev->dev, DRV_VERSION);
 
@@ -4068,13 +4064,11 @@ static int mv_platform_probe(struct platform_device *pdev)
 
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
@@ -4084,7 +4078,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 				   resource_size(res));
 	hpriv->base -= SATAHC0_REG_BASE;
 
-#if defined(CONFIG_HAVE_CLK)
 	hpriv->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hpriv->clk))
 		dev_notice(&pdev->dev, "cannot get optional clkdev\n");
@@ -4098,7 +4091,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 		if (!IS_ERR(hpriv->port_clks[port]))
 			clk_prepare_enable(hpriv->port_clks[port]);
 	}
-#endif
 
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
@@ -4124,7 +4116,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 		return 0;
 
 err:
-#if defined(CONFIG_HAVE_CLK)
 	if (!IS_ERR(hpriv->clk)) {
 		clk_disable_unprepare(hpriv->clk);
 		clk_put(hpriv->clk);
@@ -4135,7 +4126,6 @@ err:
 			clk_put(hpriv->port_clks[port]);
 		}
 	}
-#endif
 
 	return rc;
 }
@@ -4151,13 +4141,10 @@ err:
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
@@ -4168,7 +4155,6 @@ static int mv_platform_remove(struct platform_device *pdev)
 			clk_put(hpriv->port_clks[port]);
 		}
 	}
-#endif
 	return 0;
 }
 
-- 
1.8.1.5
