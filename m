From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] powerpc/85xx: disable IDE subsystem in ksi8560_defconfig
Date: Wed, 03 Feb 2016 16:50:08 +0100
Message-ID: <1454514630-29269-2-git-send-email-b.zolnierkie@samsung.com>
References: <1454514630-29269-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1454514630-29269-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>
List-Id: linux-ide@vger.kernel.org

This patch disables deprecated IDE subsystem in ksi8560_defconfig
(no IDE host drivers are selected in this config so there is no valid
reason to enable IDE subsystem itself).

Cc: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/powerpc/configs/85xx/ksi8560_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/85xx/ksi8560_defconfig b/arch/powerpc/configs/85xx/ksi8560_defconfig
index 3be85c5..6f753a7 100644
--- a/arch/powerpc/configs/85xx/ksi8560_defconfig
+++ b/arch/powerpc/configs/85xx/ksi8560_defconfig
@@ -34,7 +34,6 @@ CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
-CONFIG_IDE=y
 CONFIG_NETDEVICES=y
 CONFIG_FS_ENET=y
 # CONFIG_FS_ENET_HAS_SCC is not set
-- 
1.9.1
