From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RESEND PATCH] arm: cerfcube_defconfig: disable IDE subsystem
Date: Fri, 08 Jul 2016 17:24:43 +0200
Message-ID: <1467991490-24895-3-git-send-email-b.zolnierkie@samsung.com>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58925 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755025AbcGHP0K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jul 2016 11:26:10 -0400
In-reply-to: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, b.zolnierkie@samsung.com, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

This patch disables deprecated IDE subsystem in cerfcube_defconfig
(no IDE host drivers are selected in this config so there is no
valid reason to enable IDE subsystem itself).

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/configs/cerfcube_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/cerfcube_defconfig b/arch/arm/configs/cerfcube_defconfig
index dce912d..57a2a18 100644
--- a/arch/arm/configs/cerfcube_defconfig
+++ b/arch/arm/configs/cerfcube_defconfig
@@ -39,7 +39,6 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_SA1100=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_RAM=m
-CONFIG_IDE=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_PCI=y
-- 
1.9.1

