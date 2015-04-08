From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] ata: ahci_st: fixup layering violations / drvdata errors
Date: Wed,  8 Apr 2015 11:59:59 -0700
Message-ID: <1428519599-31885-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33344 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbbDHTAR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2015 15:00:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, kernel@stlinux.com, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>

When working on another SATA driver that uses libahci_platform, I
noticed an error in this driver; it tries to the the driver data for its
device, while libata also thinks it can set the driver data. See:

  ahci_platform_init_host()
  -> ata_host_alloc_pinfo()
     -> ata_host_alloc()
        -> dev_set_drvdata()

So instead of sticking the IP-specific platform data into drvdata, let's
use the plat_data variable that is reserved for this use.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
---
This is ONLY compile tested; I don't have hardware to run. This looks like it
could have ramifications on suspend/resume support, and hot device removal
(e.g., sysfs unbind), so it might qualify as -stable, if someone can test it

 drivers/ata/ahci_st.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index bc971af262e7..2bd2375c2ab1 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -37,7 +37,6 @@ struct st_ahci_drv_data {
 	struct reset_control *pwr;
 	struct reset_control *sw_rst;
 	struct reset_control *pwr_rst;
-	struct ahci_host_priv *hpriv;
 };
 
 static void st_ahci_configure_oob(void __iomem *mmio)
@@ -57,7 +56,9 @@ static void st_ahci_configure_oob(void __iomem *mmio)
 
 static int st_ahci_deassert_resets(struct device *dev)
 {
-	struct st_ahci_drv_data *drv_data = dev_get_drvdata(dev);
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct st_ahci_drv_data *drv_data = hpriv->plat_data;
 	int err;
 
 	if (drv_data->pwr) {
@@ -68,7 +69,7 @@ static int st_ahci_deassert_resets(struct device *dev)
 		}
 	}
 
-	st_ahci_configure_oob(drv_data->hpriv->mmio);
+	st_ahci_configure_oob(hpriv->mmio);
 
 	if (drv_data->sw_rst) {
 		err = reset_control_deassert(drv_data->sw_rst);
@@ -92,8 +93,8 @@ static int st_ahci_deassert_resets(struct device *dev)
 static void st_ahci_host_stop(struct ata_host *host)
 {
 	struct ahci_host_priv *hpriv = host->private_data;
+	struct st_ahci_drv_data *drv_data = hpriv->plat_data;
 	struct device *dev = host->dev;
-	struct st_ahci_drv_data *drv_data = dev_get_drvdata(dev);
 	int err;
 
 	if (drv_data->pwr) {
@@ -107,7 +108,9 @@ static void st_ahci_host_stop(struct ata_host *host)
 
 static int st_ahci_probe_resets(struct platform_device *pdev)
 {
-	struct st_ahci_drv_data *drv_data = platform_get_drvdata(pdev);
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct st_ahci_drv_data *drv_data = hpriv->plat_data;
 
 	drv_data->pwr = devm_reset_control_get(&pdev->dev, "pwr-dwn");
 	if (IS_ERR(drv_data->pwr)) {
@@ -161,8 +164,7 @@ static int st_ahci_probe(struct platform_device *pdev)
 	hpriv = ahci_platform_get_resources(pdev);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
-
-	drv_data->hpriv = hpriv;
+	hpriv->plat_data = drv_data;
 
 	err = st_ahci_probe_resets(pdev);
 	if (err)
@@ -185,8 +187,9 @@ static int st_ahci_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int st_ahci_suspend(struct device *dev)
 {
-	struct st_ahci_drv_data *drv_data = dev_get_drvdata(dev);
-	struct ahci_host_priv *hpriv = drv_data->hpriv;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct st_ahci_drv_data *drv_data = hpriv->plat_data;
 	int err;
 
 	err = ahci_platform_suspend_host(dev);
@@ -208,8 +211,8 @@ static int st_ahci_suspend(struct device *dev)
 
 static int st_ahci_resume(struct device *dev)
 {
-	struct st_ahci_drv_data *drv_data = dev_get_drvdata(dev);
-	struct ahci_host_priv *hpriv = drv_data->hpriv;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
 	int err;
 
 	err = ahci_platform_enable_resources(hpriv);
-- 
1.9.1

