From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [PATCH] pci: imx: enable pcie msi support
Date: Mon,  9 Dec 2013 17:25:19 +0800
Message-ID: <1386581119-2962-2-git-send-email-richard.zhuhongxing@gmail.com>
References: <1386581119-2962-1-git-send-email-richard.zhuhongxing@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:62697 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760715Ab3LIJUR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Dec 2013 04:20:17 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so4875291pde.20
        for <linux-ide@vger.kernel.org>; Mon, 09 Dec 2013 01:20:17 -0800 (PST)
In-Reply-To: <1386581119-2962-1-git-send-email-richard.zhuhongxing@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: marex@denx.de
Cc: jbe@pengutronix.de, hrhaan@gmail.com, shawn.guo@linaro.org, jgarzik@pobox.com, tj@kernel.org, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>, Richard Zhu <richard.zhuhongxing@gmail.com>

From: Richard Zhu <r65037@freescale.com>

eanble pcie msi support on imx6 platforms
* add check_device api in the msi chip.
* add the quirks into pcie_port struct for the deviation
from standard routines.

Signed-off-by: Richard Zhu <richard.zhuhongxing@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |    6 +++
 arch/arm/mach-imx/Kconfig              |    1 +
 drivers/pci/host/pci-imx6.c            |   34 +++++++++++++++++-
 drivers/pci/host/pcie-designware.c     |   60 +++++++++++++++++++++++---------
 drivers/pci/host/pcie-designware.h     |    5 +++
 5 files changed, 88 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index e75e11b..b821f87 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -212,6 +212,12 @@
 	};
 };
 
+&pcie {
+	power-on-gpio = <&gpio3 19 0>;
+	reset-gpio = <&gpio7 12 0>;
+	status = "okay";
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm0_1>;
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7a6e6f7..3083c5b 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -796,6 +796,7 @@ config SOC_IMX6Q
 	select MFD_SYSCON
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
+	select ARCH_SUPPORTS_MSI
 	select PINCTRL
 	select PINCTRL_IMX6Q
 	select PL310_ERRATA_588369 if CACHE_PL310
diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index bd70af8..fbd75bf 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
@@ -299,6 +300,15 @@ static void imx6_pcie_init_phy(struct pcie_port *pp)
 			IMX6Q_GPR8_TX_SWING_LOW, 127 << 25);
 }
 
+static irqreturn_t imx_pcie_msi_irq_handler(int irq, void *arg)
+{
+	struct pcie_port *pp = arg;
+
+	dw_handle_msi_irq(pp);
+
+	return IRQ_HANDLED;
+}
+
 static void imx6_pcie_host_init(struct pcie_port *pp)
 {
 	int count = 0;
@@ -324,10 +334,16 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 				"DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
 				readl(pp->dbi_base + PCIE_PHY_DEBUG_R0),
 				readl(pp->dbi_base + PCIE_PHY_DEBUG_R1));
-			break;
+			return;
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->quirks |= DW_PCIE_QUIRK_NO_MSI_VEC;
+		pp->quirks |= DW_PCIE_QUIRK_MSI_SELF_EN;
+		dw_pcie_msi_init(pp);
+	}
+
 	return;
 }
 
@@ -393,6 +409,22 @@ static int imx6_add_pcie_port(struct pcie_port *pp,
 		return -ENODEV;
 	}
 
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		pp->msi_irq = pp->irq - 3;
+		if (!pp->msi_irq) {
+			dev_err(&pdev->dev, "failed to get msi irq\n");
+			return -ENODEV;
+		}
+
+		ret = devm_request_irq(&pdev->dev, pp->msi_irq,
+					imx_pcie_msi_irq_handler,
+					IRQF_SHARED, "imx6q-pcie", pp);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to request msi irq\n");
+			return ret;
+		}
+	}
+
 	pp->root_bus_nr = -1;
 	pp->ops = &imx6_pcie_host_ops;
 
diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index e33b68b..96d2b78 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -308,23 +308,28 @@ static int dw_msi_setup_irq(struct msi_chip *chip, struct pci_dev *pdev,
 		return -EINVAL;
 	}
 
-	pci_read_config_word(pdev, desc->msi_attrib.pos+PCI_MSI_FLAGS,
-				&msg_ctr);
-	msgvec = (msg_ctr&PCI_MSI_FLAGS_QSIZE) >> 4;
-	if (msgvec == 0)
-		msgvec = (msg_ctr & PCI_MSI_FLAGS_QMASK) >> 1;
-	if (msgvec > 5)
-		msgvec = 0;
-
-	irq = assign_irq((1 << msgvec), desc, &pos);
-	if (irq < 0)
-		return irq;
-
-	msg_ctr &= ~PCI_MSI_FLAGS_QSIZE;
-	msg_ctr |= msgvec << 4;
-	pci_write_config_word(pdev, desc->msi_attrib.pos + PCI_MSI_FLAGS,
-				msg_ctr);
-	desc->msi_attrib.multiple = msgvec;
+	if (pp->quirks & DW_PCIE_QUIRK_NO_MSI_VEC) {
+		irq = assign_irq(1, desc, &pos);
+		set_irq_flags(irq, IRQF_VALID);
+	} else {
+		pci_read_config_word(pdev, desc->msi_attrib.pos+PCI_MSI_FLAGS,
+					&msg_ctr);
+		msgvec = (msg_ctr&PCI_MSI_FLAGS_QSIZE) >> 4;
+		if (msgvec == 0)
+			msgvec = (msg_ctr & PCI_MSI_FLAGS_QMASK) >> 1;
+		if (msgvec > 5)
+			msgvec = 0;
+
+		irq = assign_irq((1 << msgvec), desc, &pos);
+		if (irq < 0)
+			return irq;
+
+		msg_ctr &= ~PCI_MSI_FLAGS_QSIZE;
+		msg_ctr |= msgvec << 4;
+		pci_write_config_word(pdev, desc->msi_attrib.pos + PCI_MSI_FLAGS,
+					msg_ctr);
+		desc->msi_attrib.multiple = msgvec;
+	}
 
 	msg.address_lo = virt_to_phys((void *)pp->msi_data);
 	msg.address_hi = 0x0;
@@ -339,9 +344,30 @@ static void dw_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
 	clear_irq(irq);
 }
 
+static int dw_msi_check_device(struct msi_chip *chip, struct pci_dev *pdev,
+		int nvec, int type)
+{
+	struct pcie_port *pp = sys_to_pcie(pdev->bus->sysdata);
+	u32 val;
+
+	if (pp->quirks & DW_PCIE_QUIRK_MSI_SELF_EN) {
+		if ((type == PCI_CAP_ID_MSI) || (type == PCI_CAP_ID_MSIX)) {
+			/* Set MSI enable of RC here */
+			val = readl(pp->dbi_base + 0x50);
+			if ((val & (PCI_MSI_FLAGS_ENABLE << 16)) == 0) {
+				val |= PCI_MSI_FLAGS_ENABLE << 16;
+				writel(val, pp->dbi_base + 0x50);
+			}
+		}
+	}
+
+	return 0;
+}
+
 static struct msi_chip dw_pcie_msi_chip = {
 	.setup_irq = dw_msi_setup_irq,
 	.teardown_irq = dw_msi_teardown_irq,
+	.check_device = dw_msi_check_device,
 };
 
 int dw_pcie_link_up(struct pcie_port *pp)
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index c15379b..79111fe 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -49,6 +49,11 @@ struct pcie_port {
 	int			irq;
 	u32			lanes;
 	struct pcie_host_ops	*ops;
+	u32			quirks;		/* Deviations from spec. */
+/* Controller doesn't support MSI VEC */
+#define DW_PCIE_QUIRK_NO_MSI_VEC	(1<<0)
+/* MSI EN of Controller should be configured when MSI is enabled */
+#define DW_PCIE_QUIRK_MSI_SELF_EN	(1<<1)
 	int			msi_irq;
 	struct irq_domain	*irq_domain;
 	unsigned long		msi_data;
-- 
1.7.5.4

