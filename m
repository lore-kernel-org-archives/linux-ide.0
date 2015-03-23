From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 2/9] ARM: at91: drop sam9_smc.c
Date: Mon, 23 Mar 2015 20:29:08 +0100
Message-ID: <1427138955-3617-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-pcmcia>,
 <mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia/>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
 <mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: "linux-pcmcia" <linux-pcmcia-bounces@lists.infradead.org>
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Tejun Heo <tj@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

sam9_smc.c has no users anymore, remove it along with both sam9_smc.h and
mach/at91sam9_smc.h

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Makefile                    |   2 -
 arch/arm/mach-at91/include/mach/at91sam9_smc.h |  98 ------------------
 arch/arm/mach-at91/sam9_smc.c                  | 136 -------------------------
 arch/arm/mach-at91/sam9_smc.h                  |  11 --
 4 files changed, 247 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9_smc.h
 delete mode 100644 arch/arm/mach-at91/sam9_smc.c
 delete mode 100644 arch/arm/mach-at91/sam9_smc.h

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 06a4cefd33a0..3586d977e99d 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -6,8 +6,6 @@ asflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
 obj-y		:= soc.o
 
-obj-$(CONFIG_SOC_AT91SAM9)	+= sam9_smc.o
-
 # CPU-specific support
 obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
diff --git a/arch/arm/mach-at91/include/mach/at91sam9_smc.h b/arch/arm/mach-at91/include/mach/at91sam9_smc.h
deleted file mode 100644
index ff54a0ce90e3..000000000000
--- a/arch/arm/mach-at91/include/mach/at91sam9_smc.h
+++ /dev/null
@@ -1,98 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/at91sam9_smc.h
- *
- * Copyright (C) 2007 Andrew Victor
- * Copyright (C) 2007 Atmel Corporation.
- *
- * Static Memory Controllers (SMC) - System peripherals registers.
- * Based on AT91SAM9261 datasheet revision D.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef AT91SAM9_SMC_H
-#define AT91SAM9_SMC_H
-
-#ifndef __ASSEMBLY__
-struct sam9_smc_config {
-	/* Setup register */
-	u8 ncs_read_setup;
-	u8 nrd_setup;
-	u8 ncs_write_setup;
-	u8 nwe_setup;
-
-	/* Pulse register */
-	u8 ncs_read_pulse;
-	u8 nrd_pulse;
-	u8 ncs_write_pulse;
-	u8 nwe_pulse;
-
-	/* Cycle register */
-	u16 read_cycle;
-	u16 write_cycle;
-
-	/* Mode register */
-	u32 mode;
-	u8 tdf_cycles:4;
-};
-
-extern void sam9_smc_configure(int id, int cs, struct sam9_smc_config *config);
-extern void sam9_smc_read(int id, int cs, struct sam9_smc_config *config);
-extern void sam9_smc_read_mode(int id, int cs, struct sam9_smc_config *config);
-extern void sam9_smc_write_mode(int id, int cs, struct sam9_smc_config *config);
-#endif
-
-#define AT91_SMC_SETUP		0x00				/* Setup Register for CS n */
-#define		AT91_SMC_NWESETUP	(0x3f << 0)			/* NWE Setup Length */
-#define			AT91_SMC_NWESETUP_(x)	((x) << 0)
-#define		AT91_SMC_NCS_WRSETUP	(0x3f << 8)			/* NCS Setup Length in Write Access */
-#define			AT91_SMC_NCS_WRSETUP_(x)	((x) << 8)
-#define		AT91_SMC_NRDSETUP	(0x3f << 16)			/* NRD Setup Length */
-#define			AT91_SMC_NRDSETUP_(x)	((x) << 16)
-#define		AT91_SMC_NCS_RDSETUP	(0x3f << 24)			/* NCS Setup Length in Read Access */
-#define			AT91_SMC_NCS_RDSETUP_(x)	((x) << 24)
-
-#define AT91_SMC_PULSE		0x04				/* Pulse Register for CS n */
-#define		AT91_SMC_NWEPULSE	(0x7f <<  0)			/* NWE Pulse Length */
-#define			AT91_SMC_NWEPULSE_(x)	((x) << 0)
-#define		AT91_SMC_NCS_WRPULSE	(0x7f <<  8)			/* NCS Pulse Length in Write Access */
-#define			AT91_SMC_NCS_WRPULSE_(x)((x) << 8)
-#define		AT91_SMC_NRDPULSE	(0x7f << 16)			/* NRD Pulse Length */
-#define			AT91_SMC_NRDPULSE_(x)	((x) << 16)
-#define		AT91_SMC_NCS_RDPULSE	(0x7f << 24)			/* NCS Pulse Length in Read Access */
-#define			AT91_SMC_NCS_RDPULSE_(x)((x) << 24)
-
-#define AT91_SMC_CYCLE		0x08				/* Cycle Register for CS n */
-#define		AT91_SMC_NWECYCLE	(0x1ff << 0 )			/* Total Write Cycle Length */
-#define			AT91_SMC_NWECYCLE_(x)	((x) << 0)
-#define		AT91_SMC_NRDCYCLE	(0x1ff << 16)			/* Total Read Cycle Length */
-#define			AT91_SMC_NRDCYCLE_(x)	((x) << 16)
-
-#define AT91_SMC_MODE		0x0c				/* Mode Register for CS n */
-#define		AT91_SMC_READMODE	(1 <<  0)			/* Read Mode */
-#define		AT91_SMC_WRITEMODE	(1 <<  1)			/* Write Mode */
-#define		AT91_SMC_EXNWMODE	(3 <<  4)			/* NWAIT Mode */
-#define			AT91_SMC_EXNWMODE_DISABLE	(0 << 4)
-#define			AT91_SMC_EXNWMODE_FROZEN	(2 << 4)
-#define			AT91_SMC_EXNWMODE_READY		(3 << 4)
-#define		AT91_SMC_BAT		(1 <<  8)			/* Byte Access Type */
-#define			AT91_SMC_BAT_SELECT		(0 << 8)
-#define			AT91_SMC_BAT_WRITE		(1 << 8)
-#define		AT91_SMC_DBW		(3 << 12)			/* Data Bus Width */
-#define			AT91_SMC_DBW_8			(0 << 12)
-#define			AT91_SMC_DBW_16			(1 << 12)
-#define			AT91_SMC_DBW_32			(2 << 12)
-#define		AT91_SMC_TDF		(0xf << 16)			/* Data Float Time. */
-#define			AT91_SMC_TDF_(x)		((x) << 16)
-#define		AT91_SMC_TDFMODE	(1 << 20)			/* TDF Optimization - Enabled */
-#define		AT91_SMC_PMEN		(1 << 24)			/* Page Mode Enabled */
-#define		AT91_SMC_PS		(3 << 28)			/* Page Size */
-#define			AT91_SMC_PS_4			(0 << 28)
-#define			AT91_SMC_PS_8			(1 << 28)
-#define			AT91_SMC_PS_16			(2 << 28)
-#define			AT91_SMC_PS_32			(3 << 28)
-
-#endif
diff --git a/arch/arm/mach-at91/sam9_smc.c b/arch/arm/mach-at91/sam9_smc.c
deleted file mode 100644
index 826315af6d11..000000000000
--- a/arch/arm/mach-at91/sam9_smc.c
+++ /dev/null
@@ -1,136 +0,0 @@
-/*
- * linux/arch/arm/mach-at91/sam9_smc.c
- *
- * Copyright (C) 2008 Andrew Victor
- * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#include <mach/at91sam9_smc.h>
-
-#include "sam9_smc.h"
-
-
-#define AT91_SMC_CS(id, n)	(smc_base_addr[id] + ((n) * 0x10))
-
-static void __iomem *smc_base_addr[2];
-
-static void sam9_smc_cs_write_mode(void __iomem *base,
-					struct sam9_smc_config *config)
-{
-	__raw_writel(config->mode
-		   | AT91_SMC_TDF_(config->tdf_cycles),
-		   base + AT91_SMC_MODE);
-}
-
-void sam9_smc_write_mode(int id, int cs,
-					struct sam9_smc_config *config)
-{
-	sam9_smc_cs_write_mode(AT91_SMC_CS(id, cs), config);
-}
-EXPORT_SYMBOL_GPL(sam9_smc_write_mode);
-
-static void sam9_smc_cs_configure(void __iomem *base,
-					struct sam9_smc_config *config)
-{
-
-	/* Setup register */
-	__raw_writel(AT91_SMC_NWESETUP_(config->nwe_setup)
-		   | AT91_SMC_NCS_WRSETUP_(config->ncs_write_setup)
-		   | AT91_SMC_NRDSETUP_(config->nrd_setup)
-		   | AT91_SMC_NCS_RDSETUP_(config->ncs_read_setup),
-		   base + AT91_SMC_SETUP);
-
-	/* Pulse register */
-	__raw_writel(AT91_SMC_NWEPULSE_(config->nwe_pulse)
-		   | AT91_SMC_NCS_WRPULSE_(config->ncs_write_pulse)
-		   | AT91_SMC_NRDPULSE_(config->nrd_pulse)
-		   | AT91_SMC_NCS_RDPULSE_(config->ncs_read_pulse),
-		   base + AT91_SMC_PULSE);
-
-	/* Cycle register */
-	__raw_writel(AT91_SMC_NWECYCLE_(config->write_cycle)
-		   | AT91_SMC_NRDCYCLE_(config->read_cycle),
-		   base + AT91_SMC_CYCLE);
-
-	/* Mode register */
-	sam9_smc_cs_write_mode(base, config);
-}
-
-void sam9_smc_configure(int id, int cs,
-					struct sam9_smc_config *config)
-{
-	sam9_smc_cs_configure(AT91_SMC_CS(id, cs), config);
-}
-EXPORT_SYMBOL_GPL(sam9_smc_configure);
-
-static void sam9_smc_cs_read_mode(void __iomem *base,
-					struct sam9_smc_config *config)
-{
-	u32 val = __raw_readl(base + AT91_SMC_MODE);
-
-	config->mode = (val & ~AT91_SMC_NWECYCLE);
-	config->tdf_cycles = (val & AT91_SMC_NWECYCLE) >> 16 ;
-}
-
-void sam9_smc_read_mode(int id, int cs,
-					struct sam9_smc_config *config)
-{
-	sam9_smc_cs_read_mode(AT91_SMC_CS(id, cs), config);
-}
-EXPORT_SYMBOL_GPL(sam9_smc_read_mode);
-
-static void sam9_smc_cs_read(void __iomem *base,
-					struct sam9_smc_config *config)
-{
-	u32 val;
-
-	/* Setup register */
-	val = __raw_readl(base + AT91_SMC_SETUP);
-
-	config->nwe_setup = val & AT91_SMC_NWESETUP;
-	config->ncs_write_setup = (val & AT91_SMC_NCS_WRSETUP) >> 8;
-	config->nrd_setup = (val & AT91_SMC_NRDSETUP) >> 16;
-	config->ncs_read_setup = (val & AT91_SMC_NCS_RDSETUP) >> 24;
-
-	/* Pulse register */
-	val = __raw_readl(base + AT91_SMC_PULSE);
-
-	config->nwe_pulse = val & AT91_SMC_NWEPULSE;
-	config->ncs_write_pulse = (val & AT91_SMC_NCS_WRPULSE) >> 8;
-	config->nrd_pulse = (val & AT91_SMC_NRDPULSE) >> 16;
-	config->ncs_read_pulse = (val & AT91_SMC_NCS_RDPULSE) >> 24;
-
-	/* Cycle register */
-	val = __raw_readl(base + AT91_SMC_CYCLE);
-
-	config->write_cycle = val & AT91_SMC_NWECYCLE;
-	config->read_cycle = (val & AT91_SMC_NRDCYCLE) >> 16;
-
-	/* Mode register */
-	sam9_smc_cs_read_mode(base, config);
-}
-
-void sam9_smc_read(int id, int cs, struct sam9_smc_config *config)
-{
-	sam9_smc_cs_read(AT91_SMC_CS(id, cs), config);
-}
-
-void __init at91sam9_ioremap_smc(int id, u32 addr)
-{
-	if (id > 1) {
-		pr_warn("%s: id > 2\n", __func__);
-		return;
-	}
-	smc_base_addr[id] = ioremap(addr, 512);
-	if (!smc_base_addr[id])
-		pr_warn("Impossible to ioremap smc.%d 0x%x\n", id, addr);
-}
diff --git a/arch/arm/mach-at91/sam9_smc.h b/arch/arm/mach-at91/sam9_smc.h
deleted file mode 100644
index 3e52dcd4a59f..000000000000
--- a/arch/arm/mach-at91/sam9_smc.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * linux/arch/arm/mach-at91/sam9_smc.
- *
- * Copyright (C) 2008 Andrew Victor
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-extern void __init at91sam9_ioremap_smc(int id, u32 addr);
-- 
2.1.0
