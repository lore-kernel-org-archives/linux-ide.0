From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3/5] ahci: st: Utilise ata_platform_remove_one() call
Date: Wed, 12 Mar 2014 12:39:40 +0000
Message-ID: <1394627982-23726-4-git-send-email-lee.jones@linaro.org>
References: <1394627982-23726-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:42168 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbaCLMkL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2014 08:40:11 -0400
Received: by mail-we0-f169.google.com with SMTP id w62so11375852wes.14
        for <linux-ide@vger.kernel.org>; Wed, 12 Mar 2014 05:40:10 -0700 (PDT)
In-Reply-To: <1394627982-23726-1-git-send-email-lee.jones@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tj@kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org

ata_platform_remove_one() allows us to specify our own exit function
via platform data then goes off and removes ATA Host and Port in
preparation for device removal.

Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/ahci_st.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index a28532a..3edec5d 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -87,6 +87,23 @@ static int st_ahci_deassert_resets(struct device *dev)
 	return 0;
 }
 
+static int st_ahci_exit(struct device *dev)
+{
+	struct st_ahci_drv_data *drv_data = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = drv_data->hpriv;
+	int err;
+
+	if (drv_data->pwr) {
+		err = reset_control_assert(drv_data->pwr);
+		if (err)
+			dev_err(&pdev->dev, "unable to pwrdwn\n");
+	}
+
+	ahci_platform_disable_resources(hpriv);
+
+	return 0;
+}
+
 static int st_ahci_probe_resets(struct platform_device *pdev)
 {
 	struct st_ahci_drv_data *drv_data = platform_get_drvdata(pdev);
@@ -122,6 +139,7 @@ static const struct ata_port_info st_ahci_port_info = {
 static int st_ahci_probe(struct platform_device *pdev)
 {
 	struct st_ahci_drv_data *drv_data;
+	struct ahci_platform_data *pdata;
 	struct ahci_host_priv *hpriv;
 	int err;
 
@@ -131,6 +149,13 @@ static int st_ahci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, drv_data);
 
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->exit = st_ahci_exit;
+	pdev->dev.platform_data = pdata;
+
 	hpriv = ahci_platform_get_resources(pdev);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
@@ -154,23 +179,6 @@ static int st_ahci_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int st_ahci_remove(struct platform_device *pdev)
-{
-	struct st_ahci_drv_data *drv_data = platform_get_drvdata(pdev);
-	struct ahci_host_priv *hpriv = drv_data->hpriv;
-	int err;
-
-	if (drv_data->pwr) {
-		err = reset_control_assert(drv_data->pwr);
-		if (err)
-			dev_err(&pdev->dev, "unable to pwrdwn\n");
-	}
-
-	ahci_platform_disable_resources(hpriv);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int st_ahci_suspend(struct device *dev)
 {
@@ -227,7 +235,7 @@ static struct platform_driver st_ahci_driver = {
 		.of_match_table = of_match_ptr(st_ahci_match),
 	},
 	.probe = st_ahci_probe,
-	.remove = st_ahci_remove,
+	.remove = ata_platform_remove_one,
 };
 module_platform_driver(st_ahci_driver);
 
-- 
1.8.3.2

