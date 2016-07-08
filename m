From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] sh: se7750_defconfig: disable IDE subsystem
Date: Fri, 08 Jul 2016 18:43:44 +0200
Message-ID: <1467996225-25498-5-git-send-email-b.zolnierkie@samsung.com>
References: <1467996225-25498-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <1467996225-25498-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

This patch disables deprecated IDE subsystem in se7750_defconfig
(no IDE host drivers are selected in this config so there is no
valid reason to enable IDE subsystem itself).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/sh/configs/se7750_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/configs/se7750_defconfig b/arch/sh/configs/se7750_defconfig
index 912c985..88b81b7 100644
--- a/arch/sh/configs/se7750_defconfig
+++ b/arch/sh/configs/se7750_defconfig
@@ -34,7 +34,6 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_ROM=y
-CONFIG_IDE=y
 CONFIG_SCSI=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
-- 
1.9.1

