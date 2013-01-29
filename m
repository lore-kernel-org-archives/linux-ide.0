From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: [PATCH] driver: ata: add new Exynos5250 SATA controller driver
Date: Tue, 29 Jan 2013 20:52:44 +0530
Message-ID: <1359472964-31445-1-git-send-email-vasanthananthan@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, jgarzik@redhat.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, thomas.abraham@linaro.org, girish.shivananjappa@linaro.org, Vasanth Ananthan <vasanthananthan@gmail.com>, Vasanth Ananthan <vasanth.a@samsung.com>
List-Id: linux-ide@vger.kernel.org

Adding platform driver for AHCI based SATA controller for Exynos5250.
The SATA controller in Exynos5250 is an AHCI based controller. Though
the controller implements only one port, the driver is scalable for
maximum number of ports possible. The drivers uses libahci framework
to initialize the controller and the ports implemented.

The driver also initializes the PHY controllers associated with the
sata controller, for which the port-phy mapping have to provided
in the device tree node of the sata controller node. The driver extracts
the device_node of the PHY controller provided in the mapping, passes it
the SATA PHY framework. The framework, return the corresponding PHY,
if it has be registered with the framework, after which the driver
intializes the PHY controller(s).

Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
---
 .../devicetree/bindings/ata/exynos-sata.txt        |   16 +-
 drivers/ata/Kconfig                                |   12 +
 drivers/ata/Makefile                               |    1 +
 drivers/ata/sata_exynos.c                          |  308 ++++++++++++++++++++
 4 files changed, 336 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ata/sata_exynos.c

diff --git a/Documentation/devicetree/bindings/ata/exynos-sata.txt b/Documentation/devicetree/bindings/ata/exynos-sata.txt
index 0849f10..7247ad2 100644
--- a/Documentation/devicetree/bindings/ata/exynos-sata.txt
+++ b/Documentation/devicetree/bindings/ata/exynos-sata.txt
@@ -8,10 +8,24 @@ Required properties:
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
 - samsung,sata-freq : <frequency in MHz>
+- samsung,exynos-sata-phy" : <phandle> This property specifies the PHY
+controller handle associated with each port in order.
 
-Example:
+Example: SATA with 2 port
         sata@ffe08000 {
                 compatible = "samsung,exynos5-sata";
                 reg = <0xffe08000 0x1000>;
                 interrupts = <115>;
+		samsung,sata-freq = <52>;
+		samsung,exynos-sata-phy = <&phy0 &phy1>;
+		};
         };
+
+	phy0: sata-phy@ffe09000 {
+		compatible = "samsung,exynos5250-sata-phy";
+		reg = <0xffe09000 0x1ff>;
+	}
+	phy1: sata-phy@ffe07000 {
+                compatible = "samsung,exynos5250-sata-phy";
+                reg = <0xffe07000 0x1ff>;
+        }
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 99c1e1b..8e61cf5 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -106,6 +106,18 @@ config SATA_PHY
 	  registers itself with the framework through the APIs provided and the SATA
 	  controller finds and requests for an appropriate PHY controller.
 
+config SATA_EXYNOS
+        bool "Exynos SATA AHCI support"
+        select I2C
+        select HAVE_S3C2410_I2C
+        select I2C_S3C2410
+        select SATA_PHY
+        help
+          This option enables support for Exynos AHCI Serial ATA
+          controllers.
+
+          If unsure, say N.
+
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
 	depends on FSL_SOC
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 7add682..c3a97f0 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
 obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
 obj-$(CONFIG_SATA_PHY)		+= sata_phy.o sata_exynos_phy.o
+obj-$(CONFIG_SATA_EXYNOS)	+= sata_exynos.o libahci.o
 
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
diff --git a/drivers/ata/sata_exynos.c b/drivers/ata/sata_exynos.c
new file mode 100644
index 0000000..44a6dd7
--- /dev/null
+++ b/drivers/ata/sata_exynos.c
@@ -0,0 +1,308 @@
+/*
+ * Copyright (c) 2010-2012 Samsung Electronics Co., Ltd.
+ *              http://www.samsung.com
+ *
+ * EXYNOS - SATA controller platform driver wrapper
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/gfp.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/libata.h>
+#include <linux/ahci_platform.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+
+#include "ahci.h"
+#include "sata_phy.h"
+
+#define MHZ		(1000 * 1000)
+#define DEFERED		1
+#define NO_PORT		0
+
+static const struct ata_port_info ahci_port_info = {
+	.flags = AHCI_FLAG_COMMON,
+	.pio_mask = ATA_PIO4,
+	.udma_mask = ATA_UDMA6,
+	.port_ops = &ahci_ops,
+};
+
+static struct scsi_host_template ahci_platform_sht = {
+	AHCI_SHT("ahci_platform"),
+};
+
+struct exynos_sata {
+	struct clk *sclk;
+	struct clk *clk;
+	int irq;
+	unsigned int freq;
+	struct sata_phy *phy[];
+};
+
+static int exynos_sata_parse_dt(struct device_node *np,
+					struct exynos_sata *sata)
+{
+	if (!np)
+		return -EINVAL;
+
+	return of_property_read_u32(np, "samsung,sata-freq",
+						&sata->freq);
+}
+
+static int __init exynos_sata_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ata_port_info pi = ahci_port_info;
+	const struct ata_port_info *ppi[] = { &pi, NULL };
+	struct ahci_host_priv *hpriv;
+	struct exynos_sata *sata;
+	struct ata_host *host;
+	struct device_node *of_node_phy = NULL;
+	static int flag = 0, port_init = NO_PORT;
+	int n_ports, i, ret;
+
+	sata = devm_kzalloc(dev, sizeof(*sata), GFP_KERNEL);
+	if (!sata) {
+		dev_err(dev, "can't alloc sata\n");
+		return -ENOMEM;
+	}
+
+	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv) {
+		dev_err(dev, "can't alloc ahci_host_priv\n");
+		return -ENOMEM;
+	}
+
+	hpriv->flags |= (unsigned long)pi.private_data;
+
+	sata->irq = irq_of_parse_and_map(dev->of_node, 0);
+	if (sata->irq <= 0) {
+		dev_err(dev, "irq not specified\n");
+		return -EINVAL;
+	}
+
+	hpriv->mmio = of_iomap(dev->of_node, 0);
+	if (!hpriv->mmio) {
+		dev_err(dev, "failed to map IO\n");
+		return -ENOMEM;
+	}
+
+	ret = exynos_sata_parse_dt(dev->of_node, sata);
+	if (ret < 0) {
+		dev_err(dev, "failed to get frequency for sata ctrl\n");
+		goto err_iomap;
+	}
+
+	sata->sclk = devm_clk_get(dev, "sclk_sata");
+	if (IS_ERR(sata->sclk)) {
+		dev_err(dev, "failed to get sclk_sata\n");
+		ret = PTR_ERR(sata->sclk);
+		goto err_iomap;
+	}
+
+	ret = clk_enable(sata->sclk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable source clk\n");
+		goto err_iomap;
+	}
+
+	ret = clk_set_rate(sata->sclk, sata->freq * MHZ);
+	if (ret < 0) {
+		dev_err(dev, "failed to set clk frequency\n");
+		goto err_clkstrt;
+	}
+
+	sata->clk = devm_clk_get(dev, "sata");
+	if (IS_ERR(sata->clk)) {
+		dev_err(dev, "failed to get sata clock\n");
+		ret = PTR_ERR(sata->clk);
+		goto err_clkstrt;
+	}
+
+	ret = clk_enable(sata->clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable source clk\n");
+		goto err_clkstrt;
+	}
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
+	/* CAP.NP sometimes indicate the index of the last enabled
+	 * port, at other times, that of the last possible port, so
+	 * determining the maximum port number requires looking at
+	 * both CAP.NP and port_map.
+	 */
+	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
+
+	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
+	if (!host) {
+		ret = -ENOMEM;
+		goto err_clken;
+	}
+
+	host->private_data = hpriv;
+
+	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
+		host->flags |= ATA_HOST_PARALLEL_SCAN;
+	else
+		pr_info(KERN_INFO
+		       "ahci: SSS flag set, parallel bus scan disabled\n");
+
+	if (pi.flags & ATA_FLAG_EM)
+		ahci_reset_em(host);
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		of_node_phy = of_parse_phandle(dev->of_node,
+						"samsung,exynos-sata-phy", i);
+		if (!of_node_phy) {
+			dev_err(dev,
+				"phandle of phy not found for port %d\n", i);
+			break;
+		}
+
+		sata->phy[i] = sata_get_phy(of_node_phy);
+		if (IS_ERR(sata->phy[i])) {
+			if (PTR_ERR(sata->phy[i]) == -EBUSY)
+				continue;
+			dev_err(dev,
+				"failed to get sata phy for port %d\n", i);
+			if (flag != DEFERED) {
+				flag = DEFERED ;
+				return -EPROBE_DEFER;
+			} else
+				continue;
+
+		}
+		/* Initialize the PHY */
+		ret = sata_init_phy(sata->phy[i]);
+		if (ret < 0) {
+			if (ret == -EPROBE_DEFER) {
+				if (flag != DEFERED) {
+					flag = DEFERED ;
+					sata_put_phy(sata->phy[i]);
+					return -EPROBE_DEFER;
+				} else {
+					continue;
+				}
+			} else {
+				dev_err(dev,
+				"failed to initialize sata phy for port %d\n",
+				i);
+				sata_put_phy(sata->phy[i]);
+			}
+
+		}
+
+		/* set enclosure management message type */
+		if (ap->flags & ATA_FLAG_EM)
+			ap->em_message_type = hpriv->em_msg_type;
+
+		/* disabled/not-implemented port */
+		if (!(hpriv->port_map & (1 << i)))
+			ap->ops = &ata_dummy_port_ops;
+
+		port_init++;
+	}
+
+	if (port_init == NO_PORT)
+		goto err_initphy;
+
+	ret = ahci_reset_controller(host);
+	if (ret)
+		goto err_rst;
+
+	ahci_init_controller(host);
+	ahci_print_info(host, "platform");
+
+	ret = ata_host_activate(host, sata->irq, ahci_interrupt, IRQF_SHARED,
+				&ahci_platform_sht);
+	if (ret)
+		goto err_rst;
+
+	platform_set_drvdata(pdev, sata);
+
+	return 0;
+
+
+ err_rst:
+	for (i = 0; i < host->n_ports; i++)
+		sata_shutdown_phy(sata->phy[i]);
+
+ err_initphy:
+	for (i = 0; i < host->n_ports; i++)
+		sata_put_phy(sata->phy[i]);
+
+ err_clken:
+	clk_disable(sata->clk);
+
+ err_clkstrt:
+	clk_disable(sata->sclk);
+
+ err_iomap:
+	iounmap(hpriv->mmio);
+
+	return ret;
+}
+
+static int __devexit exynos_sata_remove(struct platform_device *pdev)
+{
+	unsigned int i;
+	struct device *dev = &pdev->dev;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct exynos_sata *sata = platform_get_drvdata(pdev);
+	struct ahci_host_priv *hpriv =
+			(struct ahci_host_priv *)host->private_data;
+
+	ata_host_detach(host);
+
+	for (i = 0; i < host->n_ports; i++) {
+		sata_shutdown_phy(sata->phy[i]);
+		sata_put_phy(sata->phy[i]);
+	}
+	iounmap(hpriv->mmio);
+
+	return 0;
+}
+
+static const struct of_device_id ahci_of_match[] = {
+	{ .compatible = "samsung,exynos5250-ahci", },
+};
+
+MODULE_DEVICE_TABLE(of, ahci_of_match);
+
+static struct platform_driver exynos_sata_driver = {
+	.probe	= exynos_sata_probe,
+	.remove = exynos_sata_remove,
+	.driver = {
+		.name = "exynos-sata",
+		.owner = THIS_MODULE,
+		.of_match_table = ahci_of_match,
+	},
+};
+
+module_platform_driver(exynos_sata_driver);
+
+MODULE_DESCRIPTION("EXYNOS SATA DRIVER");
+MODULE_AUTHOR("Vasanth Ananthan, <vasanth.a@samsung.com>");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
