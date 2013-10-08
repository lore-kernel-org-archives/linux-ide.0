From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [v2] ahci: imx: setup power saving methods
Date: Tue,  8 Oct 2013 17:29:22 +0800
Message-ID: <1381224562-2378-2-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1381224562-2378-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:43470 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab3JHJZd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Oct 2013 05:25:33 -0400
Received: by mail-pb0-f50.google.com with SMTP id uo5so8399031pbc.9
        for <linux-ide@vger.kernel.org>; Tue, 08 Oct 2013 02:25:32 -0700 (PDT)
In-Reply-To: <1381224562-2378-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, tj@kernel.org, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

From: Richard Zhu <r65037@freescale.com>

In order to save power consumption amap.
* Disable sata phy internal pll reference clock when
sysetem enter into suspend mode, enable it after resume.
* Don't support hot-plug feature, and enter into test power
down mode(PDDQ) when there is no device detected on the port.

NOTE:
- The hot-plug can't be supported when PDDQ mode is
ever enabled.
- module parameter usage how-to:
  * default: enable PDDQ mode when no device detected.
  * add "ahci-imx.hp=1" into kernel command line if
  your don't want to enable PDDQ mode when no device
  detected on the port.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/ata/ahci_imx.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 58debb0..8c2dc1a 100644
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
@@ -28,6 +28,10 @@
 #include "ahci.h"
 
 enum {
+	/* Port0 PHY Control */
+	PORT_PHY_CTL = 0x178,
+	/* PORT_PHY_CTL bits */
+	PORT_PHY_CTL_PDDQ_LOC = 0x100000,
 	HOST_TIMER1MS = 0xe0, /* Timer 1-ms */
 };
 
@@ -36,12 +40,17 @@ struct imx_ahci_priv {
 	struct clk *sata_ref_clk;
 	struct clk *ahb_clk;
 	struct regmap *gpr;
+	bool no_device;
 };
 
+static int ahci_imx_hp;
+module_param_named(hp, ahci_imx_hp, int, 0644);
+MODULE_PARM_DESC(hp, "AHCI IMX hot-plug support (0=Don't support, 1=support)");
+
 static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
 {
-	int ret = 0;
-	unsigned int reg_val;
+	int ret = 0, iterations = 200;
+	u32 reg_val, sstatus;
 	struct imx_ahci_priv *imxpriv = dev_get_drvdata(dev->parent);
 
 	imxpriv->gpr =
@@ -105,6 +114,39 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
 	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
 	writel(reg_val, mmio + HOST_TIMER1MS);
 
+	if (ahci_imx_hp == 0) {
+		/*
+		 * hot-plug is not supported.
+		 * In order to save power consumption, enter PDDQ mode
+		 * when there is no device detected on the port.
+		 * NOTE: hot-plug wouldn't supported when PDDQ mode is
+		 * ever entered.
+		 */
+		do {
+			sstatus = readl(mmio + 0x100 + PORT_SCR_STAT);
+			if ((sstatus & 0xF) == 0)
+				usleep_range(1000, 2000);
+			else
+				break;
+
+			if (iterations == 0) {
+				pr_info("No sata disk.\n");
+				reg_val = readl(mmio + PORT_PHY_CTL);
+				writel(reg_val | PORT_PHY_CTL_PDDQ_LOC,
+						mmio + PORT_PHY_CTL);
+				regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
+						IMX6Q_GPR13_SATA_MPLL_CLK_EN,
+						!IMX6Q_GPR13_SATA_MPLL_CLK_EN);
+				clk_disable_unprepare(imxpriv->sata_ref_clk);
+				imxpriv->no_device = 1;
+
+				return 0;
+			}
+		} while (iterations-- > 0);
+	} else {
+		imxpriv->no_device = 0;
+	}
+
 	return 0;
 }
 
@@ -117,9 +159,46 @@ static void imx6q_sata_exit(struct device *dev)
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
+	.suspend = imx_ahci_suspend,
+	.resume = imx_ahci_resume,
 };
 
 static const struct of_device_id imx_ahci_of_match[] = {
-- 
1.7.5.4

