From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH 1/4] ARM: S3C64XX: Add support for Compact Flash driver on SMDK6410
Date: Thu, 27 May 2010 17:22:01 +0900
Message-ID: <1274948524-2970-2-git-send-email-kgene.kim@samsung.com>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:48713 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757581Ab0E0IZP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 May 2010 04:25:15 -0400
In-Reply-To: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: ben-linux@fluff.org, Abhilash Kesavan <a.kesavan@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

From: Abhilash Kesavan <a.kesavan@samsung.com>

Following is added for the CF-ATA driver:
	- Platform data strucure definition and instantiation
	- Platform device definition and enabling code
	- Platform-specific gpio setup code
	- CF controller register definitions

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig                   |    7 +++
 arch/arm/mach-s3c64xx/Makefile                  |    1 +
 arch/arm/mach-s3c64xx/clock.c                   |    6 +++
 arch/arm/mach-s3c64xx/include/mach/map.h        |    5 ++-
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h |    5 ++
 arch/arm/mach-s3c64xx/mach-smdk6410.c           |    9 ++++
 arch/arm/mach-s3c64xx/s3c6410.c                 |    1 +
 arch/arm/mach-s3c64xx/setup-ide.c               |   55 ++++++++++++++++++++++
 arch/arm/plat-samsung/Kconfig                   |    5 ++
 arch/arm/plat-samsung/Makefile                  |    1 +
 arch/arm/plat-samsung/dev-ide.c                 |   52 +++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/ata.h        |   38 +++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h       |    1 +
 arch/arm/plat-samsung/include/plat/regs-ata.h   |   56 +++++++++++++++++++++++
 14 files changed, 241 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/setup-ide.c
 create mode 100644 arch/arm/plat-samsung/dev-ide.c
 create mode 100644 arch/arm/plat-samsung/include/plat/ata.h
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-ata.h

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index f5a5972..c00401e 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -67,6 +67,11 @@ config S3C64XX_SETUP_SDHCI_GPIO
 	help
 	  Common setup code for S3C64XX SDHCI GPIO configurations
 
+config S3C64XX_SETUP_IDE
+	bool
+	help
+	  Common setup code for S3C64XX IDE.
+
 # S36400 Macchine support
 
 config MACH_SMDK6400
@@ -101,9 +106,11 @@ config MACH_SMDK6410
 	select S3C_DEV_USB_HSOTG
 	select S3C_DEV_WDT
 	select HAVE_S3C2410_WATCHDOG
+	select S3C_DEV_IDE
 	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_I2C1
 	select S3C64XX_SETUP_FB_24BPP
+	select S3C64XX_SETUP_IDE
 	help
 	  Machine support for the Samsung SMDK6410
 
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 9d10069..0d52c35 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI) += setup-sdhci.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
+obj-$(CONFIG_S3C64XX_SETUP_IDE) += setup-ide.o
 
 # PM
 
diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 7a4138b..9dac5c4 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -304,6 +304,12 @@ static struct clk init_clocks[] = {
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
index e1eab3c..4b1ac79 100644
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
 
@@ -118,7 +121,7 @@
 #define S3C_VA_USB_HSPHY	S3C64XX_VA_USB_HSPHY
 #define S3C_PA_RTC		S3C64XX_PA_RTC
 #define S3C_PA_WDT		S3C64XX_PA_WATCHDOG
-
+#define SAMSUNG_PA_CFCON	S3C64XX_PA_CFCON
 #define SAMSUNG_PA_ADC		S3C64XX_PA_ADC
 
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
index d9a0355..cc1bb0f 100644
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
@@ -242,6 +243,11 @@ static struct platform_device smdk6410_b_pwr_5v = {
 };
 #endif
 
+static struct s3c_ide_platdata smdk6410_ide_pdata __initdata = {
+	.setup_gpio	= s3c_ide_setup_gpio,
+	.cfg_mode	= s3c_ide_cfg_mode,
+};
+
 static struct map_desc smdk6410_iodesc[] = {};
 
 static struct platform_device *smdk6410_devices[] __initdata = {
@@ -267,6 +273,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_ts,
 	&s3c_device_wdt,
+	&s3c_device_cfcon,
 };
 
 #ifdef CONFIG_REGULATOR
@@ -665,6 +672,8 @@ static void __init smdk6410_machine_init(void)
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
+	s3c_ide_set_platdata(&smdk6410_ide_pdata);
+
 	platform_add_devices(smdk6410_devices, ARRAY_SIZE(smdk6410_devices));
 }
 
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 014401c..1d1dce4 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -58,6 +58,7 @@ void __init s3c6410_map_io(void)
 	s3c_device_nand.name = "s3c6400-nand";
 	s3c_onenand_setname("s3c6410-onenand");
 	s3c64xx_onenand1_setname("s3c6410-onenand");
+	s3c_device_cfcon.name = "s3c6400-pata";
 }
 
 void __init s3c6410_init_clocks(int xtal)
diff --git a/arch/arm/mach-s3c64xx/setup-ide.c b/arch/arm/mach-s3c64xx/setup-ide.c
new file mode 100644
index 0000000..0bf4e5e
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/setup-ide.c
@@ -0,0 +1,55 @@
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
+#include <linux/types.h>
+#include <linux/io.h>
+
+#include <mach/map.h>
+#include <mach/gpio.h>
+#include <mach/regs-clock.h>
+#include <plat/gpio-cfg.h>
+#include <plat/regs-ata.h>
+
+void s3c_ide_setup_gpio(void)
+{
+	u32 reg;
+	u32 gpio = 0;
+
+	reg = __raw_readl(S3C_MEM_SYS_CFG) & (~0x3f);
+
+	/* Independent CF interface, CF chip select configuration */
+	__raw_writel(reg | MEM_SYS_CFG_INDEP_CF |
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
+
+void s3c_ide_cfg_mode(void __iomem *sfrbase)
+{
+	/* Select true-ide as the internal operating mode*/
+	writel(readl(sfrbase + S3C_CFATA_MUX) | S3C_CFATA_MUX_TRUEIDE,
+						sfrbase + S3C_CFATA_MUX);
+}
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 2753fb3..6ec97fe 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -175,6 +175,11 @@ config S3C_DEV_I2C2
 	help
 	  Compile in platform device definitions for I2C channel 2
 
+config S3C_DEV_IDE
+	bool
+	help
+	  Compile in platform device definitions for IDE
+
 config S3C_DEV_FB
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index b1d82cc..252fc76 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_S3C_DEV_RTC)	+= dev-rtc.o
 
 obj-$(CONFIG_SAMSUNG_DEV_ADC)	+= dev-adc.o
 obj-$(CONFIG_SAMSUNG_DEV_TS)	+= dev-ts.o
+obj-$(CONFIG_S3C_DEV_IDE)	+= dev-ide.o
 
 # DMA support
 
diff --git a/arch/arm/plat-samsung/dev-ide.c b/arch/arm/plat-samsung/dev-ide.c
new file mode 100644
index 0000000..c6b3292
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-ide.c
@@ -0,0 +1,52 @@
+/* linux/arch/arm/plat-samsung/dev-ide.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S3C CF-ATA device definition.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <mach/map.h>
+#include <plat/ata.h>
+
+static struct resource s3c_cfcon_resource[] = {
+	[0] = {
+		.start	= SAMSUNG_PA_CFCON,
+		.end	= SAMSUNG_PA_CFCON + SZ_1M - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_CFCON,
+		.end	= IRQ_CFCON,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_cfcon = {
+	.name		= "s3c-pata",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s3c_cfcon_resource),
+	.resource	= s3c_cfcon_resource,
+};
+
+void s3c_ide_set_platdata(struct s3c_ide_platdata *pdata)
+{
+	struct s3c_ide_platdata *pd;
+
+	pd = (struct s3c_ide_platdata *)kmemdup(pdata,
+		sizeof(struct s3c_ide_platdata), GFP_KERNEL);
+	if (!pd) {
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+		return;
+	}
+	s3c_device_cfcon.dev.platform_data = pd;
+}
diff --git a/arch/arm/plat-samsung/include/plat/ata.h b/arch/arm/plat-samsung/include/plat/ata.h
new file mode 100644
index 0000000..aea11dc
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/ata.h
@@ -0,0 +1,38 @@
+/* arch/arm/plat-samsung/include/plat/ata.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S3C - CF Controller platform_device info
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_ATA_H
+#define __ASM_PLAT_ATA_H __FILE__
+
+/**
+ * struct s3c_ide_platdata - S3C IDE driver platform data.
+ * @setup_gpio: Setup the external GPIO pins to the right state for data
+ * transfer in true-ide mode.
+ * @cfg_mode: Platform specific setup for configuring the CF controller
+ * in true-ide mode.
+ */
+struct s3c_ide_platdata {
+	void (*setup_gpio)(void);
+	void (*cfg_mode)(void __iomem *sfrbase);
+};
+
+/*
+ * s3c_ide_set_platdata() - Setup the platform specifc data for IDE driver.
+ * @pdata: Platform data for IDE driver.
+ */
+extern void s3c_ide_set_platdata(struct s3c_ide_platdata *pdata);
+
+/* architecture-specific IDE configuration */
+extern void s3c_ide_setup_gpio(void);
+extern void s3c_ide_cfg_mode(void __iomem *sfrbase);
+
+#endif /*__ASM_PLAT_ATA_H */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index e6144e4..e3fcddb 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -75,6 +75,7 @@ extern struct platform_device s5pc110_device_onenand;
 
 extern struct platform_device s3c_device_usbgadget;
 extern struct platform_device s3c_device_usb_hsotg;
+extern struct platform_device s3c_device_cfcon;
 
 extern struct platform_device s5pv210_device_ac97;
 extern struct platform_device s5pv210_device_pcm0;
diff --git a/arch/arm/plat-samsung/include/plat/regs-ata.h b/arch/arm/plat-samsung/include/plat/regs-ata.h
new file mode 100644
index 0000000..f73b267
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/regs-ata.h
@@ -0,0 +1,56 @@
+/* arch/arm/plat-samsung/include/plat/regs-ata.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S3C CF-ATA register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_REGS_ATA_H
+#define __ASM_PLAT_REGS_ATA_H __FILE__
+
+#define S3C_CFATA_REG(x)	(x)
+
+#define S3C_CFATA_MUX		S3C_CFATA_REG(0x0)
+
+#define S3C_ATA_CTRL		S3C_CFATA_REG(0x0)
+#define S3C_ATA_STATUS		S3C_CFATA_REG(0x4)
+#define S3C_ATA_CMD		S3C_CFATA_REG(0x8)
+#define S3C_ATA_SWRST		S3C_CFATA_REG(0xc)
+#define S3C_ATA_IRQ		S3C_CFATA_REG(0x10)
+#define S3C_ATA_IRQ_MSK		S3C_CFATA_REG(0x14)
+#define S3C_ATA_CFG		S3C_CFATA_REG(0x18)
+
+#define S3C_ATA_MDMA_TIME	S3C_CFATA_REG(0x28)
+#define S3C_ATA_PIO_TIME	S3C_CFATA_REG(0x2c)
+#define S3C_ATA_UDMA_TIME	S3C_CFATA_REG(0x30)
+#define S3C_ATA_XFR_NUM		S3C_CFATA_REG(0x34)
+#define S3C_ATA_XFR_CNT		S3C_CFATA_REG(0x38)
+#define S3C_ATA_TBUF_START	S3C_CFATA_REG(0x3c)
+#define S3C_ATA_TBUF_SIZE	S3C_CFATA_REG(0x40)
+#define S3C_ATA_SBUF_START	S3C_CFATA_REG(0x44)
+#define S3C_ATA_SBUF_SIZE	S3C_CFATA_REG(0x48)
+#define S3C_ATA_CADR_TBUF	S3C_CFATA_REG(0x4c)
+#define S3C_ATA_CADR_SBUF	S3C_CFATA_REG(0x50)
+#define S3C_ATA_PIO_DTR		S3C_CFATA_REG(0x54)
+#define S3C_ATA_PIO_FED		S3C_CFATA_REG(0x58)
+#define S3C_ATA_PIO_SCR		S3C_CFATA_REG(0x5c)
+#define S3C_ATA_PIO_LLR		S3C_CFATA_REG(0x60)
+#define S3C_ATA_PIO_LMR		S3C_CFATA_REG(0x64)
+#define S3C_ATA_PIO_LHR		S3C_CFATA_REG(0x68)
+#define S3C_ATA_PIO_DVR		S3C_CFATA_REG(0x6c)
+#define S3C_ATA_PIO_CSD		S3C_CFATA_REG(0x70)
+#define S3C_ATA_PIO_DAD		S3C_CFATA_REG(0x74)
+#define S3C_ATA_PIO_READY	S3C_CFATA_REG(0x78)
+#define S3C_ATA_PIO_RDATA	S3C_CFATA_REG(0x7c)
+
+#define S3C_CFATA_MUX_TRUEIDE	0x01
+
+#define S3C_ATA_CFG_SWAP	0x40
+#define S3C_ATA_CFG_IORDYEN	0x02
+
+#endif /* __ASM_PLAT_REGS_ATA_H */
-- 
1.6.2.5

