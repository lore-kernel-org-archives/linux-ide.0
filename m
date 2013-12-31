From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ata: pata_samsung_cf: Move plat/regs-ata.h to drivers/ata
Date: Tue, 31 Dec 2013 10:59:13 +0530
Message-ID: <1388467753-24431-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, tj@kernel.org, sachin.kamat@linaro.org, patches@linaro.org
List-Id: linux-ide@vger.kernel.org

plat/regs-ata.h is used only by Samsung PATA driver.
Move this file to the drivers folder to remove platform
dependency required for multiplatform support.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/ata/pata_samsung_cf.c                      |    2 +-
 .../regs-ata.h => drivers/ata/pata_samsung_cf.h    |    9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)
 rename arch/arm/plat-samsung/include/plat/regs-ata.h => drivers/ata/pata_samsung_cf.h (91%)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index 898e544a7ae8..e04d70b7ce76 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -24,7 +24,7 @@
 #include <linux/slab.h>
 
 #include <linux/platform_data/ata-samsung_cf.h>
-#include <plat/regs-ata.h>
+#include "pata_samsung_cf.h"
 
 #define DRV_NAME "pata_samsung_cf"
 #define DRV_VERSION "0.1"
diff --git a/arch/arm/plat-samsung/include/plat/regs-ata.h b/drivers/ata/pata_samsung_cf.h
similarity index 91%
rename from arch/arm/plat-samsung/include/plat/regs-ata.h
rename to drivers/ata/pata_samsung_cf.h
index f5df92fdae26..eeefe2e0cdc6 100644
--- a/arch/arm/plat-samsung/include/plat/regs-ata.h
+++ b/drivers/ata/pata_samsung_cf.h
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-samsung/include/plat/regs-ata.h
- *
+/*
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
@@ -10,8 +9,8 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_PLAT_REGS_ATA_H
-#define __ASM_PLAT_REGS_ATA_H __FILE__
+#ifndef __PATA_SAMSUNG_CF_H
+#define __PATA_SAMSUNG_CF_H
 
 #define S3C_CFATA_REG(x)	(x)
 
@@ -53,4 +52,4 @@
 #define S3C_ATA_CFG_SWAP	0x40
 #define S3C_ATA_CFG_IORDYEN	0x02
 
-#endif /* __ASM_PLAT_REGS_ATA_H */
+#endif /* __PATA_SAMSUNG_CF_H */
-- 
1.7.9.5
