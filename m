From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ata: pata_samsung_cf: Remove unused macros
Date: Mon,  6 Jan 2014 10:05:15 +0530
Message-ID: <1388982915-15623-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:46536 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbaAFEjH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Jan 2014 23:39:07 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so17614132pdj.31
        for <linux-ide@vger.kernel.org>; Sun, 05 Jan 2014 20:39:06 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org, sachin.kamat@linaro.org, patches@linaro.org

These macros are not used in the file. Remove them.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/ata/pata_samsung_cf.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index cd2746b169a9..bdf8f3e155bc 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -31,24 +31,12 @@
 #define S3C_CFATA_REG(x)	(x)
 #define S3C_CFATA_MUX		S3C_CFATA_REG(0x0)
 #define S3C_ATA_CTRL		S3C_CFATA_REG(0x0)
-#define S3C_ATA_STATUS		S3C_CFATA_REG(0x4)
 #define S3C_ATA_CMD		S3C_CFATA_REG(0x8)
-#define S3C_ATA_SWRST		S3C_CFATA_REG(0xc)
 #define S3C_ATA_IRQ		S3C_CFATA_REG(0x10)
 #define S3C_ATA_IRQ_MSK		S3C_CFATA_REG(0x14)
 #define S3C_ATA_CFG		S3C_CFATA_REG(0x18)
 
-#define S3C_ATA_MDMA_TIME	S3C_CFATA_REG(0x28)
 #define S3C_ATA_PIO_TIME	S3C_CFATA_REG(0x2c)
-#define S3C_ATA_UDMA_TIME	S3C_CFATA_REG(0x30)
-#define S3C_ATA_XFR_NUM		S3C_CFATA_REG(0x34)
-#define S3C_ATA_XFR_CNT		S3C_CFATA_REG(0x38)
-#define S3C_ATA_TBUF_START	S3C_CFATA_REG(0x3c)
-#define S3C_ATA_TBUF_SIZE	S3C_CFATA_REG(0x40)
-#define S3C_ATA_SBUF_START	S3C_CFATA_REG(0x44)
-#define S3C_ATA_SBUF_SIZE	S3C_CFATA_REG(0x48)
-#define S3C_ATA_CADR_TBUF	S3C_CFATA_REG(0x4c)
-#define S3C_ATA_CADR_SBUF	S3C_CFATA_REG(0x50)
 #define S3C_ATA_PIO_DTR		S3C_CFATA_REG(0x54)
 #define S3C_ATA_PIO_FED		S3C_CFATA_REG(0x58)
 #define S3C_ATA_PIO_SCR		S3C_CFATA_REG(0x5c)
@@ -58,7 +46,6 @@
 #define S3C_ATA_PIO_DVR		S3C_CFATA_REG(0x6c)
 #define S3C_ATA_PIO_CSD		S3C_CFATA_REG(0x70)
 #define S3C_ATA_PIO_DAD		S3C_CFATA_REG(0x74)
-#define S3C_ATA_PIO_READY	S3C_CFATA_REG(0x78)
 #define S3C_ATA_PIO_RDATA	S3C_CFATA_REG(0x7c)
 
 #define S3C_CFATA_MUX_TRUEIDE	0x01
-- 
1.7.9.5

