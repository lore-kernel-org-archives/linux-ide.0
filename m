From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 09/10] ARM: at91: remove mach/at91_ramc.h and mach/at91rm9200_mc.h
Date: Mon, 16 Mar 2015 23:44:45 +0100
Message-ID: <1426545886-19162-10-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Lee Jones <lee.jones@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

mach/at91_ramc.h and mach/at91rm9200_mc.h are necessary anymore, remove them.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/Makefile                     |   3 -
 arch/arm/mach-at91/include/mach/at91_ramc.h     |  28 ------
 arch/arm/mach-at91/include/mach/at91rm9200_mc.h | 116 ------------------------
 arch/arm/mach-at91/pm.h                         |  14 ++-
 arch/arm/mach-at91/pm_suspend.S                 |   1 -
 5 files changed, 13 insertions(+), 149 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_ramc.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91rm9200_mc.h

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 3586d977e99d..fa4393ab3e7b 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -1,9 +1,6 @@
 #
 # Makefile for the linux kernel.
 #
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
-asflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
-
 obj-y		:= soc.o
 
 # CPU-specific support
diff --git a/arch/arm/mach-at91/include/mach/at91_ramc.h b/arch/arm/mach-at91/include/mach/at91_ramc.h
deleted file mode 100644
index 39547496d4b0..000000000000
--- a/arch/arm/mach-at91/include/mach/at91_ramc.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Header file for the Atmel RAM Controller
- *
- * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
- *
- * Under GPLv2 only
- */
-
-#ifndef __AT91_RAMC_H__
-#define __AT91_RAMC_H__
-
-#ifndef __ASSEMBLY__
-extern void __iomem *at91_ramc_base[];
-
-#define at91_ramc_read(id, field) \
-	__raw_readl(at91_ramc_base[id] + field)
-
-#define at91_ramc_write(id, field, value) \
-	__raw_writel(value, at91_ramc_base[id] + field)
-#else
-.extern at91_ramc_base
-#endif
-
-#include <linux/mfd/syscon/atmel-mc.h>
-#include <soc/at91/at91sam9_ddrsdr.h>
-#include <soc/at91/at91sam9_sdramc.h>
-
-#endif /* __AT91_RAMC_H__ */
diff --git a/arch/arm/mach-at91/include/mach/at91rm9200_mc.h b/arch/arm/mach-at91/include/mach/at91rm9200_mc.h
deleted file mode 100644
index aeaadfb452af..000000000000
--- a/arch/arm/mach-at91/include/mach/at91rm9200_mc.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/at91rm9200_mc.h
- *
- * Copyright (C) 2005 Ivan Kokshaysky
- * Copyright (C) SAN People
- *
- * Memory Controllers (MC, EBI, SMC, SDRAMC, BFC) - System peripherals registers.
- * Based on AT91RM9200 datasheet revision E.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef AT91RM9200_MC_H
-#define AT91RM9200_MC_H
-
-/* Memory Controller */
-#define AT91_MC_RCR		0x00			/* MC Remap Control Register */
-#define		AT91_MC_RCB		(1 <<  0)		/* Remap Command Bit */
-
-#define AT91_MC_ASR		0x04			/* MC Abort Status Register */
-#define		AT91_MC_UNADD		(1 <<  0)		/* Undefined Address Abort Status */
-#define		AT91_MC_MISADD		(1 <<  1)		/* Misaligned Address Abort Status */
-#define		AT91_MC_ABTSZ		(3 <<  8)		/* Abort Size Status */
-#define			AT91_MC_ABTSZ_BYTE		(0 << 8)
-#define			AT91_MC_ABTSZ_HALFWORD		(1 << 8)
-#define			AT91_MC_ABTSZ_WORD		(2 << 8)
-#define		AT91_MC_ABTTYP		(3 << 10)		/* Abort Type Status */
-#define			AT91_MC_ABTTYP_DATAREAD		(0 << 10)
-#define			AT91_MC_ABTTYP_DATAWRITE	(1 << 10)
-#define			AT91_MC_ABTTYP_FETCH		(2 << 10)
-#define		AT91_MC_MST0		(1 << 16)		/* ARM920T Abort Source */
-#define		AT91_MC_MST1		(1 << 17)		/* PDC Abort Source */
-#define		AT91_MC_MST2		(1 << 18)		/* UHP Abort Source */
-#define		AT91_MC_MST3		(1 << 19)		/* EMAC Abort Source */
-#define		AT91_MC_SVMST0		(1 << 24)		/* Saved ARM920T Abort Source */
-#define		AT91_MC_SVMST1		(1 << 25)		/* Saved PDC Abort Source */
-#define		AT91_MC_SVMST2		(1 << 26)		/* Saved UHP Abort Source */
-#define		AT91_MC_SVMST3		(1 << 27)		/* Saved EMAC Abort Source */
-
-#define AT91_MC_AASR		0x08			/* MC Abort Address Status Register */
-
-#define AT91_MC_MPR		0x0c			/* MC Master Priority Register */
-#define		AT91_MPR_MSTP0		(7 <<  0)		/* ARM920T Priority */
-#define		AT91_MPR_MSTP1		(7 <<  4)		/* PDC Priority */
-#define		AT91_MPR_MSTP2		(7 <<  8)		/* UHP Priority */
-#define		AT91_MPR_MSTP3		(7 << 12)		/* EMAC Priority */
-
-/* External Bus Interface (EBI) registers */
-#define AT91_EBI_CSA		0x60			/* Chip Select Assignment Register */
-#define		AT91_EBI_CS0A		(1 << 0)		/* Chip Select 0 Assignment */
-#define			AT91_EBI_CS0A_SMC		(0 << 0)
-#define			AT91_EBI_CS0A_BFC		(1 << 0)
-#define		AT91_EBI_CS1A		(1 << 1)		/* Chip Select 1 Assignment */
-#define			AT91_EBI_CS1A_SMC		(0 << 1)
-#define			AT91_EBI_CS1A_SDRAMC		(1 << 1)
-#define		AT91_EBI_CS3A		(1 << 3)		/* Chip Select 2 Assignment */
-#define			AT91_EBI_CS3A_SMC		(0 << 3)
-#define			AT91_EBI_CS3A_SMC_SMARTMEDIA	(1 << 3)
-#define		AT91_EBI_CS4A		(1 << 4)		/* Chip Select 3 Assignment */
-#define			AT91_EBI_CS4A_SMC		(0 << 4)
-#define			AT91_EBI_CS4A_SMC_COMPACTFLASH	(1 << 4)
-#define AT91_EBI_CFGR		(AT91_MC + 0x64)	/* Configuration Register */
-#define		AT91_EBI_DBPUC		(1 << 0)		/* Data Bus Pull-Up Configuration */
-
-/* Static Memory Controller (SMC) registers */
-#define	AT91_SMC_CSR(n)		(0x70 + ((n) * 4))	/* SMC Chip Select Register */
-#define		AT91_SMC_NWS		(0x7f <<  0)		/* Number of Wait States */
-#define			AT91_SMC_NWS_(x)	((x) << 0)
-#define		AT91_SMC_WSEN		(1    <<  7)		/* Wait State Enable */
-#define		AT91_SMC_TDF		(0xf  <<  8)		/* Data Float Time */
-#define			AT91_SMC_TDF_(x)	((x) << 8)
-#define		AT91_SMC_BAT		(1    << 12)		/* Byte Access Type */
-#define		AT91_SMC_DBW		(3    << 13)		/* Data Bus Width */
-#define			AT91_SMC_DBW_16		(1 << 13)
-#define			AT91_SMC_DBW_8		(2 << 13)
-#define		AT91_SMC_DPR		(1 << 15)		/* Data Read Protocol */
-#define		AT91_SMC_ACSS		(3 << 16)		/* Address to Chip Select Setup */
-#define			AT91_SMC_ACSS_STD	(0 << 16)
-#define			AT91_SMC_ACSS_1		(1 << 16)
-#define			AT91_SMC_ACSS_2		(2 << 16)
-#define			AT91_SMC_ACSS_3		(3 << 16)
-#define		AT91_SMC_RWSETUP	(7 << 24)		/* Read & Write Signal Time Setup */
-#define			AT91_SMC_RWSETUP_(x)	((x) << 24)
-#define		AT91_SMC_RWHOLD		(7 << 28)		/* Read & Write Signal Hold Time */
-#define			AT91_SMC_RWHOLD_(x)	((x) << 28)
-
-/* Burst Flash Controller register */
-#define AT91_BFC_MR		0xc0			/* Mode Register */
-#define		AT91_BFC_BFCOM		(3   <<  0)		/* Burst Flash Controller Operating Mode */
-#define			AT91_BFC_BFCOM_DISABLED	(0 << 0)
-#define			AT91_BFC_BFCOM_ASYNC	(1 << 0)
-#define			AT91_BFC_BFCOM_BURST	(2 << 0)
-#define		AT91_BFC_BFCC		(3   <<  2)		/* Burst Flash Controller Clock */
-#define			AT91_BFC_BFCC_MCK	(1 << 2)
-#define			AT91_BFC_BFCC_DIV2	(2 << 2)
-#define			AT91_BFC_BFCC_DIV4	(3 << 2)
-#define		AT91_BFC_AVL		(0xf <<  4)		/* Address Valid Latency */
-#define		AT91_BFC_PAGES		(7   <<  8)		/* Page Size */
-#define			AT91_BFC_PAGES_NO_PAGE	(0 << 8)
-#define			AT91_BFC_PAGES_16	(1 << 8)
-#define			AT91_BFC_PAGES_32	(2 << 8)
-#define			AT91_BFC_PAGES_64	(3 << 8)
-#define			AT91_BFC_PAGES_128	(4 << 8)
-#define			AT91_BFC_PAGES_256	(5 << 8)
-#define			AT91_BFC_PAGES_512	(6 << 8)
-#define			AT91_BFC_PAGES_1024	(7 << 8)
-#define		AT91_BFC_OEL		(3   << 12)		/* Output Enable Latency */
-#define		AT91_BFC_BAAEN		(1   << 16)		/* Burst Address Advance Enable */
-#define		AT91_BFC_BFOEH		(1   << 17)		/* Burst Flash Output Enable Handling */
-#define		AT91_BFC_MUXEN		(1   << 18)		/* Multiplexed Bus Enable */
-#define		AT91_BFC_RDYEN		(1   << 19)		/* Ready Enable Mode */
-
-#endif
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index ecd875a91d52..3fcf8810f14e 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -13,7 +13,19 @@
 
 #include <asm/proc-fns.h>
 
-#include <mach/at91_ramc.h>
+#include <linux/mfd/syscon/atmel-mc.h>
+#include <soc/at91/at91sam9_ddrsdr.h>
+#include <soc/at91/at91sam9_sdramc.h>
+
+#ifndef __ASSEMBLY__
+extern void __iomem *at91_ramc_base[];
+
+#define at91_ramc_read(id, field) \
+	__raw_readl(at91_ramc_base[id] + field)
+
+#define at91_ramc_write(id, field, value) \
+	__raw_writel(value, at91_ramc_base[id] + field)
+#endif
 
 #define AT91_MEMCTRL_MC		0
 #define AT91_MEMCTRL_SDRAMC	1
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index fda4e0164ed7..0d95f488b47a 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -13,7 +13,6 @@
  */
 #include <linux/linkage.h>
 #include <linux/clk/at91_pmc.h>
-#include <mach/at91_ramc.h>
 #include "pm.h"
 
 #define	SRAMC_SELF_FRESH_ACTIVE		0x01
-- 
2.1.0
