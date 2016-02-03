From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFT PATCH] powerpc/85xx: convert tqm8555_defconfig to use libata PATA
 drivers
Date: Wed, 03 Feb 2016 16:50:13 +0100
Message-ID: <1454514630-29269-7-git-send-email-b.zolnierkie@samsung.com>
References: <1454514630-29269-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1454514630-29269-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>
List-Id: linux-ide@vger.kernel.org

IDE subsystem has been deprecated since 2009 and the majority
(if not all) of Linux distributions have switched to use
libata for ATA support exclusively.  However there are still
some users (mostly old or/and embedded non-x86 systems) that
have not converted from using IDE subsystem to libata PATA
drivers.  This doesn't seem to be good thing in the long-term
for Linux as while there is less and less PATA systems left
in use:

* testing efforts are divided between two subsystems

* having duplicate drivers for same hardware confuses users

This patch converts tqm8555_defconfig to use libata PATA
drivers.

Cc: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/powerpc/configs/85xx/tqm8555_defconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/configs/85xx/tqm8555_defconfig b/arch/powerpc/configs/85xx/tqm8555_defconfig
index 02a931d..3d9c1c0d 100644
--- a/arch/powerpc/configs/85xx/tqm8555_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8555_defconfig
@@ -30,9 +30,10 @@ CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
-CONFIG_IDE=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_VIA82CXXX=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_PATA_VIA=y
+CONFIG_ATA_GENERIC=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_E100=y
-- 
1.9.1
