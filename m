From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [v4] ahci: imx: setup power saving methods
Date: Tue, 15 Oct 2013 10:44:54 +0800
Message-ID: <1381805094-14723-2-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1381805094-14723-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:46115 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab3JOCk5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Oct 2013 22:40:57 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so8389351pad.14
        for <linux-ide@vger.kernel.org>; Mon, 14 Oct 2013 19:40:56 -0700 (PDT)
In-Reply-To: <1381805094-14723-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, tj@kernel.org, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

From: Richard Zhu <r65037@freescale.com>

In order to save power consumption amap.
* Disable sata phy internal pll reference clock when
sysetem enter into suspend mode, enable it after resume.
* Setup module parameter used to enable imx ahci test power down
mode(PDDQ) or not, when there is no device detected on the port
* minor modifications:
  - The format of the copyright is changed, because that the
  original one can't pass fsl internal patch reivew without
  the character '(c)'.
  - exports ahci_platform_ops and ahci_error_handler

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
 drivers/ata/ahci.h          |    2 +
 drivers/ata/ahci_imx.c      |  101 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/ahci_platform.c |    3 +-
 drivers/ata/libahci.c       |    4 +-
 4 files changed, 105 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 1145637..2289efd 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -339,6 +339,7 @@ extern struct device_attribute *ahci_sdev_attrs[];
 	.sdev_attrs		= ahci_sdev_attrs
 
 extern struct ata_port_operations ahci_ops;
+extern struct ata_port_operations ahci_platform_ops;
 extern struct ata_port_operations ahci_pmp_retry_srst_ops;
 
 unsigned int ahci_dev_classify(struct ata_port *ap);
@@ -368,6 +369,7 @@ irqreturn_t ahci_hw_interrupt(int irq, void *dev_instance);
 irqreturn_t ahci_thread_fn(int irq, void *dev_instance);
 void ahci_print_info(struct ata_host *host, const char *scc_s);
 int ahci_host_activate(struct ata_host *host, int irq, unsigned int n_msis);
+void ahci_error_handler(struct ata_port *ap);
 
 static inline void __iomem *__ahci_port_base(struct ata_host *host,
 					     unsigned int port_no)
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 58debb0..733d097 100644
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
@@ -25,10 +25,13 @@
 #include <linux/of_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
+#include <linux/libata.h>
 #include "ahci.h"
 
 enum {
-	HOST_TIMER1MS = 0xe0, /* Timer 1-ms */
+	PORT_PHY_CTL = 0x178,			/* Port0 PHY Control */
+	PORT_PHY_CTL_PDDQ_LOC = 0x100000,	/* PORT_PHY_CTL bits */
+	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
 };
 
 struct imx_ahci_priv {
@@ -36,6 +39,56 @@ struct imx_ahci_priv {
 	struct clk *sata_ref_clk;
 	struct clk *ahb_clk;
 	struct regmap *gpr;
+	bool no_device;
+	bool first_time;
+};
+
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
+	ahci_error_handler(ap);
+
+	if (!(imxpriv->first_time) || ahci_imx_hotplug)
+		return;
+
+	imxpriv->first_time = false;
+
+	ata_for_each_dev(dev, &ap->link, ENABLED)
+		return;
+	/*
+	 * DISABLE LINK to save power consumption
+	 * imx ahci can't be recovered and work well anymore when the
+	 * pddq mode is enabled once. It's can't be a part of usual LPM.
+	 */
+	reg_val = readl(mmio + PORT_PHY_CTL);
+	writel(reg_val | PORT_PHY_CTL_PDDQ_LOC, mmio + PORT_PHY_CTL);
+	regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
+			IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+			!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+	clk_disable_unprepare(imxpriv->sata_ref_clk);
+	imxpriv->no_device = true;
+}
+
+static struct ata_port_operations ahci_imx_ops = {
+	.inherits	= &ahci_platform_ops,
+	.error_handler	= ahci_imx_error_handler,
+};
+
+static const struct ata_port_info ahci_imx_port_info = {
+	.flags		= AHCI_FLAG_COMMON,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &ahci_imx_ops,
 };
 
 static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
@@ -117,9 +170,51 @@ static void imx6q_sata_exit(struct device *dev)
 	clk_disable_unprepare(imxpriv->sata_ref_clk);
 }
 
+static int imx_ahci_suspend(struct device *dev)
+{
+	struct imx_ahci_priv *imxpriv =  dev_get_drvdata(dev->parent);
+
+	/*
+	 * If no_device is set, The CLKs had been gated off in
+	 * the initialization and don't do it again here.
+	 */
+	if (!imxpriv->no_device) {
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
+	if (!imxpriv->no_device) {
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
@@ -152,6 +247,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	ahci_dev = &ahci_pdev->dev;
 	ahci_dev->parent = dev;
 
+	imxpriv->no_device = false;
+	imxpriv->first_time = true;
 	imxpriv->ahb_clk = devm_clk_get(dev, "ahb");
 	if (IS_ERR(imxpriv->ahb_clk)) {
 		dev_err(dev, "can't get ahb clock.\n");
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 7d3b853..f955431 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -49,10 +49,11 @@ static struct platform_device_id ahci_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, ahci_devtype);
 
-static struct ata_port_operations ahci_platform_ops = {
+struct ata_port_operations ahci_platform_ops = {
 	.inherits	= &ahci_ops,
 	.host_stop	= ahci_host_stop,
 };
+EXPORT_SYMBOL_GPL(ahci_platform_ops);
 
 static struct ata_port_operations ahci_platform_retry_srst_ops = {
 	.inherits	= &ahci_pmp_retry_srst_ops,
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index b67086f..7e2a1b3 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -89,7 +89,6 @@ static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
 static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline);
 static void ahci_postreset(struct ata_link *link, unsigned int *class);
-static void ahci_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
 static void ahci_dev_config(struct ata_device *dev);
 #ifdef CONFIG_PM
@@ -1982,7 +1981,7 @@ static void ahci_thaw(struct ata_port *ap)
 	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
-static void ahci_error_handler(struct ata_port *ap)
+void ahci_error_handler(struct ata_port *ap)
 {
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
@@ -1995,6 +1994,7 @@ static void ahci_error_handler(struct ata_port *ap)
 	if (!ata_dev_enabled(ap->link.device))
 		ahci_stop_engine(ap);
 }
+EXPORT_SYMBOL_GPL(ahci_error_handler);
 
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 {
-- 
1.7.5.4

