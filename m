From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] ata: use platform_{get,set}_drvdata()
Date: Thu, 23 May 2013 19:41:21 +0900
Message-ID: <003001ce57a2$10bbbaa0$32332fe0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38385 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758098Ab3EWKlZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 May 2013 06:41:25 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MN800D0OZ0WVO90@mailout1.samsung.com> for
 linux-ide@vger.kernel.org; Thu, 23 May 2013 19:41:24 +0900 (KST)
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Viresh Kumar <viresh.linux@gmail.com>, Jingoo Han <jg1.han@samsung.com>

Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
so we can directly pass a struct platform_device.

Also, unnecessary dev_set_drvdata() is removed, because the driver core
clears the driver data to NULL after device_release or on probe failure.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/ata/pata_arasan_cf.c |    2 +-
 drivers/ata/pata_at91.c      |    2 +-
 drivers/ata/pata_bf54x.c     |   10 ++++------
 drivers/ata/pata_imx.c       |    2 +-
 drivers/ata/pata_mpc52xx.c   |    4 ++--
 drivers/ata/pata_pxa.c       |    2 +-
 drivers/ata/sata_fsl.c       |   14 +++++---------
 drivers/ata/sata_rcar.c      |    2 +-
 8 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 7638121..848ed32 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -908,7 +908,7 @@ free_clk:
 
 static int arasan_cf_remove(struct platform_device *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = platform_get_drvdata(pdev);
 	struct arasan_cf_dev *acdev = host->ports[0]->private_data;
 
 	ata_host_detach(host);
diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index 033f3f4..5364f97 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -422,7 +422,7 @@ err_put:
 
 static int pata_at91_remove(struct platform_device *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = platform_get_drvdata(pdev);
 	struct at91_ide_info *info;
 
 	if (!host)
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 8d43510..ba0d8a2 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1596,7 +1596,7 @@ static int bfin_atapi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	dev_set_drvdata(&pdev->dev, host);
+	platform_set_drvdata(pdev, host);
 
 	return 0;
 }
@@ -1610,11 +1610,9 @@ static int bfin_atapi_probe(struct platform_device *pdev)
  */
 static int bfin_atapi_remove(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct ata_host *host = dev_get_drvdata(dev);
+	struct ata_host *host = platform_get_drvdata(pdev);
 
 	ata_host_detach(host);
-	dev_set_drvdata(&pdev->dev, NULL);
 
 	peripheral_free_list(atapi_io_port);
 
@@ -1624,7 +1622,7 @@ static int bfin_atapi_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int bfin_atapi_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = platform_get_drvdata(pdev);
 	if (host)
 		return ata_host_suspend(host, state);
 	else
@@ -1633,7 +1631,7 @@ static int bfin_atapi_suspend(struct platform_device *pdev, pm_message_t state)
 
 static int bfin_atapi_resume(struct platform_device *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = platform_get_drvdata(pdev);
 	int ret;
 
 	if (host) {
diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index aa3d166..4ec7c04 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -177,7 +177,7 @@ err:
 
 static int pata_imx_remove(struct platform_device *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = platform_get_drvdata(pdev);
 	struct pata_imx_priv *priv = host->private_data;
 
 	ata_host_detach(host);
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index 3a8fb28..0024ced 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -825,7 +825,7 @@ mpc52xx_ata_remove(struct platform_device *op)
 static int
 mpc52xx_ata_suspend(struct platform_device *op, pm_message_t state)
 {
-	struct ata_host *host = dev_get_drvdata(&op->dev);
+	struct ata_host *host = platform_get_drvdata(op);
 
 	return ata_host_suspend(host, state);
 }
@@ -833,7 +833,7 @@ mpc52xx_ata_suspend(struct platform_device *op, pm_message_t state)
 static int
 mpc52xx_ata_resume(struct platform_device *op)
 {
-	struct ata_host *host = dev_get_drvdata(&op->dev);
+	struct ata_host *host = platform_get_drvdata(op);
 	struct mpc52xx_ata_priv *priv = host->private_data;
 	int rv;
 
diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index b0ac9e0..942ef94 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -371,7 +371,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
 
 static int pxa_ata_remove(struct platform_device *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = platform_get_drvdata(pdev);
 	struct pata_pxa_data *data = host->ports[0]->private_data;
 
 	pxa_free_dma(data->dma_channel);
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index d40e403..19720a0 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1532,7 +1532,7 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 	ata_host_activate(host, irq, sata_fsl_interrupt, SATA_FSL_IRQ_FLAG,
 			  &sata_fsl_sht);
 
-	dev_set_drvdata(&ofdev->dev, host);
+	platform_set_drvdata(ofdev, host);
 
 	host_priv->intr_coalescing.show = fsl_sata_intr_coalescing_show;
 	host_priv->intr_coalescing.store = fsl_sata_intr_coalescing_store;
@@ -1558,10 +1558,8 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 
 error_exit_with_cleanup:
 
-	if (host) {
-		dev_set_drvdata(&ofdev->dev, NULL);
+	if (host)
 		ata_host_detach(host);
-	}
 
 	if (hcr_base)
 		iounmap(hcr_base);
@@ -1572,7 +1570,7 @@ error_exit_with_cleanup:
 
 static int sata_fsl_remove(struct platform_device *ofdev)
 {
-	struct ata_host *host = dev_get_drvdata(&ofdev->dev);
+	struct ata_host *host = platform_get_drvdata(ofdev);
 	struct sata_fsl_host_priv *host_priv = host->private_data;
 
 	device_remove_file(&ofdev->dev, &host_priv->intr_coalescing);
@@ -1580,8 +1578,6 @@ static int sata_fsl_remove(struct platform_device *ofdev)
 
 	ata_host_detach(host);
 
-	dev_set_drvdata(&ofdev->dev, NULL);
-
 	irq_dispose_mapping(host_priv->irq);
 	iounmap(host_priv->hcr_base);
 	kfree(host_priv);
@@ -1592,13 +1588,13 @@ static int sata_fsl_remove(struct platform_device *ofdev)
 #ifdef CONFIG_PM
 static int sata_fsl_suspend(struct platform_device *op, pm_message_t state)
 {
-	struct ata_host *host = dev_get_drvdata(&op->dev);
+	struct ata_host *host = platform_get_drvdata(op);
 	return ata_host_suspend(host, state);
 }
 
 static int sata_fsl_resume(struct platform_device *op)
 {
-	struct ata_host *host = dev_get_drvdata(&op->dev);
+	struct ata_host *host = platform_get_drvdata(op);
 	struct sata_fsl_host_priv *host_priv = host->private_data;
 	int ret;
 	void __iomem *hcr_base = host_priv->hcr_base;
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index a8e091a..0968cf2 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -826,7 +826,7 @@ cleanup:
 
 static int sata_rcar_remove(struct platform_device *pdev)
 {
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ata_host *host = platform_get_drvdata(pdev);
 	struct sata_rcar_priv *priv = host->private_data;
 
 	ata_host_detach(host);
-- 
1.7.10.4


