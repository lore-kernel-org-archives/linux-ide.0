From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] arm: lart_defconfig: disable IDE subsystem
Date: Fri, 14 Aug 2015 19:04:27 +0200
Message-ID: <1439571876-13758-12-git-send-email-b.zolnierkie@samsung.com>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, b.zolnierkie@samsung.com, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
List-Id: linux-ide@vger.kernel.org

This patch disables deprecated IDE subsystem in lart_defconfig
(no IDE host drivers are selected in this config so there is no
valid reason to enable IDE subsystem itself).

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/lart_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index faa2865..8fc6fd0 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -36,8 +36,6 @@ CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_LART=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_IDE=m
-CONFIG_BLK_DEV_IDECD=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
 CONFIG_NET_ETHERNET=y
-- 
1.9.1
