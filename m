From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [v3] ahci: imx: setup power saving methods
Date: Fri, 11 Oct 2013 18:37:11 +0800
Message-ID: <1381487831-30090-2-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1381487831-30090-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:59738 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab3JKKdS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Oct 2013 06:33:18 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so4032486pbb.28
        for <linux-ide@vger.kernel.org>; Fri, 11 Oct 2013 03:33:17 -0700 (PDT)
In-Reply-To: <1381487831-30090-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, tj@kernel.org, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

From: Richard Zhu <r65037@freescale.com>

In order to save power consumption amap.
* Disable sata phy internal pll reference clock when
sysetem enter into suspend mode, enable it after resume.
* Enter into test power down mode(PDDQ) and don't support
hot-plug feature anymore, when there is no device detected
on the port.

NOTE:
- The hot-plug can't be supported when PDDQ mode is
ever enabled.
- module parameter usage how-to:
  * default: enable PDDQ mode when no device detected.
  * add "ahci-imx.hotplug=1" into kernel command line if
  your don't want to enable PDDQ mode when no device
  detected on the port.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/ata/ahci_imx.c |  125 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 58debb0..58cdff74 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -1,6 +1,6 @@
 /*
+ * copyright (c) 2013 Freescale Semiconductor, Inc.
  * Freescale IMX AHCI SATA platform driver
- * Copyright 2013 Freescale Semiconductor, Inc.
  *
  * based on the AHCI SATA platform driver by Jeff Garzik and Anton Vorontsov
  *
@@ -25,9 +25,17 @@
 #include <linux/of_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
+#include <linux/libata.h>
 #include "ahci.h"
 
+static void ahci_imx_error_handler(struct ata_port *ap);
+static void ahci_host_stop(struct ata_host *host);
+
 enum {
+	/* Port0 PHY Control */
+	PORT_PHY_CTL = 0x178,
+	/* PORT_PHY_CTL bits */
+	PORT_PHY_CTL_PDDQ_LOC = 0x100000,
 	HOST_TIMER1MS = 0xe0, /* Timer 1-ms */
 };
 
@@ -36,12 +44,85 @@ struct imx_ahci_priv {
 	struct clk *sata_ref_clk;
 	struct clk *ahb_clk;
 	struct regmap *gpr;
+	bool no_device;
+	bool first_time;
+};
+
+static struct ata_port_operations ahci_imx_ops = {
+	.inherits	= &ahci_ops,
+	.host_stop	= ahci_host_stop,
+	.error_handler	= ahci_imx_error_handler,
+};
+
+static const struct ata_port_info ahci_imx_port_info = {
+	.flags		= AHCI_FLAG_COMMON,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &ahci_imx_ops,
 };
 
+static int ahci_imx_hotplug;
+module_param_named(hotplug, ahci_imx_hotplug, int, 0644);
+MODULE_PARM_DESC(hotplug, "AHCI IMX hot-plug support (0=Don't support, 1=support)");
+
+static void ahci_imx_error_handler(struct ata_port *ap)
+{
+	u32 reg_val;
+	struct ata_device *dev;
+	struct ata_host *host = dev_get_drvdata(ap->dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	void __iomem *mmio = hpriv->mmio;
+	struct imx_ahci_priv *imxpriv = dev_get_drvdata(ap->dev->parent);
+
+	/* wrapper of the ahci_error_handler */
+	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
+		/* restart engine */
+		ahci_stop_engine(ap);
+		ahci_start_engine(ap);
+	}
+
+	sata_pmp_error_handler(ap);
+
+	if (!ata_dev_enabled(ap->link.device))
+		ahci_stop_engine(ap);
+	/* end of wrapper */
+
+	if (!(imxpriv->first_time) || ahci_imx_hotplug)
+		return;
+
+	imxpriv->first_time = false;
+
+	ata_for_each_dev(dev, &ap->link, ENABLED)
+		return;
+	/* DISABLE LINK to save power consumption */
+	reg_val = readl(mmio + PORT_PHY_CTL);
+	writel(reg_val | PORT_PHY_CTL_PDDQ_LOC, mmio + PORT_PHY_CTL);
+	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
+			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+	clk_disable_unprepare(imxpriv->sata_ref_clk);
+	imxpriv->no_device = true;
+}
+
+static void ahci_host_stop(struct ata_host *host)
+{
+	struct device *dev = host->dev;
+	struct ahci_platform_data *pdata = dev_get_platdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+
+	if (pdata && pdata->exit)
+		pdata->exit(dev);
+
+	if (!IS_ERR(hpriv->clk)) {
+		clk_disable_unprepare(hpriv->clk);
+		clk_put(hpriv->clk);
+	}
+}
+
 static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
 {
 	int ret = 0;
-	unsigned int reg_val;
+	u32 reg_val;
 	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
 
 	imxpriv->gpr =
@@ -117,9 +198,47 @@ static void imx6q_sata_exit(struct device *dev)
 	clk_disable_unprepare(imxpriv->sata_ref_clk);
 }
 
+static int imx_ahci_suspend(struct device *dev)
+{
+	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
+
+	if (!(imxpriv->no_device)) {
+		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
+				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+				!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+		clk_disable_unprepare(imxpriv->sata_ref_clk);
+	}
+
+	return 0;
+}
+
+static int imx_ahci_resume(struct device *dev)
+{
+	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
+	int ret;
+
+	if (!(imxpriv->no_device)) {
+		ret = clk_prepare_enable(imxpriv->sata_ref_clk);
+		if (ret < 0) {
+			dev_err(dev, "pre-enable sata_ref clock err:%d\n", ret);
+			return ret;
+		}
+
+		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
+				IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+				IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+		usleep_range(1000, 2000);
+	}
+
+	return 0;
+}
+
 static struct ahci_platform_data imx6q_sata_pdata = {
 	.init = imx6q_sata_init,
 	.exit = imx6q_sata_exit,
+	.ata_port_info = &ahci_imx_port_info,
+	.suspend = imx_ahci_suspend,
+	.resume = imx_ahci_resume,
 };
 
 static const struct of_device_id imx_ahci_of_match[] = {
@@ -152,6 +271,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	ahci_dev = &ahci_pdev->dev;
 	ahci_dev->parent = dev;
 
+	imxpriv->no_device = false;
+	imxpriv->first_time = true;
 	imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
 	if (IS_ERR(imxpriv->ahb_clk)) {
 		dev_err(dev, "can't get ahb clock.\n");
-- 
1.7.5.4

