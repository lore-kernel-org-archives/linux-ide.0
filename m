From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] arm: shannon_defconfig: disable IDE subsystem
Date: Fri, 14 Aug 2015 19:04:34 +0200
Message-ID: <1439571876-13758-19-git-send-email-b.zolnierkie@samsung.com>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, b.zolnierkie@samsung.com, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
List-Id: linux-ide@vger.kernel.org

This patch disables deprecated IDE subsystem in shannon_defconfig
(no IDE host drivers are selected in this config so there is no
valid reason to enable IDE subsystem itself).

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/shannon_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shannon_defconfig b/arch/arm/configs/shannon_defconfig
index b0b9694..e523956 100644
--- a/arch/arm/configs/shannon_defconfig
+++ b/arch/arm/configs/shannon_defconfig
@@ -25,7 +25,6 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_SA1100=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_IDE=m
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_PCMCIA=y
-- 
1.9.1
