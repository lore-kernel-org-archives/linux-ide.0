From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] mips: sb1250_swarm_defconfig: disable IDE subsystem
Date: Mon, 14 Sep 2015 17:51:57 +0200
Message-ID: <1442245918-27631-16-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

This patch disables deprecated IDE subsystem in sb1250_swarm_defconfig
(no IDE host drivers are selected in this config so there is no valid
reason to enable IDE subsystem itself).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/mips/configs/sb1250_swarm_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index 51bab13..09b1914 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -55,9 +55,6 @@ CONFIG_BLK_DEV_RAM_SIZE=9220
 CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SGI_IOC4=m
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_IDETAPE=y
 CONFIG_RAID_ATTRS=m
 CONFIG_NETDEVICES=y
 CONFIG_MACVLAN=m
-- 
1.9.1
