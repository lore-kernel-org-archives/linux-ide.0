From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 4/5] phy: add Broadcom SATA3 PHY driver for Broadcom STB SoCs
Date: Wed, 18 Mar 2015 18:23:41 -0700
Message-ID: <1426728222-8197-4-git-send-email-computersforpeace@gmail.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Supports up to two ports which can each be powered on/off and configure=
d
independently.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/phy/Kconfig            |   9 ++
 drivers/phy/Makefile           |   1 +
 drivers/phy/phy-brcmstb-sata.c | 333 +++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 343 insertions(+)
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
index 000000000000..413bc94225ac
--- /dev/null
+++ b/drivers/phy/phy-brcmstb-sata.c
@@ -0,0 +1,333 @@
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
+#define SATA_TOP_CTRL_PHY_CTRL_1			0x0
+ #define SATA_TOP_CTRL_1_PHY_DEFAULT_POWER_STATE	BIT(14)
+
+#define SATA_TOP_CTRL_PHY_CTRL_2			0x4
+ #define SATA_TOP_CTRL_2_SW_RST_MDIOREG			BIT(0)
+ #define SATA_TOP_CTRL_2_SW_RST_OOB			BIT(1)
+ #define SATA_TOP_CTRL_2_SW_RST_RX			BIT(2)
+ #define SATA_TOP_CTRL_2_SW_RST_TX			BIT(3)
+ #define SATA_TOP_CTRL_2_PHY_GLOBAL_RESET		BIT(14)
+
+#define MAX_PORTS					2
+/* Register offset between PHYs in port-ctrl */
+#define SATA_TOP_CTRL_PHY_CTRL_LEN			0x8
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
+	void __iomem *port_ctrl;
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
+static inline void __iomem *sata_phy_get_port_ctrl(struct brcm_sata_po=
rt *port)
+{
+	struct brcm_sata_phy *priv =3D port->phy_priv;
+
+	return priv->port_ctrl + (port->portnum * SATA_TOP_CTRL_PHY_CTRL_LEN)=
;
+}
+static inline void __iomem *sata_phy_get_phy_base(struct brcm_sata_por=
t *port)
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
+	void __iomem *base =3D sata_phy_get_phy_base(port);
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
+static void brcm_sata_phy_enable(struct brcm_sata_port *port)
+{
+	void __iomem *port_ctrl =3D sata_phy_get_port_ctrl(port);
+	void __iomem *p;
+	u32 reg;
+
+	/* clear PHY_DEFAULT_POWER_STATE */
+	p =3D port_ctrl + SATA_TOP_CTRL_PHY_CTRL_1;
+	reg =3D readl(p);
+	reg &=3D ~SATA_TOP_CTRL_1_PHY_DEFAULT_POWER_STATE;
+	writel(reg, p);
+
+	/* reset the PHY digital logic */
+	p =3D port_ctrl + SATA_TOP_CTRL_PHY_CTRL_2;
+	reg =3D readl(p);
+	reg &=3D ~(SATA_TOP_CTRL_2_SW_RST_MDIOREG | SATA_TOP_CTRL_2_SW_RST_OO=
B |
+		 SATA_TOP_CTRL_2_SW_RST_RX);
+	reg |=3D SATA_TOP_CTRL_2_SW_RST_TX;
+	writel(reg, p);
+	reg =3D readl(p);
+	reg |=3D SATA_TOP_CTRL_2_PHY_GLOBAL_RESET;
+	writel(reg, p);
+	reg =3D readl(p);
+	reg &=3D ~SATA_TOP_CTRL_2_PHY_GLOBAL_RESET;
+	writel(reg, p);
+	(void)readl(p);
+}
+
+static void brcm_sata_phy_disable(struct brcm_sata_port *port)
+{
+	void __iomem *port_ctrl =3D sata_phy_get_port_ctrl(port);
+	void __iomem *p;
+	u32 reg;
+
+	/* power-off the PHY digital logic */
+	p =3D port_ctrl + SATA_TOP_CTRL_PHY_CTRL_2;
+	reg =3D readl(p);
+	reg |=3D (SATA_TOP_CTRL_2_SW_RST_MDIOREG | SATA_TOP_CTRL_2_SW_RST_OOB=
 |
+		SATA_TOP_CTRL_2_SW_RST_RX | SATA_TOP_CTRL_2_SW_RST_TX |
+		SATA_TOP_CTRL_2_PHY_GLOBAL_RESET);
+	writel(reg, p);
+
+	/* set PHY_DEFAULT_POWER_STATE */
+	p =3D port_ctrl + SATA_TOP_CTRL_PHY_CTRL_1;
+	reg =3D readl(p);
+	reg |=3D SATA_TOP_CTRL_1_PHY_DEFAULT_POWER_STATE;
+	writel(reg, p);
+}
+
+static int brcmstb_sata_phy_power_on(struct phy *phy)
+{
+	struct brcm_sata_port *port =3D phy_get_drvdata(phy);
+
+	dev_info(port->phy_priv->dev, "powering on port %d\n", port->portnum)=
;
+
+	brcm_sata_phy_enable(port);
+	cfg_ssc_28nm(port);
+
+	return 0;
+}
+
+static int brcmstb_sata_phy_power_off(struct phy *phy)
+{
+	struct brcm_sata_port *port =3D phy_get_drvdata(phy);
+
+	dev_info(port->phy_priv->dev, "powering off port %d\n", port->portnum=
);
+
+	brcm_sata_phy_disable(port);
+
+	return 0;
+}
+
+static struct phy_ops phy_ops_28nm =3D {
+	.power_on	=3D brcmstb_sata_phy_power_on,
+	.power_off	=3D brcmstb_sata_phy_power_off,
+	.owner		=3D THIS_MODULE,
+};
+
+static struct phy *brcm_sata_phy_xlate(struct device *dev,
+				       struct of_phandle_args *args)
+{
+	struct brcm_sata_phy *priv =3D dev_get_drvdata(dev);
+	int i =3D args->args[0];
+
+	if (i >=3D MAX_PORTS || !priv->phys[i].phy) {
+		dev_err(dev, "invalid phy: %d\n", i);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return priv->phys[i].phy;
+}
+
+static const struct of_device_id brcmstb_sata_phy_of_match[] =3D {
+	{ .compatible	=3D "brcm,bcm7445-sata-phy" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, brcmstb_sata_phy_of_match);
+
+static int brcmstb_sata_phy_probe(struct platform_device *pdev)
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
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "port-ctrl=
");
+	if (!res) {
+		dev_err(dev, "couldn't get port-ctrl resource\n");
+		return -EINVAL;
+	}
+	/*
+	 * Don't request region, since it may be within a region owned by the
+	 * SATA driver
+	 */
+	priv->port_ctrl =3D devm_ioremap(dev, res->start, resource_size(res))=
;
+	if (!priv->port_ctrl) {
+		dev_err(dev, "couldn't remap: %pR\n", res);
+		return -ENOMEM;
+	}
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
+		port->phy =3D devm_phy_create(dev, NULL, &phy_ops_28nm);
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
+	provider =3D devm_of_phy_provider_register(dev, brcm_sata_phy_xlate);
+	if (IS_ERR(provider)) {
+		dev_err(dev, "could not register PHY provider\n");
+		return PTR_ERR(provider);
+	}
+
+	dev_info(dev, "registered %d ports\n", count);
+
+	return 0;
+}
+
+static int brcmstb_sata_phy_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver brcmstb_sata_phy_driver =3D {
+	.probe	=3D brcmstb_sata_phy_probe,
+	.remove	=3D brcmstb_sata_phy_remove,
+	.driver	=3D {
+		.of_match_table	=3D brcmstb_sata_phy_of_match,
+		.name		=3D "brcmstb-sata-phy",
+	}
+};
+module_platform_driver(brcmstb_sata_phy_driver);
+
+MODULE_DESCRIPTION("Broadcom STB SATA PHY driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Marc Carino");
+MODULE_AUTHOR("Brian Norris");
+MODULE_ALIAS("platform:phy-brcmstb-sata");
--=20
1.9.1
