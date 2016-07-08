From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RESEND PATCH] arm: colibri_pxa270_defconfig: disable IDE subsystem
Date: Fri, 08 Jul 2016 17:24:44 +0200
Message-ID: <1467991490-24895-4-git-send-email-b.zolnierkie@samsung.com>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35072 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649AbcGHP0O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jul 2016 11:26:14 -0400
In-reply-to: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, b.zolnierkie@samsung.com, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>

This patch disables deprecated IDE subsystem in colibri_pxa270_defconfig
(no IDE host drivers are selected in this config so there is no valid
reason to enable IDE subsystem itself).

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/colibri_pxa270_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/colibri_pxa270_defconfig b/arch/arm/configs/colibri_pxa270_defconfig
index 18c311a..7154e55 100644
--- a/arch/arm/configs/colibri_pxa270_defconfig
+++ b/arch/arm/configs/colibri_pxa270_defconfig
@@ -83,7 +83,6 @@ CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=8
-CONFIG_IDE=y
 CONFIG_NETDEVICES=y
 CONFIG_PHYLIB=y
 CONFIG_NET_ETHERNET=y
-- 
1.9.1

