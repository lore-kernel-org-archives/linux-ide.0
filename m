From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 04/12] sata_rcar: Convert to clk_prepare/unprepare
Date: Mon, 28 Oct 2013 23:49:21 +0100
Message-ID: <1383000569-8916-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
clk_disable_unprepare() to get ready for the migration to the common
clock framework.

Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/ata/sata_rcar.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index c2d95e9..1dae9a9 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -792,7 +792,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get access to sata clock\n");
 		return PTR_ERR(priv->clk);
 	}
-	clk_enable(priv->clk);
+	clk_prepare_enable(priv->clk);
 
 	host = ata_host_alloc(&pdev->dev, 1);
 	if (!host) {
@@ -822,7 +822,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 		return 0;
 
 cleanup:
-	clk_disable(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	return ret;
 }
@@ -841,7 +841,7 @@ static int sata_rcar_remove(struct platform_device *pdev)
 	iowrite32(0, base + SATAINTSTAT_REG);
 	iowrite32(0x7ff, base + SATAINTMASK_REG);
 
-	clk_disable(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	return 0;
 }
@@ -861,7 +861,7 @@ static int sata_rcar_suspend(struct device *dev)
 		/* mask */
 		iowrite32(0x7ff, base + SATAINTMASK_REG);
 
-		clk_disable(priv->clk);
+		clk_disable_unprepare(priv->clk);
 	}
 
 	return ret;
@@ -873,7 +873,7 @@ static int sata_rcar_resume(struct device *dev)
 	struct sata_rcar_priv *priv = host->private_data;
 	void __iomem *base = priv->base;
 
-	clk_enable(priv->clk);
+	clk_prepare_enable(priv->clk);
 
 	/* ack and mask */
 	iowrite32(0, base + SATAINTSTAT_REG);
-- 
1.8.1.5

