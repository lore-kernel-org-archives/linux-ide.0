From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 4/4] ARM: davinci: da850: update SATA AHCI support
Date: Tue, 25 Mar 2014 19:51:41 +0100
Message-ID: <1395773501-6663-5-git-send-email-b.zolnierkie@samsung.com>
References: <1395773501-6663-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1395773501-6663-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, spear-devel@list.st.com, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

Update SATA AHCI support to make use of the new ahci_da850 host
driver (instead of the generic ahci_platform one) and remove
deprecated ahci_platform_data code.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v4:
- no changes
v3:
- new patch

 arch/arm/mach-davinci/da850.c         |  2 +-
 arch/arm/mach-davinci/devices-da8xx.c | 99 +++--------------------------------
 2 files changed, 9 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 2ab0043..85399c9 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -472,7 +472,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK("spi_davinci.0",	NULL,		&spi0_clk),
 	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK("vpif",		NULL,		&vpif_clk),
-	CLK("ahci",		NULL,		&sata_clk),
+	CLK("ahci_da850",		NULL,		&sata_clk),
 	CLK("davinci-rproc.0",	NULL,		&dsp_clk),
 	CLK("ehrpwm",		"fck",		&ehrpwm_clk),
 	CLK("ehrpwm",		"tbclk",	&ehrpwm_tbclk),
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 0486cdf2..56ea41d 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -1020,7 +1020,6 @@ int __init da8xx_register_spi_bus(int instance, unsigned num_chipselect)
 }
 
 #ifdef CONFIG_ARCH_DAVINCI_DA850
-
 static struct resource da850_sata_resources[] = {
 	{
 		.start	= DA850_SATA_BASE,
@@ -1028,103 +1027,22 @@ static struct resource da850_sata_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
+		.start	= DA8XX_SYSCFG1_BASE + DA8XX_PWRDN_REG,
+		.end	= DA8XX_SYSCFG1_BASE + DA8XX_PWRDN_REG + 0x3,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
 		.start	= IRQ_DA850_SATAINT,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
 
-/* SATA PHY Control Register offset from AHCI base */
-#define SATA_P0PHYCR_REG	0x178
-
-#define SATA_PHY_MPY(x)		((x) << 0)
-#define SATA_PHY_LOS(x)		((x) << 6)
-#define SATA_PHY_RXCDR(x)	((x) << 10)
-#define SATA_PHY_RXEQ(x)	((x) << 13)
-#define SATA_PHY_TXSWING(x)	((x) << 19)
-#define SATA_PHY_ENPLL(x)	((x) << 31)
-
-static struct clk *da850_sata_clk;
-static unsigned long da850_sata_refclkpn;
-
-/* Supported DA850 SATA crystal frequencies */
-#define KHZ_TO_HZ(freq) ((freq) * 1000)
-static unsigned long da850_sata_xtal[] = {
-	KHZ_TO_HZ(300000),
-	KHZ_TO_HZ(250000),
-	0,			/* Reserved */
-	KHZ_TO_HZ(187500),
-	KHZ_TO_HZ(150000),
-	KHZ_TO_HZ(125000),
-	KHZ_TO_HZ(120000),
-	KHZ_TO_HZ(100000),
-	KHZ_TO_HZ(75000),
-	KHZ_TO_HZ(60000),
-};
-
-static int da850_sata_init(struct device *dev, void __iomem *addr)
-{
-	int i, ret;
-	unsigned int val;
-
-	da850_sata_clk = clk_get(dev, NULL);
-	if (IS_ERR(da850_sata_clk))
-		return PTR_ERR(da850_sata_clk);
-
-	ret = clk_prepare_enable(da850_sata_clk);
-	if (ret)
-		goto err0;
-
-	/* Enable SATA clock receiver */
-	val = __raw_readl(DA8XX_SYSCFG1_VIRT(DA8XX_PWRDN_REG));
-	val &= ~BIT(0);
-	__raw_writel(val, DA8XX_SYSCFG1_VIRT(DA8XX_PWRDN_REG));
-
-	/* Get the multiplier needed for 1.5GHz PLL output */
-	for (i = 0; i < ARRAY_SIZE(da850_sata_xtal); i++)
-		if (da850_sata_xtal[i] == da850_sata_refclkpn)
-			break;
-
-	if (i == ARRAY_SIZE(da850_sata_xtal)) {
-		ret = -EINVAL;
-		goto err1;
-	}
-
-	val = SATA_PHY_MPY(i + 1) |
-		SATA_PHY_LOS(1) |
-		SATA_PHY_RXCDR(4) |
-		SATA_PHY_RXEQ(1) |
-		SATA_PHY_TXSWING(3) |
-		SATA_PHY_ENPLL(1);
-
-	__raw_writel(val, addr + SATA_P0PHYCR_REG);
-
-	return 0;
-
-err1:
-	clk_disable_unprepare(da850_sata_clk);
-err0:
-	clk_put(da850_sata_clk);
-	return ret;
-}
-
-static void da850_sata_exit(struct device *dev)
-{
-	clk_disable_unprepare(da850_sata_clk);
-	clk_put(da850_sata_clk);
-}
-
-static struct ahci_platform_data da850_sata_pdata = {
-	.init	= da850_sata_init,
-	.exit	= da850_sata_exit,
-};
-
 static u64 da850_sata_dmamask = DMA_BIT_MASK(32);
 
 static struct platform_device da850_sata_device = {
-	.name	= "ahci",
+	.name	= "ahci_da850",
 	.id	= -1,
 	.dev	= {
-		.platform_data		= &da850_sata_pdata,
 		.dma_mask		= &da850_sata_dmamask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
@@ -1134,9 +1052,8 @@ static struct platform_device da850_sata_device = {
 
 int __init da850_register_sata(unsigned long refclkpn)
 {
-	da850_sata_refclkpn = refclkpn;
-	if (!da850_sata_refclkpn)
-		return -EINVAL;
+	/* please see comment in drivers/ata/ahci_da850.c */
+	BUG_ON(refclkpn != 100 * 1000 * 1000);
 
 	return platform_device_register(&da850_sata_device);
 }
-- 
1.8.2.3
