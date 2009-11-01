From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH 3/7] S3C64XX: Add IDE controller register definitions.
Date: Sun,  1 Nov 2009 13:53:45 +0900
Message-ID: <1257051225-8102-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:50519 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbZKAE5i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Nov 2009 00:57:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, Thomas Abraham <thomas.ab@samsung.com>

This patch adds the register definitions for S3C IDE controller.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/plat-s3c/include/plat/regs-ide.h |   56 +++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s3c/include/plat/regs-ide.h

diff --git a/arch/arm/plat-s3c/include/plat/regs-ide.h b/arch/arm/plat-s3c/include/plat/regs-ide.h
new file mode 100644
index 0000000..2624619
--- /dev/null
+++ b/arch/arm/plat-s3c/include/plat/regs-ide.h
@@ -0,0 +1,56 @@
+/* arch/arm/plat-s3c/include/plat/regs-ide.h
+ *
+ * Copyright (C) 2009 Samsung Electronics
+ * 	http://samsungsemi.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C64XX IDE register definitions
+*/
+
+#ifndef __ASM_ARM_REGS_IDE
+#define __ASM_ARM_REGS_IDE __FILE__
+
+#define S3C_CFATA_REG(x) (x)
+
+#define S3C_CFATA_MUX           S3C_CFATA_REG(0x1800)
+
+#define S3C_ATA_CTRL            S3C_CFATA_REG(0x1900)
+#define S3C_ATA_STATUS          S3C_CFATA_REG(0x1904)
+#define S3C_ATA_CMD             S3C_CFATA_REG(0x1908)
+#define S3C_ATA_SWRST           S3C_CFATA_REG(0x190c)
+#define S3C_ATA_IRQ             S3C_CFATA_REG(0x1910)
+#define S3C_ATA_IRQ_MSK         S3C_CFATA_REG(0x1914)
+#define S3C_ATA_CFG             S3C_CFATA_REG(0x1918)
+
+#define S3C_ATA_PIO_TIME        S3C_CFATA_REG(0x192c)
+#define S3C_ATA_UDMA_TIME       S3C_CFATA_REG(0x1930)
+#define S3C_ATA_XFR_NUM         S3C_CFATA_REG(0x1934)
+#define S3C_ATA_XFR_CNT         S3C_CFATA_REG(0x1938)
+#define S3C_ATA_TBUF_START      S3C_CFATA_REG(0x193c)
+#define S3C_ATA_TBUF_SIZE       S3C_CFATA_REG(0x1940)
+#define S3C_ATA_SBUF_START      S3C_CFATA_REG(0x1944)
+#define S3C_ATA_SBUF_SIZE       S3C_CFATA_REG(0x1948)
+#define S3C_ATA_CADR_TBUF       S3C_CFATA_REG(0x194c)
+#define S3C_ATA_CADR_SBUF       S3C_CFATA_REG(0x1950)
+#define S3C_ATA_PIO_DTR         S3C_CFATA_REG(0x1954)
+#define S3C_ATA_PIO_FED         S3C_CFATA_REG(0x1958)
+#define S3C_ATA_PIO_SCR         S3C_CFATA_REG(0x195c)
+#define S3C_ATA_PIO_LLR         S3C_CFATA_REG(0x1960)
+#define S3C_ATA_PIO_LMR         S3C_CFATA_REG(0x1964)
+#define S3C_ATA_PIO_LHR         S3C_CFATA_REG(0x1968)
+#define S3C_ATA_PIO_DVR         S3C_CFATA_REG(0x196c)
+#define S3C_ATA_PIO_CSD         S3C_CFATA_REG(0x1970)
+#define S3C_ATA_PIO_DAD         S3C_CFATA_REG(0x1974)
+#define S3C_ATA_PIO_RDATA       S3C_CFATA_REG(0x197c)
+#define S3C_BUS_FIFO_STATUS     S3C_CFATA_REG(0x1990)
+#define S3C_ATA_FIFO_STATUS     S3C_CFATA_REG(0x1994)
+
+#define S3C_CFATA_MUX_TRUEIDE	0x01
+#define S3C_ATA_CFG_SWAP	0x40
+#define S3C_ATA_CFG_IORDYEN	0x02
+
+#endif /* __ASM_ARM_REGS_IDE */
+
-- 
1.5.3.4

