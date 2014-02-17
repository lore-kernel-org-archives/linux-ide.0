From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH v2] ata: ata-samsung_cf: Trivial cleanup in header file
Date: Mon, 17 Feb 2014 09:11:53 +0530
Message-ID: <1392608513-24294-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:62026 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaBQDrU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Feb 2014 22:47:20 -0500
Received: by mail-pd0-f173.google.com with SMTP id y10so14294057pdj.4
        for <linux-ide@vger.kernel.org>; Sun, 16 Feb 2014 19:47:19 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: tj@kernel.org, trivial@kernel.org, sergei.shtylyov@cogentembedded.com, sachin.kamat@linaro.org

Commit 436d42c61c3e ("ARM: samsung: move platform_data definitions")
moved the files to the current location but forgot to remove the pointer
to its previous location. Clean it up. While at it also change the header
file protection macros appropriately.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Dropped additional ATA from macro.
---
 include/linux/platform_data/ata-samsung_cf.h |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/platform_data/ata-samsung_cf.h b/include/linux/platform_data/ata-samsung_cf.h
index 2a3855a8372a..c2049e3d7444 100644
--- a/include/linux/platform_data/ata-samsung_cf.h
+++ b/include/linux/platform_data/ata-samsung_cf.h
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-samsung/include/plat/ata.h
- *
+/*
  * Copyright (c) 2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
@@ -10,8 +9,8 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_PLAT_ATA_H
-#define __ASM_PLAT_ATA_H __FILE__
+#ifndef __ATA_SAMSUNG_CF_H
+#define __ATA_SAMSUNG_CF_H __FILE__
 
 /**
  * struct s3c_ide_platdata - S3C IDE driver platform data.
@@ -33,4 +32,4 @@ extern void s3c64xx_ide_setup_gpio(void);
 extern void s5pc100_ide_setup_gpio(void);
 extern void s5pv210_ide_setup_gpio(void);
 
-#endif /*__ASM_PLAT_ATA_H */
+#endif /*__ATA_SAMSUNG_CF_H */
-- 
1.7.9.5

