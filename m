From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ata: pata_samsung_cf: Merge pata_samsung_cf.h into pata_samsung_cf.c
Date: Thu,  2 Jan 2014 08:39:31 +0530
Message-ID: <1388632171-17732-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:49284 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbaABDNQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jan 2014 22:13:16 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so13653994pdj.31
        for <linux-ide@vger.kernel.org>; Wed, 01 Jan 2014 19:13:15 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org, sachin.kamat@linaro.org, patches@linaro.org

Since pata_samsung_cf.h is referenced only by pata_samsung_cf.c, merge
it into the .c file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/ata/pata_samsung_cf.c |   38 +++++++++++++++++++++++++++-
 drivers/ata/pata_samsung_cf.h |   55 -----------------------------------------
 2 files changed, 37 insertions(+), 56 deletions(-)
 delete mode 100644 drivers/ata/pata_samsung_cf.h

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index e04d70b7ce76..cd2746b169a9 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -24,11 +24,47 @@
 #include <linux/slab.h>
 
 #include <linux/platform_data/ata-samsung_cf.h>
-#include "pata_samsung_cf.h"
 
 #define DRV_NAME "pata_samsung_cf"
 #define DRV_VERSION "0.1"
 
+#define S3C_CFATA_REG(x)	(x)
+#define S3C_CFATA_MUX		S3C_CFATA_REG(0x0)
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
+#define S3C_ATA_CFG_SWAP	0x40
+#define S3C_ATA_CFG_IORDYEN	0x02
+
 enum s3c_cpu_type {
 	TYPE_S3C64XX,
 	TYPE_S5PC100,
diff --git a/drivers/ata/pata_samsung_cf.h b/drivers/ata/pata_samsung_cf.h
deleted file mode 100644
index eeefe2e0cdc6..000000000000
--- a/drivers/ata/pata_samsung_cf.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Samsung CF-ATA register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __PATA_SAMSUNG_CF_H
-#define __PATA_SAMSUNG_CF_H
-
-#define S3C_CFATA_REG(x)	(x)
-
-#define S3C_CFATA_MUX		S3C_CFATA_REG(0x0)
-
-#define S3C_ATA_CTRL		S3C_CFATA_REG(0x0)
-#define S3C_ATA_STATUS		S3C_CFATA_REG(0x4)
-#define S3C_ATA_CMD		S3C_CFATA_REG(0x8)
-#define S3C_ATA_SWRST		S3C_CFATA_REG(0xc)
-#define S3C_ATA_IRQ		S3C_CFATA_REG(0x10)
-#define S3C_ATA_IRQ_MSK		S3C_CFATA_REG(0x14)
-#define S3C_ATA_CFG		S3C_CFATA_REG(0x18)
-
-#define S3C_ATA_MDMA_TIME	S3C_CFATA_REG(0x28)
-#define S3C_ATA_PIO_TIME	S3C_CFATA_REG(0x2c)
-#define S3C_ATA_UDMA_TIME	S3C_CFATA_REG(0x30)
-#define S3C_ATA_XFR_NUM		S3C_CFATA_REG(0x34)
-#define S3C_ATA_XFR_CNT		S3C_CFATA_REG(0x38)
-#define S3C_ATA_TBUF_START	S3C_CFATA_REG(0x3c)
-#define S3C_ATA_TBUF_SIZE	S3C_CFATA_REG(0x40)
-#define S3C_ATA_SBUF_START	S3C_CFATA_REG(0x44)
-#define S3C_ATA_SBUF_SIZE	S3C_CFATA_REG(0x48)
-#define S3C_ATA_CADR_TBUF	S3C_CFATA_REG(0x4c)
-#define S3C_ATA_CADR_SBUF	S3C_CFATA_REG(0x50)
-#define S3C_ATA_PIO_DTR		S3C_CFATA_REG(0x54)
-#define S3C_ATA_PIO_FED		S3C_CFATA_REG(0x58)
-#define S3C_ATA_PIO_SCR		S3C_CFATA_REG(0x5c)
-#define S3C_ATA_PIO_LLR		S3C_CFATA_REG(0x60)
-#define S3C_ATA_PIO_LMR		S3C_CFATA_REG(0x64)
-#define S3C_ATA_PIO_LHR		S3C_CFATA_REG(0x68)
-#define S3C_ATA_PIO_DVR		S3C_CFATA_REG(0x6c)
-#define S3C_ATA_PIO_CSD		S3C_CFATA_REG(0x70)
-#define S3C_ATA_PIO_DAD		S3C_CFATA_REG(0x74)
-#define S3C_ATA_PIO_READY	S3C_CFATA_REG(0x78)
-#define S3C_ATA_PIO_RDATA	S3C_CFATA_REG(0x7c)
-
-#define S3C_CFATA_MUX_TRUEIDE	0x01
-
-#define S3C_ATA_CFG_SWAP	0x40
-#define S3C_ATA_CFG_IORDYEN	0x02
-
-#endif /* __PATA_SAMSUNG_CF_H */
-- 
1.7.9.5

