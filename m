From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2] ata: ahci_st: fixup layering violations / drvdata errors
Date: Mon, 20 Apr 2015 14:41:05 +0100
Message-ID: <1429537265-22367-2-git-send-email-peter.griffin@linaro.org>
References: <1429537265-22367-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:35156 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbbDTNlO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Apr 2015 09:41:14 -0400
Received: by wgyo15 with SMTP id o15so179633504wgy.2
        for <linux-ide@vger.kernel.org>; Mon, 20 Apr 2015 06:41:12 -0700 (PDT)
In-Reply-To: <1429537265-22367-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, tj@kernel.org, computersforpeace@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, linux-ide@vger.kernel.org

Brian noticed while working on another SATA driver that uses libahci_platform,
an error in this driver; it tries to the the driver data for its
device, while libata also thinks it can set the driver data. See:

  ahci_platform_init_host()
  -> ata_host_alloc_pinfo()
     -> ata_host_alloc()
        -> dev_set_drvdata()

So instead of sticking the IP-specific platform data into drvdata, let's
use the plat_data variable that is reserved for this use.

Addtionally plat_data isn't set until ahci_platform_init_host() has been
called further down in probe(). So re-work the st_ahci_probe_resets and
st_ahci_deassert_resets functions to take ahci_host_priv *hpriv as a
parameter.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Suggested-by: Brian Norris <computersforpeace@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/ata/ahci_st.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index ea0ff00..8ff428f 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -37,7 +37,6 @@ struct st_ahci_drv_data {
 	struct reset_control *pwr;
 	struct reset_control *sw_rst;
 	struct reset_control *pwr_rst;
-	struct ahci_host_priv *hpriv;
 };
 
 static void st_ahci_configure_oob(void __iomem *mmio)
@@ -55,9 +54,10 @@ static void st_ahci_configure_oob(void __iomem *mmio)
 	writel(new_val, mmio + ST_AHCI_OOBR);
 }
 
-static int st_ahci_deassert_resets(struct device *dev)
+static int st_ahci_deassert_resets(struct ahci_host_priv *hpriv,
+				struct device *dev)
 {
-	struct st_ahci_drv_data *drv_data = dev_get_drvdata(dev);
+	struct st_ahci_drv_data *drv_data = hpriv->plat_data;
 	int err;
 
 	if (drv_data->pwr) {
@@ -90,8 +90,8 @@ static int st_ahci_deassert_resets(struct device *dev)
 static void st_ahci_host_stop(struct ata_host *host)
 {
 	struct ahci_host_priv *hpriv = host->private_data;
+	struct st_ahci_drv_data *drv_data = hpriv->plat_data;
 	struct device *dev = host->dev;
-	struct st_ahci_drv_data *drv_data = dev_get_drvdata(dev);
 	int err;
 
 	if (drv_data->pwr) {
@@ -103,29 +103,30 @@ static void st_ahci_host_stop(struct ata_host *host)
 	ahci_platform_disable_resources(hpriv);
 }
 
-static int st_ahci_probe_resets(struct platform_device *pdev)
+static int st_ahci_probe_resets(struct ahci_host_priv *hpriv,
+				struct device *dev)
 {
-	struct st_ahci_drv_data *drv_data = platform_get_drvdata(pdev);
+	struct st_ahci_drv_data *drv_data = hpriv->plat_data;
 
-	drv_data->pwr = devm_reset_control_get(&pdev->dev, "pwr-dwn");
+	drv_data->pwr = devm_reset_control_get(dev, "pwr-dwn");
 	if (IS_ERR(drv_data->pwr)) {
-		dev_info(&pdev->dev, "power reset control not defined\n");
+		dev_info(dev, "power reset control not defined\n");
 		drv_data->pwr = NULL;
 	}
 
-	drv_data->sw_rst = devm_reset_control_get(&pdev->dev, "sw-rst");
+	drv_data->sw_rst = devm_reset_control_get(dev, "sw-rst");
 	if (IS_ERR(drv_data->sw_rst)) {
-		dev_info(&pdev->dev, "soft reset control not defined\n");
+		dev_info(dev, "soft reset control not defined\n");
 		drv_data->sw_rst = NULL;
 	}
 
-	drv_data->pwr_rst = devm_reset_control_get(&pdev->dev, "pwr-rst");
+	drv_data->pwr_rst = devm_reset_control_get(dev, "pwr-rst");
 	if (IS_ERR(drv_data->pwr_rst)) {
-		dev_dbg(&pdev->dev, "power soft reset control not defined\n");
+		dev_dbg(dev, "power soft reset control not defined\n");
 		drv_data->pwr_rst = NULL;
 	}
 
-	return st_ahci_deassert_resets(&pdev->dev);
+	return st_ahci_deassert_resets(hpriv, dev);
 }
 
 static struct ata_port_operations st_ahci_port_ops = {
@@ -154,15 +155,12 @@ static int st_ahci_probe(struct platform_device *pdev)
 	if (!drv_data)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, drv_data);
-
 	hpriv = ahci_platform_get_resources(pdev);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
+	hpriv->plat_data = drv_data;
 
-	drv_data->hpriv = hpriv;
-
-	err = st_ahci_probe_resets(pdev);
+	err = st_ahci_probe_resets(hpriv, &pdev->dev);
 	if (err)
 		return err;
 
@@ -170,7 +168,7 @@ static int st_ahci_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	st_ahci_configure_oob(drv_data->hpriv->mmio);
+	st_ahci_configure_oob(hpriv->mmio);
 
 	err = ahci_platform_init_host(pdev, hpriv, &st_ahci_port_info,
 				      &ahci_platform_sht);
@@ -185,8 +183,9 @@ static int st_ahci_probe(struct platform_device *pdev)
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
@@ -208,21 +207,21 @@ static int st_ahci_suspend(struct device *dev)
 
 static int st_ahci_resume(struct device *dev)
 {
-	struct st_ahci_drv_data *drv_data = dev_get_drvdata(dev);
-	struct ahci_host_priv *hpriv = drv_data->hpriv;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
 	int err;
 
 	err = ahci_platform_enable_resources(hpriv);
 	if (err)
 		return err;
 
-	err = st_ahci_deassert_resets(dev);
+	err = st_ahci_deassert_resets(hpriv, dev);
 	if (err) {
 		ahci_platform_disable_resources(hpriv);
 		return err;
 	}
 
-	st_ahci_configure_oob(drv_data->hpriv->mmio);
+	st_ahci_configure_oob(hpriv->mmio);
 
 	return ahci_platform_resume_host(dev);
 }
-- 
1.9.1

