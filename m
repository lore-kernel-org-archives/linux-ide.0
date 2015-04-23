From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 4/5] phy: add Broadcom SATA3 PHY driver for Broadcom STB SoCs
Date: Wed, 22 Apr 2015 19:59:09 -0700
Message-ID: <1429757950-28789-5-git-send-email-computersforpeace@gmail.com>
References: <1429757950-28789-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429757950-28789-1-git-send-email-computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Supports up to two ports which can each be powered on/off and configure=
d
independently.

Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
  - stop sharing SATA_TOP_CTRL registers with SATA driver
  - kill custom xlate function

 drivers/phy/Kconfig            |   9 ++
 drivers/phy/Makefile           |   1 +
 drivers/phy/phy-brcmstb-sata.c | 216 +++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 226 insertions(+)
 create mode 100644 drivers/phy/phy-brcmstb-sata.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 2962de205ba7..c8b22074bcf6 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -291,4 +291,13 @@ config PHY_QCOM_UFS
 	help
 	  Support for UFS PHY on QCOM chipsets.
=20
+config PHY_BRCMSTB_SATA
+	tristate "Broadcom STB SATA PHY driver"
+	depends on ARCH_BRCMSTB
+	depends on OF
+	select GENERIC_PHY
+	help
+	  Enable this to support the SATA3 PHY on 28nm Broadcom STB SoCs.
+	  Likely useful only with CONFIG_SATA_BRCMSTB enabled.
+
 endmenu
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index f080e1bb2a74..28a10804b4f4 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -38,3 +38,4 @@ obj-$(CONFIG_PHY_STIH41X_USB)		+=3D phy-stih41x-usb.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+=3D phy-qcom-ufs.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+=3D phy-qcom-ufs-qmp-20nm.o
 obj-$(CONFIG_PHY_QCOM_UFS) 	+=3D phy-qcom-ufs-qmp-14nm.o
+obj-$(CONFIG_PHY_BRCMSTB_SATA)		+=3D phy-brcmstb-sata.o
diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-s=
ata.c
new file mode 100644
index 000000000000..8387c8cbea8c
--- /dev/null
+++ b/drivers/phy/phy-brcmstb-sata.c
@@ -0,0 +1,216 @@
+/*
+ * Broadcom SATA3 AHCI Controller PHY Driver
+ *
+ * Copyright =C2=A9 2009-2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License as published b=
y
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#define SATA_MDIO_BANK_OFFSET				0x23c
+#define SATA_MDIO_REG_OFFSET(ofs)			((ofs) * 4)
+#define SATA_MDIO_REG_SPACE_SIZE			0x1000
+#define SATA_MDIO_REG_LENGTH				0x1f00
+
+#define MAX_PORTS					2
+
+/* Register offset between PHYs in PCB space */
+#define SATA_MDIO_REG_SPACE_SIZE			0x1000
+
+struct brcm_sata_port {
+	int portnum;
+	struct phy *phy;
+	struct brcm_sata_phy *phy_priv;
+	bool ssc_en;
+};
+
+struct brcm_sata_phy {
+	struct device *dev;
+	void __iomem *phy_base;
+
+	struct brcm_sata_port phys[MAX_PORTS];
+};
+
+enum sata_mdio_phy_regs_28nm {
+	PLL_REG_BANK_0				=3D 0x50,
+	PLL_REG_BANK_0_PLLCONTROL_0		=3D 0x81,
+
+	TXPMD_REG_BANK				=3D 0x1a0,
+	TXPMD_CONTROL1				=3D 0x81,
+	TXPMD_CONTROL1_TX_SSC_EN_FRC		=3D BIT(0),
+	TXPMD_CONTROL1_TX_SSC_EN_FRC_VAL	=3D BIT(1),
+	TXPMD_TX_FREQ_CTRL_CONTROL1		=3D 0x82,
+	TXPMD_TX_FREQ_CTRL_CONTROL2		=3D 0x83,
+	TXPMD_TX_FREQ_CTRL_CONTROL2_FMIN_MASK	=3D 0x3ff,
+	TXPMD_TX_FREQ_CTRL_CONTROL3		=3D 0x84,
+	TXPMD_TX_FREQ_CTRL_CONTROL3_FMAX_MASK	=3D 0x3ff,
+};
+
+static inline void __iomem *brcm_sata_phy_base(struct brcm_sata_port *=
port)
+{
+	struct brcm_sata_phy *priv =3D port->phy_priv;
+
+	return priv->phy_base + (port->portnum * SATA_MDIO_REG_SPACE_SIZE);
+}
+
+static void brcm_sata_mdio_wr(void __iomem *addr, u32 bank, u32 ofs,
+			      u32 msk, u32 value)
+{
+	u32 tmp;
+
+	writel(bank, addr + SATA_MDIO_BANK_OFFSET);
+	tmp =3D readl(addr + SATA_MDIO_REG_OFFSET(ofs));
+	tmp =3D (tmp & msk) | value;
+	writel(tmp, addr + SATA_MDIO_REG_OFFSET(ofs));
+}
+
+/* These defaults were characterized by H/W group */
+#define FMIN_VAL_DEFAULT	0x3df
+#define FMAX_VAL_DEFAULT	0x3df
+#define FMAX_VAL_SSC		0x83
+
+static void cfg_ssc_28nm(struct brcm_sata_port *port)
+{
+	void __iomem *base =3D brcm_sata_phy_base(port);
+	struct brcm_sata_phy *priv =3D port->phy_priv;
+	u32 tmp;
+
+	/* override the TX spread spectrum setting */
+	tmp =3D TXPMD_CONTROL1_TX_SSC_EN_FRC_VAL | TXPMD_CONTROL1_TX_SSC_EN_F=
RC;
+	brcm_sata_mdio_wr(base, TXPMD_REG_BANK, TXPMD_CONTROL1, ~tmp, tmp);
+
+	/* set fixed min freq */
+	brcm_sata_mdio_wr(base, TXPMD_REG_BANK, TXPMD_TX_FREQ_CTRL_CONTROL2,
+			  ~TXPMD_TX_FREQ_CTRL_CONTROL2_FMIN_MASK,
+			  FMIN_VAL_DEFAULT);
+
+	/* set fixed max freq depending on SSC config */
+	if (port->ssc_en) {
+		dev_info(priv->dev, "enabling SSC on port %d\n", port->portnum);
+		tmp =3D FMAX_VAL_SSC;
+	} else {
+		tmp =3D FMAX_VAL_DEFAULT;
+	}
+
+	brcm_sata_mdio_wr(base, TXPMD_REG_BANK, TXPMD_TX_FREQ_CTRL_CONTROL3,
+			  ~TXPMD_TX_FREQ_CTRL_CONTROL3_FMAX_MASK, tmp);
+}
+
+static int brcm_sata_phy_init(struct phy *phy)
+{
+	struct brcm_sata_port *port =3D phy_get_drvdata(phy);
+
+	cfg_ssc_28nm(port);
+
+	return 0;
+}
+
+static struct phy_ops phy_ops_28nm =3D {
+	.init		=3D brcm_sata_phy_init,
+	.owner		=3D THIS_MODULE,
+};
+
+static const struct of_device_id brcm_sata_phy_of_match[] =3D {
+	{ .compatible	=3D "brcm,bcm7445-sata-phy" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, brcm_sata_phy_of_match);
+
+static int brcm_sata_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct device_node *dn =3D dev->of_node, *child;
+	struct brcm_sata_phy *priv;
+	struct resource *res;
+	struct phy_provider *provider;
+	int count =3D 0;
+
+	if (of_get_child_count(dn) =3D=3D 0)
+		return -ENODEV;
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	dev_set_drvdata(dev, priv);
+	priv->dev =3D dev;
+
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
+	priv->phy_base =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->phy_base))
+		return PTR_ERR(priv->phy_base);
+
+	for_each_available_child_of_node(dn, child) {
+		unsigned int id;
+		struct brcm_sata_port *port;
+
+		if (of_property_read_u32(child, "reg", &id)) {
+			dev_err(dev, "missing reg property in node %s\n",
+					child->name);
+			return -EINVAL;
+		}
+
+		if (id >=3D MAX_PORTS) {
+			dev_err(dev, "invalid reg: %u\n", id);
+			return -EINVAL;
+		}
+		if (priv->phys[id].phy) {
+			dev_err(dev, "already registered port %u\n", id);
+			return -EINVAL;
+		}
+
+		port =3D &priv->phys[id];
+		port->portnum =3D id;
+		port->phy_priv =3D priv;
+		port->phy =3D devm_phy_create(dev, child, &phy_ops_28nm);
+		port->ssc_en =3D of_property_read_bool(child, "brcm,enable-ssc");
+		if (IS_ERR(port->phy)) {
+			dev_err(dev, "failed to create PHY\n");
+			return PTR_ERR(port->phy);
+		}
+
+		phy_set_drvdata(port->phy, port);
+		count++;
+	}
+
+	provider =3D devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(provider)) {
+		dev_err(dev, "could not register PHY provider\n");
+		return PTR_ERR(provider);
+	}
+
+	dev_info(dev, "registered %d port(s)\n", count);
+
+	return 0;
+}
+
+static struct platform_driver brcm_sata_phy_driver =3D {
+	.probe	=3D brcm_sata_phy_probe,
+	.driver	=3D {
+		.of_match_table	=3D brcm_sata_phy_of_match,
+		.name		=3D "brcmstb-sata-phy",
+	}
+};
+module_platform_driver(brcm_sata_phy_driver);
+
+MODULE_DESCRIPTION("Broadcom STB SATA PHY driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Marc Carino");
+MODULE_AUTHOR("Brian Norris");
+MODULE_ALIAS("platform:phy-brcmstb-sata");
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
