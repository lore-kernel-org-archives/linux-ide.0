From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFC v4 03/10] ahci-platform: Pass ahci_host_priv
 ptr to ahci_platform_data init method
Date: Mon, 20 Jan 2014 17:44:56 +0100
Message-ID: <1390236303-22538-4-git-send-email-hdegoede@redhat.com>
References: <1390236303-22538-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBH5F6WLAKGQEKMNJ33Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1390236303-22538-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Some ahci_platform_data->init methods need access to the ahci_host_priv data.

When calling ahci_platform_data->init the ata_host has not been allocated yet,
so access to ahci_host_priv through the dev argument is not possible.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mach-davinci/devices-da8xx.c |  5 +++--
 arch/arm/mach-spear/spear1340.c       |  2 +-
 drivers/ata/ahci_imx.c                | 12 ++++++------
 drivers/ata/ahci_platform.c           |  2 +-
 include/linux/ahci_platform.h         |  3 ++-
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 78829c5..28e7c4c 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-contiguous.h>
 #include <linux/serial_8250.h>
+#include <linux/ahci.h>
 #include <linux/ahci_platform.h>
 #include <linux/clk.h>
 #include <linux/reboot.h>
@@ -1061,7 +1062,7 @@ static unsigned long da850_sata_xtal[] = {
 	KHZ_TO_HZ(60000),
 };
 
-static int da850_sata_init(struct device *dev, void __iomem *addr)
+static int da850_sata_init(struct device *dev, struct ahci_host_priv *hpriv)
 {
 	int i, ret;
 	unsigned int val;
@@ -1096,7 +1097,7 @@ static int da850_sata_init(struct device *dev, void __iomem *addr)
 		SATA_PHY_TXSWING(3) |
 		SATA_PHY_ENPLL(1);
 
-	__raw_writel(val, addr + SATA_P0PHYCR_REG);
+	__raw_writel(val, hpriv->mmio + SATA_P0PHYCR_REG);
 
 	return 0;
 
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 3fb6834..9e2f3ac 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -77,7 +77,7 @@
 			SPEAR1340_MIPHY_PLL_RATIO_TOP(25))
 
 /* SATA device registration */
-static int sata_miphy_init(struct device *dev, void __iomem *addr)
+static int sata_miphy_init(struct device *dev, struct ahci_host_priv *hpriv)
 {
 	writel(SPEAR1340_SATA_CFG_VAL, SPEAR1340_PCIE_SATA_CFG);
 	writel(SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK,
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 3e23e99..49fa0ca 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -91,7 +91,7 @@ static const struct ata_port_info ahci_imx_port_info = {
 	.port_ops	= &ahci_imx_ops,
 };
 
-static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
+static int imx6q_sata_init(struct device *dev, struct ahci_host_priv *hpriv)
 {
 	int ret = 0;
 	unsigned int reg_val;
@@ -145,19 +145,19 @@ static int imx6q_sata_init(struct device *dev, void __iomem *mmio)
 	 * Implement the port0.
 	 * Get the ahb clock rate, and configure the TIMER1MS register.
 	 */
-	reg_val = readl(mmio + HOST_CAP);
+	reg_val = readl(hpriv->mmio + HOST_CAP);
 	if (!(reg_val & HOST_CAP_SSS)) {
 		reg_val |= HOST_CAP_SSS;
-		writel(reg_val, mmio + HOST_CAP);
+		writel(reg_val, hpriv->mmio + HOST_CAP);
 	}
-	reg_val = readl(mmio + HOST_PORTS_IMPL);
+	reg_val = readl(hpriv->mmio + HOST_PORTS_IMPL);
 	if (!(reg_val & 0x1)) {
 		reg_val |= 0x1;
-		writel(reg_val, mmio + HOST_PORTS_IMPL);
+		writel(reg_val, hpriv->mmio + HOST_PORTS_IMPL);
 	}
 
 	reg_val = clk_get_rate(imxpriv->ahb_clk) / 1000;
-	writel(reg_val, mmio + HOST_TIMER1MS);
+	writel(reg_val, hpriv->mmio + HOST_TIMER1MS);
 
 	return 0;
 }
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 4b231ba..434ab89 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -149,7 +149,7 @@ static int ahci_probe(struct platform_device *pdev)
 	 * returned successfully.
 	 */
 	if (pdata && pdata->init) {
-		rc = pdata->init(dev, hpriv->mmio);
+		rc = pdata->init(dev, hpriv);
 		if (rc)
 			goto disable_unprepare_clk;
 	}
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 73a2500..737fe38 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -19,9 +19,10 @@
 
 struct device;
 struct ata_port_info;
+struct ahci_host_priv;
 
 struct ahci_platform_data {
-	int (*init)(struct device *dev, void __iomem *addr);
+	int (*init)(struct device *dev, struct ahci_host_priv *hpriv);
 	void (*exit)(struct device *dev);
 	int (*suspend)(struct device *dev);
 	int (*resume)(struct device *dev);
-- 
1.8.5.3
