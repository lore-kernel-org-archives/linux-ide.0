From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 07/14] pata_mpc52xx: utilize common ata_platform_remove_one()
Date: Fri,  2 Nov 2012 00:46:21 -0700
Message-ID: <1351842388-27210-8-git-send-email-computersforpeace@gmail.com>
References: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:43309 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab2KBHq7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2012 03:46:59 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1546133dak.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2012 00:46:58 -0700 (PDT)
In-Reply-To: <1351842388-27210-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Tejun Heo <tj@kernel.org>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/pata_mpc52xx.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index d2c102f..ec67f54 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -663,18 +663,6 @@ mpc52xx_ata_init_one(struct device *dev, struct mpc52xx_ata_priv *priv,
 				 &mpc52xx_ata_sht);
 }
 
-static struct mpc52xx_ata_priv *
-mpc52xx_ata_remove_one(struct device *dev)
-{
-	struct ata_host *host = dev_get_drvdata(dev);
-	struct mpc52xx_ata_priv *priv = host->private_data;
-
-	ata_host_detach(host);
-
-	return priv;
-}
-
-
 /* ======================================================================== */
 /* OF Platform driver                                                       */
 /* ======================================================================== */
@@ -815,11 +803,12 @@ mpc52xx_ata_probe(struct platform_device *op)
 static int
 mpc52xx_ata_remove(struct platform_device *op)
 {
-	struct mpc52xx_ata_priv *priv;
+	struct ata_host *host = platform_get_drvdata(op);
+	struct mpc52xx_ata_priv *priv = host->private_data;
 	int task_irq;
 
 	/* Deregister the ATA interface */
-	priv = mpc52xx_ata_remove_one(&op->dev);
+	ata_platform_remove_one(op);
 
 	/* Clean up DMA */
 	task_irq = bcom_get_task_irq(priv->dmatsk);
-- 
1.7.11.3

