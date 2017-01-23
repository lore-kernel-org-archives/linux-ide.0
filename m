From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v6 11/14] sata: ahci-da850: un-hardcode the MPY bits
Date: Mon, 23 Jan 2017 18:00:53 +0100
Message-ID: <1485190856-4711-12-git-send-email-bgolaszewski@baylibre.com>
References: <1485190856-4711-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1485190856-4711-1-git-send-email-bgolaszewski@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

All platforms using this driver now register the SATA refclk. Remove
the hardcoded default value from the driver and instead read the rate
of the external clock and calculate the required MPY value from it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/ahci_da850.c | 91 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index 0b2b1a4..9ed404d 100644
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
