From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH v2 2/5] ARM: SAMSUNG: Add Compact Flash device support for Samsung SoCs
Date: Tue,  8 Jun 2010 18:06:57 +0900
Message-ID: <1275988020-29000-3-git-send-email-kgene.kim@samsung.com>
References: <1275988020-29000-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1275988020-29000-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: ben-linux@fluff.org, jgarzik@pobox.com, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-ide@vger.kernel.org

From: Abhilash Kesavan <a.kesavan@samsung.com>

Following has been added:
	- Common CF Platform device definition
	- Platform data strucure definition
	- CF controller register definitions

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/Kconfig                 |    5 ++
 arch/arm/plat-samsung/Makefile                |    1 +
 arch/arm/plat-samsung/dev-ide.c               |   44 +++++++++++++++++++
 arch/arm/plat-samsung/include/plat/ata-core.h |   28 ++++++++++++
 arch/arm/plat-samsung/include/plat/ata.h      |   36 ++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h     |    1 +
 arch/arm/plat-samsung/include/plat/regs-ata.h |   56 +++++++++++++++++++++++++
 7 files changed, 171 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dev-ide.c
 create mode 100644 arch/arm/plat-samsung/include/plat/ata-core.h
 create mode 100644 arch/arm/plat-samsung/include/plat/ata.h
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-ata.h

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 2753fb3..12c647c 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -216,6 +216,11 @@ config SAMSUNG_DEV_ADC
 	help
 	  Compile in platform device definition for ADC controller
 
+config SAMSUNG_DEV_IDE
+	bool
+	help
+	  Compile in platform device definitions for IDE
+
 config S3C64XX_DEV_SPI
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 228c2ad..e7a9755 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_S3C_DEV_ONENAND)	+= dev-onenand.o
 obj-$(CONFIG_S3C_DEV_RTC)	+= dev-rtc.o
 
 obj-$(CONFIG_SAMSUNG_DEV_ADC)	+= dev-adc.o
+obj-$(CONFIG_SAMSUNG_DEV_IDE)	+= dev-ide.o
 obj-$(CONFIG_SAMSUNG_DEV_TS)	+= dev-ts.o
 
 # DMA support
diff --git a/arch/arm/plat-samsung/dev-ide.c b/arch/arm/plat-samsung/dev-ide.c
new file mode 100644
index 0000000..b497982
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-ide.c
@@ -0,0 +1,44 @@
+/* linux/arch/arm/plat-samsung/dev-ide.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung CF-ATA device definition.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#include <mach/map.h>
+#include <plat/ata.h>
+#include <plat/devs.h>
+
+static struct resource s3c_cfcon_resource[] = {
+	[0] = {
+		.start	= SAMSUNG_PA_CFCON,
+		.end	= SAMSUNG_PA_CFCON + SZ_16K - 1,
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
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s3c_cfcon_resource),
+	.resource	= s3c_cfcon_resource,
+};
+
+void s3c_ide_set_platdata(struct s3c_ide_platdata *pdata)
+{
+	s3c_set_platdata(pdata, sizeof(struct s3c_ide_platdata),
+			 &s3c_device_cfcon);
+}
diff --git a/arch/arm/plat-samsung/include/plat/ata-core.h b/arch/arm/plat-samsung/include/plat/ata-core.h
new file mode 100644
index 0000000..f5a4ec7
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/ata-core.h
@@ -0,0 +1,28 @@
+/* linux/arch/arm/plat-samsung/include/plat/ata-core.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung CF-ATA Controller core functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_ATA_CORE_H
+#define __ASM_PLAT_ATA_CORE_H __FILE__
+
+/* These functions are only for use with the core support code, such as
+ * the cpu specific initialisation code
+*/
+
+/* re-define device name depending on support. */
+static inline void s3c_cfcon_setname(char *name)
+{
+#ifdef CONFIG_SAMSUNG_DEV_IDE
+	s3c_device_cfcon.name = name;
+#endif
+}
+
+#endif /* __ASM_PLAT_ATA_CORE_H */
diff --git a/arch/arm/plat-samsung/include/plat/ata.h b/arch/arm/plat-samsung/include/plat/ata.h
new file mode 100644
index 0000000..2a3855a
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/ata.h
@@ -0,0 +1,36 @@
+/* linux/arch/arm/plat-samsung/include/plat/ata.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung CF-ATA platform_device info
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
+ */
+struct s3c_ide_platdata {
+	void (*setup_gpio)(void);
+};
+
+/*
+ * s3c_ide_set_platdata() - Setup the platform specifc data for IDE driver.
+ * @pdata: Platform data for IDE driver.
+ */
+extern void s3c_ide_set_platdata(struct s3c_ide_platdata *pdata);
+
+/* architecture-specific IDE configuration */
+extern void s3c64xx_ide_setup_gpio(void);
+extern void s5pc100_ide_setup_gpio(void);
+extern void s5pv210_ide_setup_gpio(void);
+
+#endif /*__ASM_PLAT_ATA_H */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 6760999..4a66130 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -54,6 +54,7 @@ extern struct platform_device s3c_device_hwmon;
 extern struct platform_device s3c_device_hsmmc0;
 extern struct platform_device s3c_device_hsmmc1;
 extern struct platform_device s3c_device_hsmmc2;
+extern struct platform_device s3c_device_cfcon;
 
 extern struct platform_device s3c_device_spi0;
 extern struct platform_device s3c_device_spi1;
diff --git a/arch/arm/plat-samsung/include/plat/regs-ata.h b/arch/arm/plat-samsung/include/plat/regs-ata.h
new file mode 100644
index 0000000..f5df92f
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/regs-ata.h
@@ -0,0 +1,56 @@
+/* linux/arch/arm/plat-samsung/include/plat/regs-ata.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung CF-ATA register definitions
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
