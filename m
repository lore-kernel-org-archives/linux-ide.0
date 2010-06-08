From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH v2 4/5] ARM: S5PC100: Add support for Compact Flash driver on SMDKC100
Date: Tue,  8 Jun 2010 18:06:59 +0900
Message-ID: <1275988020-29000-5-git-send-email-kgene.kim@samsung.com>
References: <1275988020-29000-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1275988020-29000-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: ben-linux@fluff.org, jgarzik@pobox.com, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-ide@vger.kernel.org

From: Abhilash Kesavan <a.kesavan@samsung.com>

Following is added for the CF-ATA driver:
	- Platform data strucure instantiation
	- Platform device enabling code
	- Platform-specific gpio setup code

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig                   |    7 ++
 arch/arm/mach-s5pc100/Makefile                  |    1 +
 arch/arm/mach-s5pc100/cpu.c                     |    2 +
 arch/arm/mach-s5pc100/include/mach/irqs.h       |    2 +-
 arch/arm/mach-s5pc100/include/mach/map.h        |    4 +
 arch/arm/mach-s5pc100/include/mach/regs-clock.h |    3 +
 arch/arm/mach-s5pc100/mach-smdkc100.c           |    7 ++
 arch/arm/mach-s5pc100/setup-ide.c               |   70 +++++++++++++++++++++++
 8 files changed, 95 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5pc100/setup-ide.c

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index b2a11df..34350ae 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -25,6 +25,11 @@ config S5PC100_SETUP_I2C1
 	help
 	  Common setup code for i2c bus 1.
 
+config S5PC100_SETUP_IDE
+	bool
+	help
+	  Common setup code for S5PC100 IDE GPIO configurations
+
 config S5PC100_SETUP_SDHCI
 	bool
 	select S5PC100_SETUP_SDHCI_GPIO
@@ -41,11 +46,13 @@ config MACH_SMDKC100
 	select CPU_S5PC100
 	select S3C_DEV_FB
 	select S3C_DEV_I2C1
+	select SAMSUNG_DEV_IDE
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S5PC100_SETUP_FB_24BPP
 	select S5PC100_SETUP_I2C1
+	select S5PC100_SETUP_IDE
 	select S5PC100_SETUP_SDHCI
 	help
 	  Machine support for the Samsung SMDKC100
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index 543f3de..ab3ebe2 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_CPU_S5PC100)	+= dma.o
 
 obj-$(CONFIG_S5PC100_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PC100_SETUP_I2C1)	+= setup-i2c1.o
+obj-$(CONFIG_S5PC100_SETUP_IDE)		+= setup-ide.o
 obj-$(CONFIG_S5PC100_SETUP_SDHCI)	+= setup-sdhci.o
 obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index 7b5bdbc..5ce66de 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -38,6 +38,7 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
+#include <plat/ata-core.h>
 #include <plat/iic-core.h>
 #include <plat/sdhci.h>
 #include <plat/onenand-core.h>
@@ -92,6 +93,7 @@ void __init s5pc100_map_io(void)
 	s3c_i2c1_setname("s3c2440-i2c");
 
 	s3c_onenand_setname("s5pc100-onenand");
+	s3c_cfcon_setname("s5pc100-pata");
 }
 
 void __init s5pc100_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/mach-s5pc100/include/mach/irqs.h
index 28aa551..bfcc0b9 100644
--- a/arch/arm/mach-s5pc100/include/mach/irqs.h
+++ b/arch/arm/mach-s5pc100/include/mach/irqs.h
@@ -38,7 +38,7 @@
 #define IRQ_IEMIEC		S5P_IRQ_VIC1(6)
 #define IRQ_ONENAND		S5P_IRQ_VIC1(7)
 #define IRQ_NFC			S5P_IRQ_VIC1(8)
-#define IRQ_CFC			S5P_IRQ_VIC1(9)
+#define IRQ_CFCON		S5P_IRQ_VIC1(9)
 #define IRQ_UART0		S5P_IRQ_VIC1(10)
 #define IRQ_UART1		S5P_IRQ_VIC1(11)
 #define IRQ_UART2		S5P_IRQ_VIC1(12)
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index cadae43..aa25190 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -61,6 +61,8 @@
 
 #define S5PC100_PA_ONENAND	(0xE7100000)
 
+#define S5PC100_PA_CFCON	(0xE7800000)
+
 /* DMA */
 #define S5PC100_PA_MDMA		(0xE8100000)
 #define S5PC100_PA_PDMA0	(0xE9000000)
@@ -135,4 +137,6 @@
 #define S3C_PA_ONENAND_BUF	S5PC100_PA_ONENAND_BUF
 #define S3C_SZ_ONENAND_BUF	S5PC100_SZ_ONENAND_BUF
 
+#define SAMSUNG_PA_CFCON	S5PC100_PA_CFCON
+
 #endif /* __ASM_ARCH_C100_MAP_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/regs-clock.h b/arch/arm/mach-s5pc100/include/mach/regs-clock.h
index 5d27d28..bc92da2 100644
--- a/arch/arm/mach-s5pc100/include/mach/regs-clock.h
+++ b/arch/arm/mach-s5pc100/include/mach/regs-clock.h
@@ -71,7 +71,10 @@
 #define S5P_CLKDIV1_PCLKD1_SHIFT	(16)
 
 #define S5PC100_SWRESET		S5PC100_REG_OTHERS(0x000)
+#define S5PC100_MEM_SYS_CFG	S5PC100_REG_OTHERS(0x200)
 
 #define S5PC100_SWRESET_RESETVAL	0xc100
 
+#define MEM_SYS_CFG_EBI_FIX_PRI_CFCON	0x30
+
 #endif /* __ASM_ARCH_REGS_CLOCK_H */
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index af22f82..b97830a 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -42,6 +42,7 @@
 #include <plat/s5pc100.h>
 #include <plat/fb.h>
 #include <plat/iic.h>
+#include <plat/ata.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PC100_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -149,7 +150,12 @@ static struct s3c_fb_platdata smdkc100_lcd_pdata __initdata = {
 	.setup_gpio	= s5pc100_fb_gpio_setup_24bpp,
 };
 
+static struct s3c_ide_platdata smdkc100_ide_pdata __initdata = {
+	.setup_gpio	= s5pc100_ide_setup_gpio,
+};
+
 static struct platform_device *smdkc100_devices[] __initdata = {
+	&s3c_device_cfcon,
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
 	&s3c_device_fb,
@@ -177,6 +183,7 @@ static void __init smdkc100_machine_init(void)
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
 	s3c_fb_set_platdata(&smdkc100_lcd_pdata);
+	s3c_ide_set_platdata(&smdkc100_ide_pdata);
 
 	/* LCD init */
 	gpio_request(S5PC100_GPD(0), "GPD");
diff --git a/arch/arm/mach-s5pc100/setup-ide.c b/arch/arm/mach-s5pc100/setup-ide.c
new file mode 100644
index 0000000..8357567
--- /dev/null
+++ b/arch/arm/mach-s5pc100/setup-ide.c
@@ -0,0 +1,70 @@
+/* linux/arch/arm/mach-s5pc100/setup-ide.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5PC100 setup information for IDE
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
+#include <mach/regs-clock.h>
+#include <plat/gpio-cfg.h>
+
+void s5pc100_ide_setup_gpio(void)
+{
+	u32 reg;
+	u32 gpio = 0;
+
+	/* Independent CF interface, CF chip select configuration */
+	reg = readl(S5PC100_MEM_SYS_CFG) & (~0x3f);
+	writel(reg | MEM_SYS_CFG_EBI_FIX_PRI_CFCON, S5PC100_MEM_SYS_CFG);
+
+	/* CF_Add[0 - 2], CF_IORDY, CF_INTRQ, CF_DMARQ, CF_DMARST, CF_DMACK */
+	for (gpio = S5PC100_GPJ0(0); gpio <= S5PC100_GPJ0(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	/*CF_Data[0 - 7] */
+	for (gpio = S5PC100_GPJ2(0); gpio <= S5PC100_GPJ2(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	/* CF_Data[8 - 15] */
+	for (gpio = S5PC100_GPJ3(0); gpio <= S5PC100_GPJ3(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	/* CF_CS0, CF_CS1, CF_IORD, CF_IOWR */
+	for (gpio = S5PC100_GPJ4(0); gpio <= S5PC100_GPJ4(3); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	/* EBI_OE, EBI_WE */
+	for (gpio = S5PC100_GPK0(6); gpio <= S5PC100_GPK0(7); gpio++)
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0));
+
+	/* CF_OE, CF_WE */
+	for (gpio = S5PC100_GPK1(6); gpio <= S5PC100_GPK1(7); gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	/* CF_CD */
+	s3c_gpio_cfgpin(S5PC100_GPK3(5), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC100_GPK3(5), S3C_GPIO_PULL_NONE);
+}
-- 
1.6.2.5
