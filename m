From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/2] ata: ahci_st: remove deprecated struct ahci_platform_data
 usage
Date: Fri, 14 Mar 2014 19:21:59 +0100
Message-ID: <1561239.uqrRD3ZCZp@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:9631 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbaCNSWQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Mar 2014 14:22:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

struct ahci_platform_data is deprecated (please see comments in
<linux/ahci_platform.h> for details).  Convert ahci_st driver to
use custom ->host_stop method instead.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Compile tested only.

 drivers/ata/ahci_st.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

Index: b/drivers/ata/ahci_st.c
===================================================================
--- a/drivers/ata/ahci_st.c	2014-03-14 19:17:32.216568395 +0100
+++ b/drivers/ata/ahci_st.c	2014-03-14 19:18:27.912567444 +0100
@@ -87,10 +87,11 @@ static int st_ahci_deassert_resets(struc
 	return 0;
 }
 
-static void st_ahci_exit(struct device *dev)
+static void st_ahci_host_stop(struct ata_host *host)
 {
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct device *dev = host->dev;
 	struct st_ahci_drv_data *drv_data = dev_get_drvdata(dev);
-	struct ahci_host_priv *hpriv = drv_data->hpriv;
 	int err;
 
 	if (drv_data->pwr) {
@@ -127,17 +128,21 @@ static int st_ahci_probe_resets(struct p
 	return st_ahci_deassert_resets(&pdev->dev);
 }
 
+static struct ata_port_operations st_ahci_port_ops = {
+	.inherits	= &ahci_platform_ops,
+	.host_stop	= st_ahci_host_stop,
+};
+
 static const struct ata_port_info st_ahci_port_info = {
 	.flags          = AHCI_FLAG_COMMON,
 	.pio_mask       = ATA_PIO4,
 	.udma_mask      = ATA_UDMA6,
-	.port_ops       = &ahci_platform_ops,
+	.port_ops       = &st_ahci_port_ops,
 };
 
 static int st_ahci_probe(struct platform_device *pdev)
 {
 	struct st_ahci_drv_data *drv_data;
-	struct ahci_platform_data *pdata;
 	struct ahci_host_priv *hpriv;
 	int err;
 
@@ -147,13 +152,6 @@ static int st_ahci_probe(struct platform
 
 	platform_set_drvdata(pdev, drv_data);
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return -ENOMEM;
-
-	pdata->exit = st_ahci_exit;
-	pdev->dev.platform_data = pdata;
-
 	hpriv = ahci_platform_get_resources(pdev);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);

