From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH v2 5/5] ARM: S5PV210: Add support for Compact Flash driver on SMDKV210/C110
Date: Tue,  8 Jun 2010 18:07:00 +0900
Message-ID: <1275988020-29000-6-git-send-email-kgene.kim@samsung.com>
References: <1275988020-29000-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:55939 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223Ab0FHJNA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jun 2010 05:13:00 -0400
In-Reply-To: <1275988020-29000-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: ben-linux@fluff.org, jgarzik@pobox.com, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

From: Abhilash Kesavan <a.kesavan@samsung.com>

Following is added for the CF-ATA driver:
	- Platform data strucure instantiation
	- Platform device enabling code
	- Platform-specific gpio setup code
	- Fixed IRQ naming to match across 64xx and v210

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig             |    9 +++++
 arch/arm/mach-s5pv210/Makefile            |    1 +
 arch/arm/mach-s5pv210/cpu.c               |    4 ++-
 arch/arm/mach-s5pv210/include/mach/irqs.h |    2 +-
 arch/arm/mach-s5pv210/include/mach/map.h  |    3 ++
 arch/arm/mach-s5pv210/mach-smdkc110.c     |    8 +++++
 arch/arm/mach-s5pv210/mach-smdkv210.c     |    8 +++++
 arch/arm/mach-s5pv210/setup-ide.c         |   50 +++++++++++++++++++++++++++++
 8 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-ide.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 0761eac..4068c91 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -27,6 +27,11 @@ config S5PV210_SETUP_I2C2
 	help
 	  Common setup code for i2c bus 2.
 
+config S5PV210_SETUP_IDE
+	bool
+	help
+	  Common setup code for S5PV210 IDE GPIO configurations
+
 config S5PV210_SETUP_FB_24BPP
 	bool
 	help
@@ -72,9 +77,11 @@ config MACH_SMDKV210
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
 	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_IDE
 	select SAMSUNG_DEV_TS
 	select S3C_DEV_WDT
 	select HAVE_S3C2410_WATCHDOG
+	select S5PV210_SETUP_IDE
 	help
 	  Machine support for Samsung SMDKV210
 
@@ -82,8 +89,10 @@ config MACH_SMDKC110
 	bool "SMDKC110"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select SAMSUNG_DEV_IDE
 	select S3C_DEV_WDT
 	select HAVE_S3C2410_WATCHDOG
+	select S5PV210_SETUP_IDE
 	help
 	  Machine support for Samsung SMDKC110
 	  S5PC110(MCP) is one of package option of S5PV210
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 30be9a6..af55785 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -31,5 +31,6 @@ obj-$(CONFIG_S5PC110_DEV_ONENAND) += dev-onenand.o
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
 obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
+obj-$(CONFIG_S5PV210_SETUP_IDE)		+= setup-ide.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 411a4a9..8c4fdcd 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -32,6 +32,7 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 #include <plat/s5pv210.h>
+#include <plat/ata-core.h>
 #include <plat/iic-core.h>
 #include <plat/sdhci.h>
 
@@ -79,7 +80,6 @@ void __init s5pv210_map_io(void)
 #ifdef CONFIG_S3C_DEV_ADC
 	s3c_device_adc.name	= "s3c64xx-adc";
 #endif
-
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
 
 	/* initialise device information early */
@@ -87,6 +87,8 @@ void __init s5pv210_map_io(void)
 	s5pv210_default_sdhci1();
 	s5pv210_default_sdhci2();
 
+	s3c_cfcon_setname("s5pv210-pata");
+
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-s5pv210/include/mach/irqs.h
index 9689537..e1d3c45 100644
--- a/arch/arm/mach-s5pv210/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
@@ -45,7 +45,7 @@
 #define IRQ_IEMIEC		S5P_IRQ_VIC1(6)
 #define IRQ_ONENAND		S5P_IRQ_VIC1(7)
 #define IRQ_NFC			S5P_IRQ_VIC1(8)
-#define IRQ_CFC			S5P_IRQ_VIC1(9)
+#define IRQ_CFCON		S5P_IRQ_VIC1(9)
 #define IRQ_UART0		S5P_IRQ_VIC1(10)
 #define IRQ_UART1		S5P_IRQ_VIC1(11)
 #define IRQ_UART2		S5P_IRQ_VIC1(12)
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 34eb168..3846a0b 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -54,6 +54,8 @@
 
 #define S5PV210_PA_SROMC	(0xE8000000)
 
+#define S5PV210_PA_CFCON	(0xE8200000)
+
 #define S5PV210_PA_MDMA		0xFA200000
 #define S5PV210_PA_PDMA0	0xE0900000
 #define S5PV210_PA_PDMA1	0xE0A00000
@@ -104,5 +106,6 @@
 #define S3C_PA_WDT		S5PV210_PA_WATCHDOG
 
 #define SAMSUNG_PA_ADC		S5PV210_PA_ADC
+#define SAMSUNG_PA_CFCON	S5PV210_PA_CFCON
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 4c8903c..723e607 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -25,6 +25,7 @@
 #include <plat/s5pv210.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/ata.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -71,9 +72,14 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 	},
 };
 
+static struct s3c_ide_platdata smdkv210_ide_pdata __initdata = {
+	.setup_gpio	= s5pv210_ide_setup_gpio,
+};
+
 static struct platform_device *smdkc110_devices[] __initdata = {
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
+	&s3c_device_cfcon,
 	&s3c_device_wdt,
 };
 
@@ -86,6 +92,8 @@ static void __init smdkc110_map_io(void)
 
 static void __init smdkc110_machine_init(void)
 {
+	s3c_ide_set_platdata(&smdkv210_ide_pdata);
+
 	platform_add_devices(smdkc110_devices, ARRAY_SIZE(smdkc110_devices));
 }
 
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 0d46279..cc902c1 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -27,6 +27,7 @@
 #include <plat/cpu.h>
 #include <plat/adc.h>
 #include <plat/ts.h>
+#include <plat/ata.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -73,10 +74,15 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 	},
 };
 
+static struct s3c_ide_platdata smdkv210_ide_pdata __initdata = {
+	.setup_gpio	= s5pv210_ide_setup_gpio,
+};
+
 static struct platform_device *smdkv210_devices[] __initdata = {
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
 	&s3c_device_adc,
+	&s3c_device_cfcon,
 	&s3c_device_ts,
 	&s3c_device_wdt,
 };
@@ -97,6 +103,8 @@ static void __init smdkv210_map_io(void)
 static void __init smdkv210_machine_init(void)
 {
 	s3c24xx_ts_set_platdata(&s3c_ts_platform);
+	s3c_ide_set_platdata(&smdkv210_ide_pdata);
+
 	platform_add_devices(smdkv210_devices, ARRAY_SIZE(smdkv210_devices));
 }
 
diff --git a/arch/arm/mach-s5pv210/setup-ide.c b/arch/arm/mach-s5pv210/setup-ide.c
new file mode 100644
index 0000000..b558b1c
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-ide.c
@@ -0,0 +1,50 @@
+/* linux/arch/arm/mach-s5pv210/setup-ide.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5PV210 setup information for IDE
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/gpio.h>
+
+#include <plat/gpio-cfg.h>
+
+void s5pv210_ide_setup_gpio(void)
+{
+	unsigned int gpio = 0;
+
+	for (gpio = S5PV210_GPJ0(0); gpio <= S5PV210_GPJ0(7); gpio++) {
+		/* CF_Add[0 - 2], CF_IORDY, CF_INTRQ, CF_DMARQ, CF_DMARST,
+			CF_DMACK */
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	for (gpio = S5PV210_GPJ2(0); gpio <= S5PV210_GPJ2(7); gpio++) {
+		/*CF_Data[0 - 7] */
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	for (gpio = S5PV210_GPJ3(0); gpio <= S5PV210_GPJ3(7); gpio++) {
+		/* CF_Data[8 - 15] */
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+
+	for (gpio = S5PV210_GPJ4(0); gpio <= S5PV210_GPJ4(3); gpio++) {
+		/* CF_CS0, CF_CS1, CF_IORD, CF_IOWR */
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(4));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
+	}
+}
-- 
1.6.2.5

