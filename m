From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 8/9] ARM: at91: remove at91rm9200_sdramc.h
Date: Mon, 23 Mar 2015 20:29:14 +0100
Message-ID: <1427138955-3617-9-git-send-email-alexandre.belloni@free-electrons.com>
References: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427138955-3617-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

include/soc/at91/at91rm9200_sdramc.h is replaced by
include/linux/mfd/syscon/atmel-smc.h as this is actually a syscon device.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 include/soc/at91/at91rm9200_sdramc.h | 63 ------------------------------------
 1 file changed, 63 deletions(-)
 delete mode 100644 include/soc/at91/at91rm9200_sdramc.h

diff --git a/include/soc/at91/at91rm9200_sdramc.h b/include/soc/at91/at91rm9200_sdramc.h
deleted file mode 100644
index aa047f458f1b..000000000000
--- a/include/soc/at91/at91rm9200_sdramc.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * arch/arm/mach-at91/include/mach/at91rm9200_sdramc.h
- *
- * Copyright (C) 2005 Ivan Kokshaysky
- * Copyright (C) SAN People
- *
- * Memory Controllers (SDRAMC only) - System peripherals registers.
- * Based on AT91RM9200 datasheet revision E.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef AT91RM9200_SDRAMC_H
-#define AT91RM9200_SDRAMC_H
-
-/* SDRAM Controller registers */
-#define AT91RM9200_SDRAMC_MR		0x90			/* Mode Register */
-#define		AT91RM9200_SDRAMC_MODE	(0xf << 0)		/* Command Mode */
-#define			AT91RM9200_SDRAMC_MODE_NORMAL		(0 << 0)
-#define			AT91RM9200_SDRAMC_MODE_NOP		(1 << 0)
-#define			AT91RM9200_SDRAMC_MODE_PRECHARGE	(2 << 0)
-#define			AT91RM9200_SDRAMC_MODE_LMR		(3 << 0)
-#define			AT91RM9200_SDRAMC_MODE_REFRESH	(4 << 0)
-#define		AT91RM9200_SDRAMC_DBW		(1   << 4)		/* Data Bus Width */
-#define			AT91RM9200_SDRAMC_DBW_32	(0 << 4)
-#define			AT91RM9200_SDRAMC_DBW_16	(1 << 4)
-
-#define AT91RM9200_SDRAMC_TR		0x94			/* Refresh Timer Register */
-#define		AT91RM9200_SDRAMC_COUNT	(0xfff << 0)		/* Refresh Timer Count */
-
-#define AT91RM9200_SDRAMC_CR		0x98			/* Configuration Register */
-#define		AT91RM9200_SDRAMC_NC		(3   <<  0)		/* Number of Column Bits */
-#define			AT91RM9200_SDRAMC_NC_8	(0 << 0)
-#define			AT91RM9200_SDRAMC_NC_9	(1 << 0)
-#define			AT91RM9200_SDRAMC_NC_10	(2 << 0)
-#define			AT91RM9200_SDRAMC_NC_11	(3 << 0)
-#define		AT91RM9200_SDRAMC_NR		(3   <<  2)		/* Number of Row Bits */
-#define			AT91RM9200_SDRAMC_NR_11	(0 << 2)
-#define			AT91RM9200_SDRAMC_NR_12	(1 << 2)
-#define			AT91RM9200_SDRAMC_NR_13	(2 << 2)
-#define		AT91RM9200_SDRAMC_NB		(1   <<  4)		/* Number of Banks */
-#define			AT91RM9200_SDRAMC_NB_2	(0 << 4)
-#define			AT91RM9200_SDRAMC_NB_4	(1 << 4)
-#define		AT91RM9200_SDRAMC_CAS		(3   <<  5)		/* CAS Latency */
-#define			AT91RM9200_SDRAMC_CAS_2	(2 << 5)
-#define		AT91RM9200_SDRAMC_TWR		(0xf <<  7)		/* Write Recovery Delay */
-#define		AT91RM9200_SDRAMC_TRC		(0xf << 11)		/* Row Cycle Delay */
-#define		AT91RM9200_SDRAMC_TRP		(0xf << 15)		/* Row Precharge Delay */
-#define		AT91RM9200_SDRAMC_TRCD	(0xf << 19)		/* Row to Column Delay */
-#define		AT91RM9200_SDRAMC_TRAS	(0xf << 23)		/* Active to Precharge Delay */
-#define		AT91RM9200_SDRAMC_TXSR	(0xf << 27)		/* Exit Self Refresh to Active Delay */
-
-#define AT91RM9200_SDRAMC_SRR		0x9c			/* Self Refresh Register */
-#define AT91RM9200_SDRAMC_LPR		0xa0			/* Low Power Register */
-#define AT91RM9200_SDRAMC_IER		0xa4			/* Interrupt Enable Register */
-#define AT91RM9200_SDRAMC_IDR		0xa8			/* Interrupt Disable Register */
-#define AT91RM9200_SDRAMC_IMR		0xac			/* Interrupt Mask Register */
-#define AT91RM9200_SDRAMC_ISR		0xb0			/* Interrupt Status Register */
-
-#endif
-- 
2.1.0
