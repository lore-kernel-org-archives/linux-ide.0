From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [v1 3/3] imx: ahci: enable ahci sata on imx6q platforms
Date: Tue, 18 Jun 2013 21:56:29 +0200
Message-ID: <20130618195629.GA22972@pengutronix.de>
References: <1371462767-16630-1-git-send-email-r65037@freescale.com>
 <1371462767-16630-4-git-send-email-r65037@freescale.com>
 <20130618030310.GD28381@S2101-09.ap.freescale.net>
 <0E83723C55F66F43A6041464FE31119D3057EF@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130618055925.GA6723@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50526 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933011Ab3FRT4h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jun 2013 15:56:37 -0400
Content-Disposition: inline
In-Reply-To: <20130618055925.GA6723@S2101-09.ap.freescale.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Zhu Richard-R65037 <r65037@freescale.com>, Richard Zhu <richard.zhuhongxing@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 18, 2013 at 01:59:27PM +0800, Shawn Guo wrote:
> It sounds like to me that the generic ahci_platform driver does not
> perfectly fit imx6q sata device.  You're pushing all those bits that
> are not covered by the generic ahci_platform driver down to platform
> code.  This is not the right thing to do, and platform is not the right
> place to handle device/IP stuff.  I see two options you can go as below.
> 
> 1. Create an imx6q sata specific compatible string and add code into
>    generic ahci_platform driver to implement programming model for imx6q
>    type of device.
> 
> 2. The existing ahci_platform driver is not so useful for imx6q sata
>    considering you have so many imx6q custom bits to add.  It might be
>    more appropriate to create a custom ahci_platform driver for imx6q
>    sata device with forking the generic one, just like what
>    sata_highbank does.
> 
> I would go for option 2.

That's exactly what we have done some time ago. Unfortunately I never
came along to mainline this patch. See it attached, there may be bits to
copy or it may even be a better base for further work.


8<-------------------------------------------------

>From 51222e32870a37f50713284942b6df34ff40a43c Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 21 Nov 2012 16:29:00 +0100
Subject: [PATCH] ata: Add Freescale i.MX specific SATA driver

This adds an i.MX specific ahci glue driver. The i.MX SoCs need
some special handlings:

- Additional clocks
- An additional register (TIMER_1MS) which has to be configured
- Registers external to the AHCI core which have to be configured

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/ata/Kconfig                         |   8 +
 drivers/ata/Makefile                        |   1 +
 drivers/ata/ahci_platform.c                 |  10 -
 drivers/ata/sata_imx.c                      | 376 ++++++++++++++++++++++++++++
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |   1 +
 5 files changed, 386 insertions(+), 10 deletions(-)
 create mode 100644 drivers/ata/sata_imx.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a5a3ebc..7cef382 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -106,6 +106,14 @@ config SATA_FSL
 
 	  If unsure, say N.
 
+config SATA_IMX
+	tristate "Freescale i.MX SATA support"
+	help
+	  This option enables support for Freescale i.MX SATA controller.
+	  It can be found on i.MX53 and i.MX6.
+
+	  If unsure, say N.
+
 config SATA_INIC162X
 	tristate "Initio 162x SATA support"
 	depends on PCI
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index c04d0fd..c37ef58 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_SATA_AHCI)		+= ahci.o libahci.o
 obj-$(CONFIG_SATA_ACARD_AHCI)	+= acard-ahci.o libahci.o
 obj-$(CONFIG_SATA_AHCI_PLATFORM) += ahci_platform.o libahci.o
 obj-$(CONFIG_SATA_FSL)		+= sata_fsl.o
+obj-$(CONFIG_SATA_IMX)		+= sata_imx.o libahci.o
 obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 7a8a284..9d57774 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -29,7 +29,6 @@ static void ahci_host_stop(struct ata_host *host);
 
 enum ahci_type {
 	AHCI,		/* standard platform ahci */
-	IMX53_AHCI,	/* ahci on i.mx53 */
 	STRICT_AHCI,	/* delayed DMA engine start */
 };
 
@@ -38,9 +37,6 @@ static struct platform_device_id ahci_devtype[] = {
 		.name = "ahci",
 		.driver_data = AHCI,
 	}, {
-		.name = "imx53-ahci",
-		.driver_data = IMX53_AHCI,
-	}, {
 		.name = "strict-ahci",
 		.driver_data = STRICT_AHCI,
 	}, {
@@ -67,12 +63,6 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_platform_ops,
 	},
-	[IMX53_AHCI] = {
-		.flags		= AHCI_FLAG_COMMON,
-		.pio_mask	= ATA_PIO4,
-		.udma_mask	= ATA_UDMA6,
-		.port_ops	= &ahci_platform_retry_srst_ops,
-	},
 	[STRICT_AHCI] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_DELAY_ENGINE),
 		.flags		= AHCI_FLAG_COMMON,
diff --git a/drivers/ata/sata_imx.c b/drivers/ata/sata_imx.c
new file mode 100644
index 0000000..bd8f348
--- /dev/null
+++ b/drivers/ata/sata_imx.c
@@ -0,0 +1,376 @@
+/*
+ * AHCI SATA platform driver
+ *
+ * Copyright 2012 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
+ *
+ * based on ahci platform driver
+ *
+ * Copyright 2004-2005  Red Hat, Inc.
+ *   Jeff Garzik <jgarzik@pobox.com>
+ * Copyright 2010  MontaVista Software, LLC.
+ *   Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/kernel.h>
+#include <linux/gfp.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/libata.h>
+#include <linux/ahci_platform.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
+
+#include "ahci.h"
+
+struct imx_ahci_priv {
+	struct ahci_host_priv ahci;
+	struct device *dev;
+	struct clk *clk_ahb;
+	struct clk *clk_phy;
+	struct regmap *gprmap;
+};
+
+struct imx_ahci_driver_data {
+	int (*init)(struct imx_ahci_priv *);
+};
+
+static const struct ata_port_info ahci_port_info = {
+	.flags		= AHCI_FLAG_COMMON,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &ahci_pmp_retry_srst_ops,
+};
+
+static struct scsi_host_template ahci_platform_sht = {
+	AHCI_SHT("ahci_platform"),
+};
+
+#define HOST_TIMER1MS 0xe0 /* Timer 1-ms */
+
+/*
+ * The i.MX AHCI core has a nonstandard register which has
+ * to be initialized with the number of ahb clk cycles during
+ * 1ms.
+ */
+static void imx_sata_init_1ms(struct imx_ahci_priv *imxpriv)
+{
+	struct ahci_host_priv *hpriv = &imxpriv->ahci;
+	unsigned long rate;
+	u32 val;
+
+	val = readl(hpriv->mmio + HOST_PORTS_IMPL);
+	if (!val & 0x1) {
+		val |= 0x1;
+		writel(val, hpriv->mmio + HOST_PORTS_IMPL);
+	}
+
+	rate = clk_get_rate(imxpriv->clk_ahb);
+	writel(rate / 1000, hpriv->mmio + HOST_TIMER1MS);
+}
+
+static void imx_ahci_clk_enable(struct imx_ahci_priv *imxpriv)
+{
+	clk_prepare_enable(imxpriv->clk_phy);
+	clk_prepare_enable(imxpriv->clk_ahb);
+	clk_prepare_enable(imxpriv->ahci.clk);
+}
+
+static void imx_ahci_clk_disable(struct imx_ahci_priv *imxpriv)
+{
+	clk_prepare_enable(imxpriv->clk_phy);
+	clk_prepare_enable(imxpriv->clk_ahb);
+	clk_prepare_enable(imxpriv->ahci.clk);
+}
+
+static int imx6q_sata_init(struct imx_ahci_priv *imxpriv)
+{
+	struct regmap *map;
+	int ret;
+	u32 val;
+
+	map = syscon_regmap_lookup_by_phandle(imxpriv->dev->of_node, "gprreg");
+	if (IS_ERR(map)) {
+		dev_err(imxpriv->dev, "requesting iomuxc gpr map failed with: %ld\n",
+				PTR_ERR(map));
+		return PTR_ERR(map);
+	}
+
+	val = 0x11 << IMX6Q_GPR13_SATA_PHY_2_OFF | IMX6Q_GPR13_SATA_PHY_4_9_16 |
+		IMX6Q_GPR13_SATA_SPEED_MASK | 0x3 << IMX6Q_GPR13_SATA_PHY_6_OFF |
+		IMX6Q_GPR13_SATA_PHY_7_SATA2I |	IMX6Q_GPR13_SATA_PHY_8_3_0_DB;
+
+	ret = regmap_update_bits(map, IOMUXC_GPR13, 0x07ffffff, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(map, IOMUXC_GPR13, 0x07ffffff, val | 2);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct imx_ahci_driver_data imx6q_driver_data = {
+	.init = imx6q_sata_init,
+};
+
+static struct imx_ahci_driver_data imx53_driver_data = {
+	/*
+	 * FIXME: The i.MX53 also needs SoC specific init code. This
+	 * is not yet implemented. The necessary fix currently is done
+	 * in U-Boot.
+	 */
+};
+
+static const struct of_device_id ahci_of_match[] = {
+	{ .compatible = "fsl,imx53-ahci", .data = &imx53_driver_data },
+	{ .compatible = "fsl,imx6q-ahci", .data = &imx6q_driver_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ahci_of_match);
+
+static int ahci_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id;
+	struct ata_port_info pi = ahci_port_info;
+	const struct ata_port_info *ppi[] = { &ahci_port_info, NULL };
+	struct ahci_host_priv *hpriv;
+	struct imx_ahci_priv *imxpriv;
+	struct ata_host *host;
+	struct resource *mem;
+	const struct imx_ahci_driver_data *driver_data = NULL;
+	int irq, i, rc;
+
+	of_id = of_match_device(ahci_of_match, &pdev->dev);
+	if (of_id)
+		driver_data = of_id->data;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(dev, "no mmio space\n");
+		return -EINVAL;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		dev_err(dev, "no irq\n");
+		return -EINVAL;
+	}
+
+	imxpriv = devm_kzalloc(dev, sizeof(*imxpriv), GFP_KERNEL);
+	if (!imxpriv) {
+		dev_err(dev, "can't alloc ahci_host_priv\n");
+		return -ENOMEM;
+	}
+
+	imxpriv->dev = dev;
+
+	hpriv = &imxpriv->ahci;
+
+	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
+	if (!hpriv->mmio) {
+		dev_err(dev, "can't map %pR\n", mem);
+		return -ENOMEM;
+	}
+
+	hpriv->clk = devm_clk_get(dev, "ipg");
+	if (IS_ERR(hpriv->clk)) {
+		rc = PTR_ERR(hpriv->clk);
+		dev_err(dev, "failed to get ipg clock: %d\n", rc);
+		return rc;
+	}
+
+	imxpriv->clk_ahb = devm_clk_get(dev, "ahb");
+	if (IS_ERR(imxpriv->clk_ahb)) {
+		rc = PTR_ERR(imxpriv->clk_ahb);
+		dev_err(dev, "failed to get ahb clock: %d\n", rc);
+		return rc;
+	}
+
+	imxpriv->clk_phy = devm_clk_get(dev, "per");
+	if (IS_ERR(imxpriv->clk_phy)) {
+		rc = PTR_ERR(imxpriv->clk_phy);
+		dev_err(dev, "failed to get ahb clock: %d\n", rc);
+		return rc;
+	}
+
+	if (driver_data && driver_data->init) {
+		rc = driver_data->init(imxpriv);
+		if (rc) {
+			dev_err(dev, "failed to init: %d\n", rc);
+			return rc;
+		}
+	}
+
+	imx_ahci_clk_enable(imxpriv);
+
+	imx_sata_init_1ms(imxpriv);
+
+	ahci_save_initial_config(dev, hpriv, 0, 0);
+
+	/* prepare host */
+	if (hpriv->cap & HOST_CAP_NCQ)
+		pi.flags |= ATA_FLAG_NCQ;
+
+	if (hpriv->cap & HOST_CAP_PMP)
+		pi.flags |= ATA_FLAG_PMP;
+
+	ahci_set_em_messages(hpriv, &pi);
+
+	host = ata_host_alloc_pinfo(dev, ppi, 1);
+	if (!host) {
+		rc = -ENOMEM;
+		goto err_clk;
+	}
+
+	host->private_data = hpriv;
+
+	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
+		host->flags |= ATA_HOST_PARALLEL_SCAN;
+
+	if (pi.flags & ATA_FLAG_EM)
+		ahci_reset_em(host);
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		ata_port_desc(ap, "mmio %pR", mem);
+		ata_port_desc(ap, "port 0x%x", 0x100 + ap->port_no * 0x80);
+
+		/* set enclosure management message type */
+		if (ap->flags & ATA_FLAG_EM)
+			ap->em_message_type = hpriv->em_msg_type;
+
+		/* disabled/not-implemented port */
+		if (!(hpriv->port_map & (1 << i)))
+			ap->ops = &ata_dummy_port_ops;
+	}
+
+	rc = ahci_reset_controller(host);
+	if (rc)
+		goto err_clk;
+
+	ahci_init_controller(host);
+	ahci_print_info(host, "platform");
+
+	rc = ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
+			       &ahci_platform_sht);
+	if (rc)
+		goto err_clk;
+
+	return 0;
+
+err_clk:
+	clk_disable_unprepare(hpriv->clk);
+
+	return rc;
+}
+
+static int ahci_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct imx_ahci_priv *imxpriv = container_of(hpriv, struct imx_ahci_priv, ahci);
+
+	ata_host_detach(host);
+
+	imx_ahci_clk_disable(imxpriv);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int ahci_suspend(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct imx_ahci_priv *imxpriv = container_of(hpriv, struct imx_ahci_priv, ahci);
+	void __iomem *mmio = hpriv->mmio;
+	u32 ctl;
+	int rc;
+
+	if (hpriv->flags & AHCI_HFLAG_NO_SUSPEND) {
+		dev_err(dev, "firmware update required for suspend/resume\n");
+		return -EIO;
+	}
+
+	/*
+	 * AHCI spec rev1.1 section 8.3.3:
+	 * Software must disable interrupts prior to requesting a
+	 * transition of the HBA to D3 state.
+	 */
+	ctl = readl(mmio + HOST_CTL);
+	ctl &= ~HOST_IRQ_EN;
+	writel(ctl, mmio + HOST_CTL);
+	readl(mmio + HOST_CTL); /* flush */
+
+	rc = ata_host_suspend(host, PMSG_SUSPEND);
+	if (rc)
+		return rc;
+
+	imx_ahci_clk_disable(imxpriv);
+
+	return 0;
+}
+
+static int ahci_resume(struct device *dev)
+{
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct imx_ahci_priv *imxpriv = container_of(hpriv, struct imx_ahci_priv, ahci);
+	int rc;
+
+	imx_ahci_clk_enable(imxpriv);
+
+	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
+		rc = ahci_reset_controller(host);
+		if (rc)
+			goto disable_unprepare_clk;
+
+		ahci_init_controller(host);
+	}
+
+	ata_host_resume(host);
+
+	return 0;
+
+disable_unprepare_clk:
+		imx_ahci_clk_disable(imxpriv);
+
+	return rc;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
+
+static struct platform_driver imx_ahci_driver = {
+	.probe = ahci_probe,
+	.remove = ahci_remove,
+	.driver = {
+		.name = "imx-ahci",
+		.owner = THIS_MODULE,
+		.of_match_table = ahci_of_match,
+		.pm = &ahci_pm_ops,
+	},
+};
+
+module_platform_driver(imx_ahci_driver);
+
+MODULE_DESCRIPTION("i.MX AHCI SATA platform driver");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imx-ahci");
diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index dab34a1..db43d59 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -296,6 +296,7 @@
 #define IMX6Q_GPR13_SATA_PHY_7_SATA2M		(0x12 << 19)
 #define IMX6Q_GPR13_SATA_PHY_7_SATA2X		(0x1a << 19)
 #define IMX6Q_GPR13_SATA_PHY_6_MASK		(0x7 << 16)
+#define IMX6Q_GPR13_SATA_PHY_6_OFF		16
 #define IMX6Q_GPR13_SATA_SPEED_MASK		BIT(15)
 #define IMX6Q_GPR13_SATA_SPEED_1P5G		0x0
 #define IMX6Q_GPR13_SATA_SPEED_3P0G		BIT(15)
-- 
1.8.3.1

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
