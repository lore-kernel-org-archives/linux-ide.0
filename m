From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v7 11/14] sata: ahci-da850: un-hardcode the MPY bits
Date: Mon, 30 Jan 2017 11:02:08 +0100
Message-ID: <1485770531-6772-12-git-send-email-bgolaszewski@baylibre.com>
References: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485770531-6772-1-git-send-email-bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

All platforms using this driver now register the SATA refclk. Remove
the hardcoded default value from the driver and instead read the rate
of the external clock and calculate the required MPY value from it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Acked-by: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/ata/ahci_da850.c | 91 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index d65088a..44bb795 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -29,17 +29,8 @@
 #define SATA_PHY_TXSWING(x)	((x) << 19)
 #define SATA_PHY_ENPLL(x)	((x) << 31)
 
-/*
- * The multiplier needed for 1.5GHz PLL output.
- *
- * NOTE: This is currently hardcoded to be suitable for 100MHz crystal
- * frequency (which is used by DA850 EVM board) and may need to be changed
- * if you would like to use this driver on some other board.
- */
-#define DA850_SATA_CLK_MULTIPLIER	7
-
 static void da850_sata_init(struct device *dev, void __iomem *pwrdn_reg,
-			    void __iomem *ahci_base)
+			    void __iomem *ahci_base, u32 mpy)
 {
 	unsigned int val;
 
@@ -48,13 +39,61 @@ static void da850_sata_init(struct device *dev, void __iomem *pwrdn_reg,
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
+	u32 pll_output = 1500000000, needed;
+
+	/*
+	 * We need to determine the value of the multiplier (MPY) bits.
+	 * In order to include the 12.5 multiplier we need to first divide
+	 * the refclk rate by ten.
+	 *
+	 * __div64_32() turned out to be unreliable, sometimes returning
+	 * false results.
+	 */
+	WARN((refclk_rate % 10) != 0, "refclk must be divisible by 10");
+	needed = pll_output / (refclk_rate / 10);
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
+		/*
+		 * We should have divided evenly - if not, return an invalid
+		 * value.
+		 */
+		return 0;
+	}
+}
+
 static int ahci_da850_softreset(struct ata_link *link,
 				unsigned int *class, unsigned long deadline)
 {
@@ -126,9 +165,10 @@ static int ahci_da850_probe(struct platform_device *pdev)
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
@@ -150,6 +190,27 @@ static int ahci_da850_probe(struct platform_device *pdev)
 		hpriv->clks[0] = clk;
 	}
 
+	/*
+	 * The second clock used by ahci-da850 is the external REFCLK. If we
+	 * didn't get it from ahci_platform_get_resources(), let's try to
+	 * specify the con_id in clk_get().
+	 */
+	if (!hpriv->clks[1]) {
+		clk = clk_get(dev, "refclk");
+		if (IS_ERR(clk)) {
+			dev_err(dev, "unable to obtain the reference clock");
+			return -ENODEV;
+		} else {
+			hpriv->clks[1] = clk;
+		}
+	}
+
+	mpy = ahci_da850_calculate_mpy(clk_get_rate(hpriv->clks[1]));
+	if (mpy == 0) {
+		dev_err(dev, "invalid REFCLK multiplier value: 0x%x", mpy);
+		return -EINVAL;
+	}
+
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
@@ -162,7 +223,7 @@ static int ahci_da850_probe(struct platform_device *pdev)
 	if (!pwrdn_reg)
 		goto disable_resources;
 
-	da850_sata_init(dev, pwrdn_reg, hpriv->mmio);
+	da850_sata_init(dev, pwrdn_reg, hpriv->mmio, mpy);
 
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_da850_port_info,
 				     &ahci_platform_sht);
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
