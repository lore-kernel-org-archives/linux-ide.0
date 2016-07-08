From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] sh: sdk7786_defconfig: disable IDE subsystem
Date: Fri, 08 Jul 2016 18:43:43 +0200
Message-ID: <1467996225-25498-4-git-send-email-b.zolnierkie@samsung.com>
References: <1467996225-25498-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <1467996225-25498-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

This patch disables deprecated IDE subsystem in sdk7786_defconfig
(this config already enables pata_platform host driver which
supersedes ide_platform one).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/sh/configs/sdk7786_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 280695c..10123c8 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -120,9 +120,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
 # CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_PLATFORM=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_MULTI_LUN=y
-- 
1.9.1

