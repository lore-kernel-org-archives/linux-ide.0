From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v3 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
Date: Tue, 12 May 2015 16:28:21 -0700
Message-ID: <1431473303-18873-4-git-send-email-computersforpeace@gmail.com>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33986 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934287AbbELX30 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 May 2015 19:29:26 -0400
In-Reply-To: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, bcm-kernel-feedback-list@broadcom.com, Kevin Cernekee <cernekee@gmail.com>

Pretty straightforward driver, using the nice library-ization of the
generic ahci_platform driver.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v3:
 - straighten out endianness for big endian MIPS and ARM
 - rename from sata_brcmstb.c to ahci_brcmstb.c
 - bind against the specific string, "brcm,bcm7445-ahci" instead of the=
 generic
   one

v2:
  - move port enabling into this driver, since the affected registers a=
re in
    the SATA_TOP_CTRL block. This means we need to check for the implem=
ented
    port(s) here.
   =20
  - fix up layering issues with using drvdata (libata expects to use dr=
vdata),
    similar to this issue:
=20
      http://marc.info/?l=3Dlinux-ide&m=3D142851961920009&w=3D2

  - trivial fixups

 drivers/ata/Kconfig        |   9 ++
 drivers/ata/Makefile       |   1 +
 drivers/ata/ahci_brcmstb.c | 322 +++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 332 insertions(+)
 create mode 100644 drivers/ata/ahci_brcmstb.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 5f601553b9b0..dfb273a1194b 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -98,6 +98,15 @@ config SATA_AHCI_PLATFORM
=20
 	  If unsure, say N.
=20
+config AHCI_BRCMSTB
+	tristate "Broadcom STB AHCI SATA support"
+	depends on ARCH_BRCMSTB
+	help
+	  This option enables support for the AHCI SATA3 controller found on
+	  STB SoC's.
+
+	  If unsure, say N.
+
 config AHCI_DA850
 	tristate "DaVinci DA850 AHCI SATA support"
 	depends on ARCH_DAVINCI_DA850
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index b67e995179a9..b95449184ae1 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SATA_INIC162X)	+=3D sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+=3D sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+=3D sata_dwc_460ex.o
 obj-$(CONFIG_SATA_HIGHBANK)	+=3D sata_highbank.o libahci.o
+obj-$(CONFIG_AHCI_BRCMSTB)	+=3D ahci_brcmstb.o libahci.o libahci_platf=
orm.o
 obj-$(CONFIG_AHCI_DA850)	+=3D ahci_da850.o libahci.o libahci_platform.=
o
 obj-$(CONFIG_AHCI_IMX)		+=3D ahci_imx.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_MVEBU)	+=3D ahci_mvebu.o libahci.o libahci_platform.=
o
diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
new file mode 100644
index 000000000000..ce1e3a885981
--- /dev/null
+++ b/drivers/ata/ahci_brcmstb.c
@@ -0,0 +1,322 @@
+/*
+ * Broadcom SATA3 AHCI Controller Driver
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
+#include <linux/ahci_platform.h>
+#include <linux/compiler.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/libata.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+
+#include "ahci.h"
+
+#define DRV_NAME					"brcm-ahci"
+
+#define SATA_TOP_CTRL_VERSION				0x0
+#define SATA_TOP_CTRL_BUS_CTRL				0x4
+ #define MMIO_ENDIAN_SHIFT				0 /* CPU->AHCI */
+ #define DMADESC_ENDIAN_SHIFT				2 /* AHCI->DDR */
+ #define DMADATA_ENDIAN_SHIFT				4 /* AHCI->DDR */
+ #define PIODATA_ENDIAN_SHIFT				6
+  #define ENDIAN_SWAP_NONE				0
+  #define ENDIAN_SWAP_FULL				2
+ #define OVERRIDE_HWINIT				BIT(16)
+#define SATA_TOP_CTRL_TP_CTRL				0x8
+#define SATA_TOP_CTRL_PHY_CTRL				0xc
+ #define SATA_TOP_CTRL_PHY_CTRL_1			0x0
+  #define SATA_TOP_CTRL_1_PHY_DEFAULT_POWER_STATE	BIT(14)
+ #define SATA_TOP_CTRL_PHY_CTRL_2			0x4
+  #define SATA_TOP_CTRL_2_SW_RST_MDIOREG		BIT(0)
+  #define SATA_TOP_CTRL_2_SW_RST_OOB			BIT(1)
+  #define SATA_TOP_CTRL_2_SW_RST_RX			BIT(2)
+  #define SATA_TOP_CTRL_2_SW_RST_TX			BIT(3)
+  #define SATA_TOP_CTRL_2_PHY_GLOBAL_RESET		BIT(14)
+ #define SATA_TOP_CTRL_PHY_OFFS				0x8
+ #define SATA_TOP_MAX_PHYS				2
+#define SATA_TOP_CTRL_SATA_TP_OUT			0x1c
+#define SATA_TOP_CTRL_CLIENT_INIT_CTRL			0x20
+
+/* On big-endian MIPS, buses are reversed to big endian, so switch the=
m back */
+#if defined(CONFIG_MIPS) && defined(__BIG_ENDIAN)
+#define DATA_ENDIAN			 2 /* AHCI->DDR inbound accesses */
+#define MMIO_ENDIAN			 2 /* CPU->AHCI outbound accesses */
+#else
+#define DATA_ENDIAN			 0
+#define MMIO_ENDIAN			 0
+#endif
+
+#define BUS_CTRL_ENDIAN_CONF				\
+	((DATA_ENDIAN << DMADATA_ENDIAN_SHIFT) |	\
+	(DATA_ENDIAN << DMADESC_ENDIAN_SHIFT) |		\
+	(MMIO_ENDIAN << MMIO_ENDIAN_SHIFT))
+
+struct brcm_ahci_priv {
+	struct device *dev;
+	void __iomem *top_ctrl;
+	u32 port_mask;
+};
+
+static const struct ata_port_info ahci_brcm_port_info =3D {
+	.flags		=3D AHCI_FLAG_COMMON,
+	.pio_mask	=3D ATA_PIO4,
+	.udma_mask	=3D ATA_UDMA6,
+	.port_ops	=3D &ahci_platform_ops,
+};
+
+static inline u32 brcm_sata_readreg(void __iomem *addr)
+{
+	/*
+	 * MIPS endianness is configured by boot strap, which also reverses a=
ll
+	 * bus endianness (i.e., big-endian CPU + big endian bus =3D=3D> nati=
ve
+	 * endian I/O).
+	 *
+	 * Other architectures (e.g., ARM) either do not support big endian, =
or
+	 * else leave I/O in little endian mode.
+	 */
+	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
+		return __raw_readl(addr);
+	else
+		return readl_relaxed(addr);
+}
+
+static inline void brcm_sata_writereg(u32 val, void __iomem *addr)
+{
+	/* See brcm_sata_readreg() comments */
+	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(__BIG_ENDIAN))
+		__raw_writel(val, addr);
+	else
+		writel_relaxed(val, addr);
+}
+
+static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port=
)
+{
+	void __iomem *phyctrl =3D priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
+				(port * SATA_TOP_CTRL_PHY_OFFS);
+	void __iomem *p;
+	u32 reg;
+
+	/* clear PHY_DEFAULT_POWER_STATE */
+	p =3D phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
+	reg =3D brcm_sata_readreg(p);
+	reg &=3D ~SATA_TOP_CTRL_1_PHY_DEFAULT_POWER_STATE;
+	brcm_sata_writereg(reg, p);
+
+	/* reset the PHY digital logic */
+	p =3D phyctrl + SATA_TOP_CTRL_PHY_CTRL_2;
+	reg =3D brcm_sata_readreg(p);
+	reg &=3D ~(SATA_TOP_CTRL_2_SW_RST_MDIOREG | SATA_TOP_CTRL_2_SW_RST_OO=
B |
+		 SATA_TOP_CTRL_2_SW_RST_RX);
+	reg |=3D SATA_TOP_CTRL_2_SW_RST_TX;
+	brcm_sata_writereg(reg, p);
+	reg =3D brcm_sata_readreg(p);
+	reg |=3D SATA_TOP_CTRL_2_PHY_GLOBAL_RESET;
+	brcm_sata_writereg(reg, p);
+	reg =3D brcm_sata_readreg(p);
+	reg &=3D ~SATA_TOP_CTRL_2_PHY_GLOBAL_RESET;
+	brcm_sata_writereg(reg, p);
+	(void)brcm_sata_readreg(p);
+}
+
+static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int por=
t)
+{
+	void __iomem *phyctrl =3D priv->top_ctrl + SATA_TOP_CTRL_PHY_CTRL +
+				(port * SATA_TOP_CTRL_PHY_OFFS);
+	void __iomem *p;
+	u32 reg;
+
+	/* power-off the PHY digital logic */
+	p =3D phyctrl + SATA_TOP_CTRL_PHY_CTRL_2;
+	reg =3D brcm_sata_readreg(p);
+	reg |=3D (SATA_TOP_CTRL_2_SW_RST_MDIOREG | SATA_TOP_CTRL_2_SW_RST_OOB=
 |
+		SATA_TOP_CTRL_2_SW_RST_RX | SATA_TOP_CTRL_2_SW_RST_TX |
+		SATA_TOP_CTRL_2_PHY_GLOBAL_RESET);
+	brcm_sata_writereg(reg, p);
+
+	/* set PHY_DEFAULT_POWER_STATE */
+	p =3D phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
+	reg =3D brcm_sata_readreg(p);
+	reg |=3D SATA_TOP_CTRL_1_PHY_DEFAULT_POWER_STATE;
+	brcm_sata_writereg(reg, p);
+}
+
+static void brcm_sata_phys_enable(struct brcm_ahci_priv *priv)
+{
+	int i;
+
+	for (i =3D 0; i < SATA_TOP_MAX_PHYS; i++)
+		if (priv->port_mask & BIT(i))
+			brcm_sata_phy_enable(priv, i);
+}
+
+static void brcm_sata_phys_disable(struct brcm_ahci_priv *priv)
+{
+	int i;
+
+	for (i =3D 0; i < SATA_TOP_MAX_PHYS; i++)
+		if (priv->port_mask & BIT(i))
+			brcm_sata_phy_disable(priv, i);
+}
+
+static u32 brcm_ahci_get_portmask(struct platform_device *pdev,
+				  struct brcm_ahci_priv *priv)
+{
+	void __iomem *ahci;
+	struct resource *res;
+	u32 impl;
+
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci");
+	ahci =3D devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ahci))
+		return 0;
+
+	impl =3D readl(ahci + HOST_PORTS_IMPL);
+
+	if (fls(impl) > SATA_TOP_MAX_PHYS)
+		dev_warn(priv->dev, "warning: more ports than PHYs (%#x)\n",
+			 impl);
+	else if (!impl)
+		dev_info(priv->dev, "no ports found\n");
+
+	devm_iounmap(&pdev->dev, ahci);
+	devm_release_mem_region(&pdev->dev, res->start, resource_size(res));
+
+	return impl;
+}
+
+static void brcm_sata_init(struct brcm_ahci_priv *priv)
+{
+	/* Configure endianness */
+	brcm_sata_writereg(BUS_CTRL_ENDIAN_CONF,
+			   priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
+}
+
+static int brcm_ahci_suspend(struct device *dev)
+{
+	struct ata_host *host =3D dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv =3D host->private_data;
+	struct brcm_ahci_priv *priv =3D hpriv->plat_data;
+	int ret;
+
+	ret =3D ahci_platform_suspend(dev);
+	brcm_sata_phys_disable(priv);
+	return ret;
+}
+
+static int brcm_ahci_resume(struct device *dev)
+{
+	struct ata_host *host =3D dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv =3D host->private_data;
+	struct brcm_ahci_priv *priv =3D hpriv->plat_data;
+
+	brcm_sata_init(priv);
+	brcm_sata_phys_enable(priv);
+	return ahci_platform_resume(dev);
+}
+
+static struct scsi_host_template ahci_platform_sht =3D {
+	AHCI_SHT(DRV_NAME),
+};
+
+static int brcm_ahci_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct brcm_ahci_priv *priv;
+	struct ahci_host_priv *hpriv;
+	struct resource *res;
+	int ret;
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev =3D dev;
+
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "top-ctrl"=
);
+	priv->top_ctrl =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->top_ctrl))
+		return PTR_ERR(priv->top_ctrl);
+
+	brcm_sata_init(priv);
+
+	priv->port_mask =3D brcm_ahci_get_portmask(pdev, priv);
+	if (!priv->port_mask)
+		return -ENODEV;
+
+	brcm_sata_phys_enable(priv);
+
+	hpriv =3D ahci_platform_get_resources(pdev);
+	if (IS_ERR(hpriv))
+		return PTR_ERR(hpriv);
+	hpriv->plat_data =3D priv;
+
+	ret =3D ahci_platform_enable_resources(hpriv);
+	if (ret)
+		return ret;
+
+	ret =3D ahci_platform_init_host(pdev, hpriv, &ahci_brcm_port_info,
+				      &ahci_platform_sht);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "Broadcom AHCI SATA3 registered\n");
+
+	return 0;
+}
+
+static int brcm_ahci_remove(struct platform_device *pdev)
+{
+	struct ata_host *host =3D dev_get_drvdata(&pdev->dev);
+	struct ahci_host_priv *hpriv =3D host->private_data;
+	struct brcm_ahci_priv *priv =3D hpriv->plat_data;
+	int ret;
+
+	ret =3D ata_platform_remove_one(pdev);
+	if (ret)
+		return ret;
+
+	brcm_sata_phys_disable(priv);
+
+	return 0;
+}
+
+static const struct of_device_id ahci_of_match[] =3D {
+	{.compatible =3D "brcm,bcm7445-ahci"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ahci_of_match);
+
+static SIMPLE_DEV_PM_OPS(ahci_brcm_pm_ops, brcm_ahci_suspend, brcm_ahc=
i_resume);
+
+static struct platform_driver brcm_ahci_driver =3D {
+	.probe =3D brcm_ahci_probe,
+	.remove =3D brcm_ahci_remove,
+	.driver =3D {
+		.name =3D DRV_NAME,
+		.of_match_table =3D ahci_of_match,
+		.pm =3D &ahci_brcm_pm_ops,
+	},
+};
+module_platform_driver(brcm_ahci_driver);
+
+MODULE_DESCRIPTION("Broadcom SATA3 AHCI Controller Driver");
+MODULE_AUTHOR("Brian Norris");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sata-brcmstb");
--=20
1.9.1

