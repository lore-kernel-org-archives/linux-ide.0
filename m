From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ata: pata_imx: Check the return value from clk_prepare_enable()
Date: Sat, 25 Jan 2014 19:46:23 -0200
Message-ID: <1390686383-13790-1-git-send-email-festevam@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gg0-f175.google.com ([209.85.161.175]:47553 "EHLO
	mail-gg0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbaAYVqp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Jan 2014 16:46:45 -0500
Received: by mail-gg0-f175.google.com with SMTP id c2so1699061ggn.34
        for <linux-ide@vger.kernel.org>; Sat, 25 Jan 2014 13:46:44 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so let's check its return value and propagate it
in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/ata/pata_imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 97417d5..7e69797 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -118,7 +118,9 @@ static int pata_imx_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->clk);
 	}
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	host = ata_host_alloc(&pdev->dev, 1);
 	if (!host) {
@@ -211,7 +213,9 @@ static int pata_imx_resume(struct device *dev)
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct pata_imx_priv *priv = host->private_data;
 
-	clk_prepare_enable(priv->clk);
+	int ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	__raw_writel(priv->ata_ctl, priv->host_regs + PATA_IMX_ATA_CONTROL);
 
-- 
1.8.1.2

