From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v1] ata: sata_rcar: Handle return value of clk_prepare_enable
Date: Tue,  9 May 2017 16:00:28 +0530
Message-ID: <1494325828-2725-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35993 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdEIKbg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 May 2017 06:31:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Here, Clock enable can failed. So adding an error check for
clk_prepare_enable.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/ata/sata_rcar.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 5d38245..7e789c1 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -890,7 +890,9 @@ static int sata_rcar_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get access to sata clock\n");
 		return PTR_ERR(priv->clk);
 	}
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	host = ata_host_alloc(&pdev->dev, 1);
 	if (!host) {
@@ -971,7 +973,9 @@ static int sata_rcar_resume(struct device *dev)
 	struct sata_rcar_priv *priv = host->private_data;
 	void __iomem *base = priv->base;
 
-	clk_prepare_enable(priv->clk);
+	int ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	/* ack and mask */
 	iowrite32(0, base + SATAINTSTAT_REG);
@@ -989,7 +993,9 @@ static int sata_rcar_restore(struct device *dev)
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct sata_rcar_priv *priv = host->private_data;
 
-	clk_prepare_enable(priv->clk);
+	int ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	sata_rcar_setup_port(host);
 
-- 
1.9.1

