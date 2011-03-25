From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 3/4] davinci: da850: add support for SATA interface
Date: Fri, 25 Mar 2011 22:29:59 +0530
Message-ID: <1301072400-4036-3-git-send-email-nsekhar@ti.com>
References: <1301072400-4036-1-git-send-email-nsekhar@ti.com>
 <1301072400-4036-2-git-send-email-nsekhar@ti.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58444 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650Ab1CYRAU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Mar 2011 13:00:20 -0400
In-Reply-To: <1301072400-4036-2-git-send-email-nsekhar@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@mvista.com>

Add support for SATA controller on the
DA850/OMAP-L138/AM18x devices.

The patch adds the necessary clocks, platform
resources and a routine to initialize the SATA
controller.

The PHY configuration in this patch is
courtesy the work done by Zegeye Alemu,
Swaminathan and Mansoor Ahamed from TI.

While testing this patch, enable port multiplier
support iff you are actually using one. The
reasons of this behaviour are discussed
here: http://patchwork.ozlabs.org/patch/78163/

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Cc: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@mvista.com>
---
Since v1, fixed comments from Sergei Shtylyov

 arch/arm/mach-davinci/da850.c              |    9 ++
 arch/arm/mach-davinci/devices-da8xx.c      |  140 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +
 3 files changed, 151 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 68fe4c2..276199d 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -373,6 +373,14 @@ static struct clk spi1_clk = {
 	.flags		= DA850_CLK_ASYNC3,
 };
 
+static struct clk sata_clk = {
+	.name		= "sata",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA850_LPSC1_SATA,
+	.gpsc		= 1,
+	.flags		= PSC_FORCE,
+};
+
 static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"ref",		&ref_clk),
 	CLK(NULL,		"pll0",		&pll0_clk),
@@ -419,6 +427,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"usb20",	&usb20_clk),
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
+	CLK("ahci",		NULL,		&sata_clk),
 	CLK(NULL,		NULL,		NULL),
 };
 
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 625d4b6..43e8b0d 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -14,6 +14,8 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/serial_8250.h>
+#include <linux/ahci_platform.h>
+#include <linux/clk.h>
 
 #include <mach/cputype.h>
 #include <mach/common.h>
@@ -834,3 +836,141 @@ int __init da8xx_register_spi(int instance, struct spi_board_info *info,
 
 	return platform_device_register(&da8xx_spi_device[instance]);
 }
+
+#ifdef CONFIG_ARCH_DAVINCI_DA850
+
+#define DA850_SATA_BASE		0x01e18000
+static struct resource da850_sata_resources[] = {
+	{
+		.start	= DA850_SATA_BASE,
+		.end	= DA850_SATA_BASE + 0x1fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_DA850_SATAINT,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+/* SATA PHY Control Register offset from AHCI base */
+#define SATA_P0PHYCR_REG	0x178
+
+#define SATA_PHY_MPY(x)		((x) << 0)
+#define SATA_PHY_LB(x)		((x) << 4)
+#define SATA_PHY_LOS(x)		((x) << 6)
+#define SATA_PHY_RXINVPAIR(x)	((x) << 7)
+#define SATA_PHY_RXTERM(x)	((x) << 8)
+#define SATA_PHY_RXCDR(x)	((x) << 10)
+#define SATA_PHY_RXEQ(x)	((x) << 13)
+#define SATA_PHY_TXINVPAIR(x)	((x) << 17)
+#define SATA_PHY_TXCM(x)	((x) << 18)
+#define SATA_PHY_TXSWING(x)	((x) << 19)
+#define SATA_PHY_TXDE(x)	((x) << 22)
+#define SATA_PHY_OVERRIDE(x)	((x) << 30)
+#define SATA_PHY_ENPLL(x)	((x) << 31)
+
+static struct clk *da850_sata_clk;
+static unsigned long da850_sata_refclkpn;
+
+/* Supported DA850 SATA crystal frequencies */
+#define KHZ_TO_HZ(freq) ((freq) * 1000)
+static unsigned long da850_sata_xtal[] = {
+	KHZ_TO_HZ(300000),
+	KHZ_TO_HZ(250000),
+	0,			/* Reserved */
+	KHZ_TO_HZ(187500),
+	KHZ_TO_HZ(150000),
+	KHZ_TO_HZ(125000),
+	KHZ_TO_HZ(120000),
+	KHZ_TO_HZ(100000),
+	KHZ_TO_HZ(75000),
+	KHZ_TO_HZ(60000),
+};
+
+static int da850_sata_init(struct device *dev, void __iomem *addr)
+{
+	int i, ret;
+	unsigned int val;
+
+	da850_sata_clk = clk_get(dev, NULL);
+	if (IS_ERR(da850_sata_clk))
+		return PTR_ERR(da850_sata_clk);
+
+	ret = clk_enable(da850_sata_clk);
+	if (ret)
+		goto err0;
+
+	/* Enable SATA clock receiver */
+	val = __raw_readl(DA8XX_SYSCFG1_VIRT(DA8XX_PWRDN_REG));
+	val &= ~BIT(0);
+	__raw_writel(val, DA8XX_SYSCFG1_VIRT(DA8XX_PWRDN_REG));
+
+	/* Get the multiplier needed for 1.5GHz PLL output */
+	for (i = 0; i < ARRAY_SIZE(da850_sata_xtal); i++)
+		if (da850_sata_xtal[i] == da850_sata_refclkpn)
+			break;
+
+	if (i == ARRAY_SIZE(da850_sata_xtal)) {
+		ret = -EINVAL;
+		goto err1;
+	}
+
+	val = SATA_PHY_MPY(i + 1) |
+		SATA_PHY_LB(0) |
+		SATA_PHY_LOS(1) |
+		SATA_PHY_RXINVPAIR(0) |
+		SATA_PHY_RXTERM(0) |
+		SATA_PHY_RXCDR(4) |
+		SATA_PHY_RXEQ(1) |
+		SATA_PHY_TXINVPAIR(0) |
+		SATA_PHY_TXCM(0) |
+		SATA_PHY_TXSWING(3) |
+		SATA_PHY_TXDE(0) |
+		SATA_PHY_OVERRIDE(0) |
+		SATA_PHY_ENPLL(1);
+
+	__raw_writel(val, addr + SATA_P0PHYCR_REG);
+
+	return 0;
+
+err1:
+	clk_disable(da850_sata_clk);
+err0:
+	clk_put(da850_sata_clk);
+	return ret;
+}
+
+static void da850_sata_exit(struct device *dev)
+{
+	clk_disable(da850_sata_clk);
+	clk_put(da850_sata_clk);
+}
+
+static struct ahci_platform_data da850_sata_pdata = {
+	.init	= da850_sata_init,
+	.exit	= da850_sata_exit,
+};
+
+static u64 da850_sata_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device da850_sata_device = {
+	.name	= "ahci",
+	.id	= -1,
+	.dev	= {
+		.platform_data		= &da850_sata_pdata,
+		.dma_mask		= &da850_sata_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(da850_sata_resources),
+	.resource	= da850_sata_resources,
+};
+
+int __init da850_register_sata(unsigned long refclkpn)
+{
+	da850_sata_refclkpn = refclkpn;
+	if (!da850_sata_refclkpn)
+		return -EINVAL;
+
+	return platform_device_register(&da850_sata_device);
+}
+#endif
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index e4fc1af..c4350a1 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -57,6 +57,7 @@ extern unsigned int da850_max_speed;
 #define DA8XX_SYSCFG1_BASE	(IO_PHYS + 0x22C000)
 #define DA8XX_SYSCFG1_VIRT(x)	(da8xx_syscfg1_base + (x))
 #define DA8XX_DEEPSLEEP_REG	0x8
+#define DA8XX_PWRDN_REG		0x18
 
 #define DA8XX_PSC0_BASE		0x01c10000
 #define DA8XX_PLL0_BASE		0x01c11000
@@ -93,6 +94,7 @@ int da850_register_cpufreq(char *async_clk);
 int da8xx_register_cpuidle(void);
 void __iomem * __init da8xx_get_mem_ctlr(void);
 int da850_register_pm(struct platform_device *pdev);
+int __init da850_register_sata(unsigned long refclkpn);
 
 extern struct platform_device da8xx_serial_device;
 extern struct emac_platform_data da8xx_emac_pdata;
-- 
1.7.3.2

