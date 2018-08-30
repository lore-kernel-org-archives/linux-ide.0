From: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 04/13] phy: Add sun4i-a10-phy-sata driver
Date: Thu, 30 Aug 2018 21:01:11 +0200
Message-ID: <20180830190120.722-5-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Reply-To: clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBD7YLCN32UNBBD76UDOAKGQENGOOV4Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180830190120.722-1-clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

This patch create a PHY SATA driver for allwinner SoC A10/A20/R40.
The code is taken from drivers/ata/ahci_sunxi.c but cannot be removed
from it yet, since we need to finish the transition to new binding with
the PHY usage.

Signed-off-by: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/phy/allwinner/Kconfig          |   7 ++
 drivers/phy/allwinner/Makefile         |   1 +
 drivers/phy/allwinner/phy-sun4i-sata.c | 208 +++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 drivers/phy/allwinner/phy-sun4i-sata.c

diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
index cdc1e745ba47..ef6fa389389a 100644
--- a/drivers/phy/allwinner/Kconfig
+++ b/drivers/phy/allwinner/Kconfig
@@ -1,6 +1,13 @@
 #
 # Phy drivers for Allwinner platforms
 #
+config PHY_SUN4I_SATA
+	tristate "Allwinner sunxi SoC SATA PHY driver"
+	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the SATA PHY present on A10/A20/R40.
+
 config PHY_SUN4I_USB
 	tristate "Allwinner sunxi SoC USB PHY driver"
 	depends on ARCH_SUNXI && HAS_IOMEM && OF
diff --git a/drivers/phy/allwinner/Makefile b/drivers/phy/allwinner/Makefile
index 8605529c01a1..73ef882edb53 100644
--- a/drivers/phy/allwinner/Makefile
+++ b/drivers/phy/allwinner/Makefile
@@ -1,2 +1,3 @@
+obj-$(CONFIG_PHY_SUN4I_SATA)		+= phy-sun4i-sata.o
 obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
 obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
diff --git a/drivers/phy/allwinner/phy-sun4i-sata.c b/drivers/phy/allwinner/phy-sun4i-sata.c
new file mode 100644
index 000000000000..93e29f99d26c
--- /dev/null
+++ b/drivers/phy/allwinner/phy-sun4i-sata.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Allwinner sun4i SATA phy driver
+ * Copyright (C) 2018 Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+ *
+ * PHY init code taken from drivers/ahci/ahci_sunxi.c
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#define AHCI_PHYCS0R	0x0000
+#define AHCI_PHYCS1R	0x0004
+#define AHCI_PHYCS2R	0x0008
+#define AHCI_TIMER1MS	0x0020
+#define AHCI_GPARAM1R	0x0028
+#define AHCI_GPARAM2R	0x002c
+#define AHCI_PPARAMR	0x0030
+#define AHCI_TESTR	0x0034
+#define AHCI_VERSIONR	0x0038
+#define AHCI_IDR	0x003c
+#define AHCI_RWCR	0x003c
+#define AHCI_P0DMACR	0x00b0
+#define AHCI_P0PHYCR	0x00b8
+#define AHCI_P0PHYSR	0x00bc
+
+struct sun4i_sata_phy_data {
+	struct phy *phy;
+	struct device *dev;
+	void __iomem            *base;
+};
+
+static void sunxi_clrbits(void __iomem *reg, u32 clr_val)
+{
+	u32 reg_val;
+
+	reg_val = readl(reg);
+	reg_val &= ~(clr_val);
+	writel(reg_val, reg);
+}
+
+static void sunxi_setbits(void __iomem *reg, u32 set_val)
+{
+	u32 reg_val;
+
+	reg_val = readl(reg);
+	reg_val |= set_val;
+	writel(reg_val, reg);
+}
+
+static void sunxi_clrsetbits(void __iomem *reg, u32 clr_val, u32 set_val)
+{
+	u32 reg_val;
+
+	reg_val = readl(reg);
+	reg_val &= ~(clr_val);
+	reg_val |= set_val;
+	writel(reg_val, reg);
+}
+
+static u32 sunxi_getbits(void __iomem *reg, u8 mask, u8 shift)
+{
+	return (readl(reg) >> shift) & mask;
+}
+
+static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
+{
+	u32 reg_val;
+	int timeout;
+
+	/* This magic is from the original code */
+	writel(0, reg_base + AHCI_RWCR);
+	msleep(5);
+
+	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(19));
+	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R, (0x7 << 24),
+			 (0x5 << 24) | BIT(23) | BIT(18));
+	sunxi_clrsetbits(reg_base + AHCI_PHYCS1R,
+			 (0x3 << 16) | (0x1f << 8) | (0x3 << 6),
+			 (0x2 << 16) | (0x6 << 8) | (0x2 << 6));
+	sunxi_setbits(reg_base + AHCI_PHYCS1R, BIT(28) | BIT(15));
+	sunxi_clrbits(reg_base + AHCI_PHYCS1R, BIT(19));
+	sunxi_clrsetbits(reg_base + AHCI_PHYCS0R, (0x7 << 20), (0x3 << 20));
+	sunxi_clrsetbits(reg_base + AHCI_PHYCS2R, (0x1f << 5), (0x19 << 5));
+	msleep(5);
+
+	sunxi_setbits(reg_base + AHCI_PHYCS0R, (0x1 << 19));
+
+	timeout = 250; /* Power up takes aprox 50 us */
+	do {
+		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS0R, 0x7, 28);
+		if (reg_val == 0x02)
+			break;
+
+		if (--timeout == 0) {
+			dev_err(dev, "PHY power up failed.\n");
+			return -EIO;
+		}
+		udelay(1);
+	} while (1);
+
+	sunxi_setbits(reg_base + AHCI_PHYCS2R, (0x1 << 24));
+
+	timeout = 100; /* Calibration takes aprox 10 us */
+	do {
+		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS2R, 0x1, 24);
+		if (reg_val == 0x00)
+			break;
+
+		if (--timeout == 0) {
+			dev_err(dev, "PHY calibration failed.\n");
+			return -EIO;
+		}
+		udelay(1);
+	} while (1);
+
+	msleep(15);
+
+	writel(0x7, reg_base + AHCI_RWCR);
+
+	return 0;
+}
+
+static int sun4i_sata_phy_power_on(struct phy *_phy)
+{
+	struct sun4i_sata_phy_data *data = phy_get_drvdata(_phy);
+
+	dev_info(data->dev, "%s\n", __func__);
+	return ahci_sunxi_phy_init(data->dev, data->base);
+}
+
+static const struct phy_ops sun4i_sata_phy_ops = {
+	.power_on	= sun4i_sata_phy_power_on,
+	.owner		= THIS_MODULE,
+};
+
+static int sun4i_sata_phy_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int sun4i_sata_phy_probe(struct platform_device *pdev)
+{
+	struct sun4i_sata_phy_data *data;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, data);
+	data->dev = dev;
+
+	data->base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!data->base)
+		return -ENOMEM;
+
+	data->phy = devm_phy_create(dev, NULL, &sun4i_sata_phy_ops);
+	if (IS_ERR(data->phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(data->phy);
+	}
+		phy_set_drvdata(data->phy, data);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	dev_info(dev, "successfully loaded\n");
+
+	return 0;
+}
+
+static const struct of_device_id sun4i_sata_phy_of_match[] = {
+	{ .compatible = "allwinner,sun4i-a10-sata-phy", },
+	{ .compatible = "allwinner,sun8i-r40-sata-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sun4i_sata_phy_of_match);
+
+static struct platform_driver sun4i_sata_phy_driver = {
+	.probe	= sun4i_sata_phy_probe,
+	.remove	= sun4i_sata_phy_remove,
+	.driver = {
+		.of_match_table	= sun4i_sata_phy_of_match,
+		.name  = "sun4i-a10-sata-phy",
+	}
+};
+module_platform_driver(sun4i_sata_phy_driver);
+
+MODULE_DESCRIPTION("sun4i SATA PHY driver");
+MODULE_AUTHOR("Corentin LABBE <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.16.4
