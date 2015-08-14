From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Fri, 14 Aug 2015 19:04:17 +0200
Message-ID: <1439571876-13758-2-git-send-email-b.zolnierkie@samsung.com>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43011 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612AbbHNRHD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Aug 2015 13:07:03 -0400
In-reply-to: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, b.zolnierkie@samsung.com, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

This patch disables deprecated IDE subsystem in assabet_defconfig
(no IDE host drivers are selected in this config so there is no
valid reason to enable IDE subsystem itself).

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/assabet_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index 558ecd8..ab19ff1 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -34,7 +34,6 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_SA1100=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=y
-CONFIG_IDE=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_PCMCIA=y
-- 
1.9.1

