From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] powerpc: disable IDE subsystem in pq2fads_defconfig
Date: Wed, 03 Feb 2016 16:50:28 +0100
Message-ID: <1454514630-29269-22-git-send-email-b.zolnierkie@samsung.com>
References: <1454514630-29269-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1454514630-29269-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org

This patch disables deprecated IDE subsystem in pq2fads_defconfig
(no IDE host drivers are selected in this config so there is no valid
reason to enable IDE subsystem itself).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/powerpc/configs/pq2fads_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/pq2fads_defconfig b/arch/powerpc/configs/pq2fads_defconfig
index 3e336ee..1e77d45 100644
--- a/arch/powerpc/configs/pq2fads_defconfig
+++ b/arch/powerpc/configs/pq2fads_defconfig
@@ -40,7 +40,6 @@ CONFIG_MTD_CFI_I4=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_IDE=y
 CONFIG_NETDEVICES=y
 CONFIG_TUN=y
 CONFIG_FS_ENET=y
-- 
1.9.1
