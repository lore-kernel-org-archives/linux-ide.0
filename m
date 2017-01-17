From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 11/14] sata: ahci-da850: un-hardcode the MPY bits
Date: Tue, 17 Jan 2017 13:26:13 +0100
Message-ID: <1484655976-25382-12-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-ide@vger.kernel.org

In order to make the MPY bits configurable, try to obtain the refclk
and calculate the required multiplier from its rate.

If we fail to get the clock, fall back to the default value which
keeps backwards compatibility.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/ata/ahci_da850.c | 88 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 76 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index a7a7161..f48b7d0 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
+#include <asm/div64.h>
 #include "ahci.h"
 
 #define DRV_NAME		"ahci_da850"
@@ -30,16 +31,14 @@
 #define SATA_PHY_ENPLL(x)	((x) << 31)
 
 /*
- * The multiplier needed for 1.5GHz PLL output.
- *
- * NOTE: This is currently hardcoded to be suitable for 100MHz crystal
- * frequency (which is used by DA850 EVM board) and may need to be changed
- * if you would like to use this driver on some other board.
+ * This is the default multiplier value used if the refclk could not be
+ * obtained. It corresponds with a crystal rate of 100MHz for 1.5GHz PLL
+ * output.
  */
-#define DA850_SATA_CLK_MULTIPLIER	7
+#define DA850_SATA_MPY_DEFAULT	0x8
 
 static void da850_sata_init(struct device *dev, void __iomem *pwrdn_reg,
-			    void __iomem *ahci_base)
+			    void __iomem *ahci_base, u32 mpy)
 {
 	unsigned int val;
 
@@ -48,13 +47,56 @@ static void da850_sata_init(struct device *dev, void __iomem *pwrdn_reg,
 	val &= ~BIT(0);
 	writel(val, pwrdn_reg);
 
-	val = SATA_PHY_MPY(DA850_SATA_CLK_MULTIPLIER + 1) | SATA_PHY_LOS(1) |
-	      SATA_PHY_RXCDR(4) | SATA_PHY_RXEQ(1) | SATA_PHY_TXSWING(3) |
-	      SATA_PHY_ENPLL(1);
+	val = SATA_PHY_MPY(mpy) | SATA_PHY_LOS(1) | SATA_PHY_RXCDR(4) |
+	      SATA_PHY_RXEQ(1) | SATA_PHY_TXSWING(3) | SATA_PHY_ENPLL(1);
 
 	writel(val, ahci_base + SATA_P0PHYCR_REG);
 }
 
+static u32 ahci_da850_calculate_mpy(unsigned long refclk_rate)
+{
+	u64 pll_output = 1500000000;
+	u32 needed;
+
+	/*
+	 * We need to determine the value of the multiplier (MPY) bits.
+	 *
+	 * In order to include the 12.5 multiplier we need to first multiply
+	 * the desired rate of 1.5GHz by 10 before division.
+	 */
+	pll_output *= 10;
+	needed = __div64_32(&pll_output, refclk_rate);
+
+	/*
+	 * What we have now is (multiplier * 10).
+	 *
+	 * Let's determine the actual register value we need to write.
+	 */
+
+	switch (needed) {
+	case 50:
+		return 0x1;
+	case 60:
+		return 0x2;
+	case 80:
+		return 0x4;
+	case 100:
+		return 0x5;
+	case 120:
+		return 0x6;
+	case 125:
+		return 0x7;
+	case 150:
+		return 0x8;
+	case 200:
+		return 0x9;
+	case 250:
+		return 0xa;
+	default:
+		return DA850_SATA_MPY_DEFAULT;
+	}
+}
+
 static int ahci_da850_softreset(struct ata_link *link,
 				unsigned int *class, unsigned long deadline)
 {
@@ -126,9 +168,10 @@ static int ahci_da850_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
-	struct resource *res;
 	void __iomem *pwrdn_reg;
+	struct resource *res;
 	struct clk *clk;
+	u32 mpy;
 	int rc;
 
 	hpriv = ahci_platform_get_resources(pdev);
@@ -150,6 +193,27 @@ static int ahci_da850_probe(struct platform_device *pdev)
 		hpriv->clks[0] = clk;
 	}
 
+	/*
+	 * The second clock used by ahci-da850 is the external REFCLK. If we
+	 * didn't get it from ahci_platform_get_resources(), let's try to
+	 * specify the con_id in clk_get(). If we still don't get a clock,
+	 * we'll use the default value that works for the da850-evm board.
+	 */
+	if (!hpriv->clks[1]) {
+		clk = clk_get(dev, "refclk");
+		if (IS_ERR(clk))
+			hpriv->clks[1] = NULL;
+		else
+			hpriv->clks[1] = clk;
+	}
+
+	if (!hpriv->clks[1]) {
+		dev_info(dev, "unable to obtain the reference clock - using default multiplier");
+		mpy = DA850_SATA_MPY_DEFAULT;
+	} else {
+		mpy = ahci_da850_calculate_mpy(clk_get_rate(hpriv->clks[1]));
+	}
+
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
@@ -162,7 +226,7 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	if (!pwrdn_reg)
 		goto disable_resources;
 
-	da850_sata_init(dev, pwrdn_reg, hpriv->mmio);
+	da850_sata_init(dev, pwrdn_reg, hpriv->mmio, mpy);
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_da850_port_info,
 				     &ahci_platform_sht);
-- 
2.9.3
