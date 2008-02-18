From: Saeed Bishara <saeed@marvell.com>
Subject: [PATCH] sata_mv: remove iounmap in mv_platform_remove and use devm_iomap
Date: Mon, 18 Feb 2008 07:42:28 -1100
Message-ID: <12033601481951-git-send-email-saeed@marvell.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host2.marvell.com ([65.219.4.2]:33342 "EHLO maili.marvell.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752178AbYBRP6A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Feb 2008 10:58:00 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mlord@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org
Cc: saeed.bishara@gmail.com, saeed@marvell.com, byron.bbradley@gmail.com, tbm@cyrius.com

this will fix crash bug when doing rmmod to the driver, this is because the
port_stop function get called later and it could access the device's registers.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 drivers/ata/sata_mv.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 9c9a5b0..f510448 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2951,7 +2951,8 @@ static int mv_platform_probe(struct platform_device *pdev)
 	hpriv->n_ports = n_ports;
 
 	host->iomap = NULL;
-	hpriv->base = ioremap(res->start, res->end - res->start + 1);
+	hpriv->base = devm_ioremap(&pdev->dev, res->start,
+				   res->end - res->start + 1);
 	hpriv->base -= MV_SATAHC0_REG_BASE;
 
 	rc = mv_create_dma_pools(hpriv, &pdev->dev);
@@ -2983,11 +2984,8 @@ static int __devexit mv_platform_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ata_host *host = dev_get_drvdata(dev);
-	struct mv_host_priv *hpriv = host->private_data;
-	void __iomem *base = hpriv->base;
 
 	ata_host_detach(host);
-	iounmap(base);
 	return 0;
 }
 
-- 
1.5.2.5

