From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v7 06/14] ARM: davinci: da850: model the SATA refclk
Date: Mon, 30 Jan 2017 11:02:03 +0100
Message-ID: <1485770531-6772-7-git-send-email-bgolaszewski@baylibre.com>
References: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-ide@vger.kernel.org

Register a fixed rate clock modelling the external SATA oscillator
for da850 (both DT and board file mode).

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da8xx-dt.c           |  8 ++++++++
 arch/arm/mach-davinci/devices-da8xx.c      | 29 +++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |  1 +
 3 files changed, 38 insertions(+)

diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index b83e5d1..55342ca 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -50,6 +50,9 @@ static struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
 
 static void __init da850_init_machine(void)
 {
+	/* All existing boards use 100MHz SATA refclkpn */
+	static const unsigned long sata_refclkpn = 100 * 1000 * 1000;
+
 	int ret;
 
 	ret = da8xx_register_usb20_phy_clk(false);
@@ -61,6 +64,11 @@ static void __init da850_init_machine(void)
 		pr_warn("%s: registering USB 1.1 PHY clock failed: %d",
 			__func__, ret);
 
+	ret = da850_register_sata_refclk(sata_refclkpn);
+	if (ret)
+		pr_warn("%s: registering SATA REFCLK failed: %d",
+			__func__, ret);
+
 	of_platform_default_populate(NULL, da850_auxdata_lookup, NULL);
 	davinci_pm_init();
 }
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index c2457b3..cfceb32 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -24,6 +24,7 @@
 #include <mach/common.h>
 #include <mach/time.h>
 #include <mach/da8xx.h>
+#include <mach/clock.h>
 #include "cpuidle.h"
 #include "sram.h"
 
@@ -1023,6 +1024,28 @@ int __init da8xx_register_spi_bus(int instance, unsigned num_chipselect)
 }
 
 #ifdef CONFIG_ARCH_DAVINCI_DA850
+static struct clk sata_refclk = {
+	.name		= "sata_refclk",
+	.set_rate	= davinci_simple_set_rate,
+};
+
+static struct clk_lookup sata_refclk_lookup =
+		CLK("ahci_da850", "refclk", &sata_refclk);
+
+int __init da850_register_sata_refclk(int rate)
+{
+	int ret;
+
+	sata_refclk.rate = rate;
+	ret = clk_register(&sata_refclk);
+	if (ret)
+		return ret;
+
+	clkdev_add(&sata_refclk_lookup);
+
+	return 0;
+}
+
 static struct resource da850_sata_resources[] = {
 	{
 		.start	= DA850_SATA_BASE,
@@ -1055,9 +1078,15 @@ static struct platform_device da850_sata_device = {
 
 int __init da850_register_sata(unsigned long refclkpn)
 {
+	int ret;
+
 	/* please see comment in drivers/ata/ahci_da850.c */
 	BUG_ON(refclkpn != 100 * 1000 * 1000);
 
+	ret = da850_register_sata_refclk(refclkpn);
+	if (ret)
+		return ret;
+
 	return platform_device_register(&da850_sata_device);
 }
 #endif
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 85ff218..7e46422 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -95,6 +95,7 @@ int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
 int da8xx_register_usb_refclkin(int rate);
 int da8xx_register_usb20_phy_clk(bool use_usb_refclkin);
 int da8xx_register_usb11_phy_clk(bool use_usb_refclkin);
+int da850_register_sata_refclk(int rate);
 int da8xx_register_emac(void);
 int da8xx_register_uio_pruss(void);
 int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
-- 
2.9.3
