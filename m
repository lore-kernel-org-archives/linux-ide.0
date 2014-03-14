From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] ata: ahci_st: build fixes
Date: Fri, 14 Mar 2014 19:20:58 +0100
Message-ID: <1848075.ERJNt1KrUa@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49455 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672AbaCNSVO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Mar 2014 14:21:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* The config option for ahci_st driver was renamed from
  CONFIG_SATA_AHCI_ST to CONFIG_AHCI_ST but Makefile was
  not updated.  Fix it (also while at it move the ahci_st
  driver entry below ahci_imx and ahci_sunxi ones).

* Fix a few build issues in the ahci_st driver itself.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Makefile  |    2 +-
 drivers/ata/ahci_st.c |   12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

Index: b/drivers/ata/Makefile
===================================================================
--- a/drivers/ata/Makefile	2014-03-14 16:45:04.036724382 +0100
+++ b/drivers/ata/Makefile	2014-03-14 19:07:02.304579137 +0100
@@ -5,7 +5,6 @@ obj-$(CONFIG_ATA)		+= libata.o
 obj-$(CONFIG_SATA_AHCI)		+= ahci.o libahci.o
 obj-$(CONFIG_SATA_ACARD_AHCI)	+= acard-ahci.o libahci.o
 obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platform.o libahci.o
-obj-$(CONFIG_SATA_AHCI_ST)      += ahci_st.o
 obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
 obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
@@ -13,6 +12,7 @@ obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460e
 obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
 obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o
 obj-$(CONFIG_AHCI_SUNXI)	+= ahci_sunxi.o
+obj-$(CONFIG_AHCI_ST)		+= ahci_st.o
 
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
Index: b/drivers/ata/ahci_st.c
===================================================================
--- a/drivers/ata/ahci_st.c	2014-03-14 19:03:11.368583073 +0100
+++ b/drivers/ata/ahci_st.c	2014-03-14 19:13:53.900572116 +0100
@@ -87,7 +87,7 @@ static int st_ahci_deassert_resets(struc
 	return 0;
 }
 
-static int st_ahci_exit(struct device *dev)
+static void st_ahci_exit(struct device *dev)
 {
 	struct st_ahci_drv_data *drv_data = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = drv_data->hpriv;
@@ -96,12 +96,10 @@ static int st_ahci_exit(struct device *d
 	if (drv_data->pwr) {
 		err = reset_control_assert(drv_data->pwr);
 		if (err)
-			dev_err(&pdev->dev, "unable to pwrdwn\n");
+			dev_err(dev, "unable to pwrdwn\n");
 	}
 
 	ahci_platform_disable_resources(hpriv);
-
-	return 0;
 }
 
 static int st_ahci_probe_resets(struct platform_device *pdev)
@@ -186,9 +184,9 @@ static int st_ahci_suspend(struct device
 	struct ahci_host_priv *hpriv = drv_data->hpriv;
 	int err;
 
-	ret = ahci_platform_suspend_host(dev);
-	if (ret)
-		return ret;
+	err = ahci_platform_suspend_host(dev);
+	if (err)
+		return err;
 
 	if (drv_data->pwr) {
 		err = reset_control_assert(drv_data->pwr);

