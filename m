From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH v2 3/5] ARM: S3C64XX: Add support for Compact Flash driver on SMDK6410
Date: Tue,  8 Jun 2010 18:06:58 +0900
Message-ID: <1275988020-29000-4-git-send-email-kgene.kim@samsung.com>
References: <1275988020-29000-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1275988020-29000-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: ben-linux@fluff.org, jgarzik@pobox.com, Abhilash Kesavan <a.kesavan@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-ide@vger.kernel.org

From: Abhilash Kesavan <a.kesavan@samsung.com>

Following is added for the CF-ATA driver:
	- Platform data strucure instantiation
	- Platform device enabling code
	- Addition of cfcon clock
	- Platform-specific gpio setup code

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig                   |    7 +++
 arch/arm/mach-s3c64xx/Makefile                  |    1 +
 arch/arm/mach-s3c64xx/clock.c                   |    6 +++
 arch/arm/mach-s3c64xx/include/mach/map.h        |    4 ++
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h |    5 ++
 arch/arm/mach-s3c64xx/mach-smdk6410.c           |    8 ++++
 arch/arm/mach-s3c64xx/s3c6410.c                 |    2 +
 arch/arm/mach-s3c64xx/setup-ide.c               |   46 +++++++++++++++++++++++
 8 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/setup-ide.c

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index f5a5972..12f063b 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -57,6 +57,11 @@ config S3C64XX_SETUP_I2C1
 	help
 	  Common setup code for i2c bus 1.
 
+config S3C64XX_SETUP_IDE
+	bool
+	help
+	  Common setup code for S3C64XX IDE.
+
 config S3C64XX_SETUP_FB_24BPP
 	bool
 	help
@@ -95,6 +100,7 @@ config MACH_SMDK6410
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_I2C1
+	select SAMSUNG_DEV_IDE
 	select S3C_DEV_FB
 	select SAMSUNG_DEV_TS
 	select S3C_DEV_USB_HOST
@@ -103,6 +109,7 @@ config MACH_SMDK6410
 	select HAVE_S3C2410_WATCHDOG
 	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_I2C1
+	select S3C64XX_SETUP_IDE
 	select S3C64XX_SETUP_FB_24BPP
 	help
 	  Machine support for the Samsung SMDK6410
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 9d10069..aa5c367 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
 
 obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
 obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
+obj-$(CONFIG_S3C64XX_SETUP_IDE) += setup-ide.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI) += setup-sdhci.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index fbd85a9..7772f92 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -310,6 +310,12 @@ static struct clk init_clocks[] = {
 		.id		= -1,
 		.parent		= &clk_p,
 		.ctrlbit	= S3C_CLKCON_PCLK_AC97,
+	}, {
+		.name		= "cfcon",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s3c64xx_hclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_HCLK_IHOST,
 	}
 };
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
index e1eab3c..1caaa5f 100644
--- a/arch/arm/mach-s3c64xx/include/mach/map.h
+++ b/arch/arm/mach-s3c64xx/include/mach/map.h
@@ -86,6 +86,9 @@
 #define S3C64XX_SZ_GPIO		SZ_4K
 
 #define S3C64XX_PA_SDRAM	(0x50000000)
+
+#define S3C64XX_PA_CFCON	(0x70300000)
+
 #define S3C64XX_PA_VIC0		(0x71200000)
 #define S3C64XX_PA_VIC1		(0x71300000)
 
@@ -120,5 +123,6 @@
 #define S3C_PA_WDT		S3C64XX_PA_WATCHDOG
 
 #define SAMSUNG_PA_ADC		S3C64XX_PA_ADC
+#define SAMSUNG_PA_CFCON	S3C64XX_PA_CFCON
 
 #endif /* __ASM_ARCH_6400_MAP_H */
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
index 0114eb0..05332b9 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
+++ b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
@@ -34,6 +34,7 @@
 #define S3C_SCLK_GATE		S3C_CLKREG(0x38)
 #define S3C_MEM0_GATE		S3C_CLKREG(0x3C)
 #define S3C6410_CLK_SRC2	S3C_CLKREG(0x10C)
+#define S3C_MEM_SYS_CFG		S3C_CLKREG(0x120)
 
 /* CLKDIV0 */
 #define S3C6400_CLKDIV0_PCLK_MASK	(0xf << 12)
@@ -154,4 +155,8 @@
 #define S3C6400_CLKSRC_EPLL_MOUT_SHIFT	(2)
 #define S3C6400_CLKSRC_MFC		(1 << 4)
 
+/* MEM_SYS_CFG */
+#define MEM_SYS_CFG_INDEP_CF		0x4000
+#define MEM_SYS_CFG_EBI_FIX_PRI_CFCON	0x30
+
 #endif /* _PLAT_REGS_CLOCK_H */
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index d9a0355..0d7d93f 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -56,6 +56,7 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-sys.h>
 #include <mach/regs-srom.h>
+#include <plat/ata.h>
 #include <plat/iic.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
@@ -242,6 +243,10 @@ static struct platform_device smdk6410_b_pwr_5v = {
 };
 #endif
 
+static struct s3c_ide_platdata smdk6410_ide_pdata __initdata = {
+	.setup_gpio	= s3c64xx_ide_setup_gpio,
+};
+
 static struct map_desc smdk6410_iodesc[] = {};
 
 static struct platform_device *smdk6410_devices[] __initdata = {
@@ -265,6 +270,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 
 	&smdk6410_smsc911x,
 	&s3c_device_adc,
+	&s3c_device_cfcon,
 	&s3c_device_ts,
 	&s3c_device_wdt,
 };
@@ -665,6 +671,8 @@ static void __init smdk6410_machine_init(void)
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
+	s3c_ide_set_platdata(&smdk6410_ide_pdata);
+
 	platform_add_devices(smdk6410_devices, ARRAY_SIZE(smdk6410_devices));
 }
 
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 014401c..3ad25d2 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -37,6 +37,7 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 #include <plat/sdhci.h>
+#include <plat/ata-core.h>
 #include <plat/iic-core.h>
 #include <plat/adc.h>
 #include <plat/onenand-core.h>
@@ -58,6 +59,7 @@ void __init s3c6410_map_io(void)
 	s3c_device_nand.name = "s3c6400-nand";
 	s3c_onenand_setname("s3c6410-onenand");
 	s3c64xx_onenand1_setname("s3c6410-onenand");
+	s3c_cfcon_setname("s3c64xx-pata");
 }
 
 void __init s3c6410_init_clocks(int xtal)
diff --git a/arch/arm/mach-s3c64xx/setup-ide.c b/arch/arm/mach-s3c64xx/setup-ide.c
new file mode 100644
index 0000000..c12c315
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/setup-ide.c
@@ -0,0 +1,46 @@
+/* linux/arch/arm/mach-s3c64xx/setup-ide.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S3C64XX setup information for IDE
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+#include <plat/gpio-cfg.h>
+
+void s3c64xx_ide_setup_gpio(void)
+{
+	u32 reg;
+	u32 gpio = 0;
+
+	reg = readl(S3C_MEM_SYS_CFG) & (~0x3f);
+
+	/* Independent CF interface, CF chip select configuration */
+	writel(reg | MEM_SYS_CFG_INDEP_CF |
+		MEM_SYS_CFG_EBI_FIX_PRI_CFCON, S3C_MEM_SYS_CFG);
+
+	s3c_gpio_cfgpin(S3C64XX_GPB(4), S3C_GPIO_SFN(4));
+
+	/* Set XhiDATA[15:0] pins as CF Data[15:0] */
+	for (gpio = S3C64XX_GPK(0); gpio <= S3C64XX_GPK(15); gpio++)
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(5));
+
+	/* Set XhiADDR[2:0] pins as CF ADDR[2:0] */
+	for (gpio = S3C64XX_GPL(0); gpio <= S3C64XX_GPL(2); gpio++)
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(6));
+
+	/* Set Xhi ctrl pins as CF ctrl pins(IORDY, IOWR, IORD, CE[0:1]) */
+	s3c_gpio_cfgpin(S3C64XX_GPM(5), S3C_GPIO_SFN(1));
+	for (gpio = S3C64XX_GPM(0); gpio <= S3C64XX_GPM(4); gpio++)
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(6));
+}
-- 
1.6.2.5
