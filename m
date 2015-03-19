From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
Date: Wed, 18 Mar 2015 18:23:40 -0700
Message-ID: <1426728222-8197-3-git-send-email-computersforpeace@gmail.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35387 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916AbbCSBY1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Mar 2015 21:24:27 -0400
In-Reply-To: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Pretty straightforward driver, using the nice library-ization of the
generic ahci_platform driver.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/ata/Kconfig        |   9 +++
 drivers/ata/Makefile       |   1 +
 drivers/ata/sata_brcmstb.c | 148 +++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 drivers/ata/sata_brcmstb.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 5f601553b9b0..33d4b3031705 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -98,6 +98,15 @@ config SATA_AHCI_PLATFORM
=20
 	  If unsure, say N.
=20
+config SATA_BRCMSTB
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
index ae41107afc1f..5d1e6a96bc93 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_ATA)		+=3D libata.o
 obj-$(CONFIG_SATA_AHCI)		+=3D ahci.o libahci.o
 obj-$(CONFIG_SATA_ACARD_AHCI)	+=3D acard-ahci.o libahci.o
 obj-$(CONFIG_SATA_AHCI_PLATFORM) +=3D ahci_platform.o libahci.o libahc=
i_platform.o
+obj-$(CONFIG_SATA_BRCMSTB)	+=3D sata_brcmstb.o libahci.o libahci_platf=
orm.o
 obj-$(CONFIG_SATA_FSL)		+=3D sata_fsl.o
 obj-$(CONFIG_SATA_INIC162X)	+=3D sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+=3D sata_sil24.o
diff --git a/drivers/ata/sata_brcmstb.c b/drivers/ata/sata_brcmstb.c
new file mode 100644
index 000000000000..2a3aff419332
--- /dev/null
+++ b/drivers/ata/sata_brcmstb.c
@@ -0,0 +1,148 @@
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
+#define DRV_NAME			"brcm-ahci"
+
+#define SATA_TOP_CTRL_VERSION		0x0
+#define SATA_TOP_CTRL_BUS_CTRL		0x4
+
+#ifdef __BIG_ENDIAN
+#define DATA_ENDIAN			 2 /* AHCI->DDR inbound accesses */
+#define MMIO_ENDIAN			 2 /* CPU->AHCI outbound accesses */
+#else
+#define DATA_ENDIAN			 0
+#define MMIO_ENDIAN			 0
+#endif
+
+struct brcm_ahci_priv {
+	struct device *dev;
+	struct ahci_host_priv *hpriv;
+
+	void __iomem *top_ctrl;
+};
+
+static const struct ata_port_info ahci_brcm_port_info =3D {
+	.flags		=3D AHCI_FLAG_COMMON,
+	.pio_mask	=3D ATA_PIO4,
+	.udma_mask	=3D ATA_UDMA6,
+	.port_ops	=3D &ahci_platform_ops,
+};
+
+static void brcm_sata3_init_config(struct brcm_ahci_priv *priv)
+{
+	/* Configure endianness */
+	writel((DATA_ENDIAN << 4) | (DATA_ENDIAN << 2) | (MMIO_ENDIAN << 0),
+		priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL);
+}
+
+static int brcm_ahci_suspend(struct device *dev)
+{
+	return ahci_platform_suspend(dev);
+}
+
+static int brcm_ahci_resume(struct device *dev)
+{
+	struct brcm_ahci_priv *priv =3D dev_get_drvdata(dev);
+
+	brcm_sata3_init_config(priv);
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
+	dev_set_drvdata(dev, priv);
+	priv->dev =3D dev;
+
+	hpriv =3D ahci_platform_get_resources(pdev);
+	if (IS_ERR(hpriv))
+		return PTR_ERR(hpriv);
+
+	priv->hpriv =3D hpriv;
+
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "top-ctrl"=
);
+	priv->top_ctrl =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->top_ctrl))
+		return PTR_ERR(priv->top_ctrl);
+
+	brcm_sata3_init_config(priv);
+
+	ret =3D ahci_platform_enable_resources(hpriv);
+	if (ret)
+		return ret;
+
+	hpriv->plat_data =3D priv;
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
+static const struct of_device_id ahci_of_match[] =3D {
+	{.compatible =3D "brcm,sata3-ahci"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ahci_of_match);
+
+static SIMPLE_DEV_PM_OPS(ahci_brcm_pm_ops, brcm_ahci_suspend, brcm_ahc=
i_resume);
+
+static struct platform_driver brcm_ahci_driver =3D {
+	.probe =3D brcm_ahci_probe,
+	.remove =3D ata_platform_remove_one,
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

