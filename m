From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] sh: microdev_defconfig: disable IDE subsystem
Date: Fri, 08 Jul 2016 18:43:41 +0200
Message-ID: <1467996225-25498-2-git-send-email-b.zolnierkie@samsung.com>
References: <1467996225-25498-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <1467996225-25498-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

This patch disables deprecated IDE subsystem in microdev_defconfig
(no IDE host drivers are selected in this config so there is no
valid reason to enable IDE subsystem itself).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/sh/configs/microdev_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/configs/microdev_defconfig b/arch/sh/configs/microdev_defconfig
index f1d2e1b..1c4bcbd 100644
--- a/arch/sh/configs/microdev_defconfig
+++ b/arch/sh/configs/microdev_defconfig
@@ -24,8 +24,6 @@ CONFIG_IP_PNP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
 CONFIG_BLK_DEV_RAM=y
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_SMC91X=y
-- 
1.9.1

