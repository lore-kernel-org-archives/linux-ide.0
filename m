From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFT PATCH] powerpc/86xx: convert gef_ppc9a_defconfig to use libata
 PATA drivers
Date: Wed, 03 Feb 2016 16:50:15 +0100
Message-ID: <1454514630-29269-9-git-send-email-b.zolnierkie@samsung.com>
References: <1454514630-29269-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1454514630-29269-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
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

This patch converts gef_ppc9a_defconfig to use libata PATA
drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/powerpc/configs/86xx/gef_ppc9a_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
index 9792a2c..ca06080 100644
--- a/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
+++ b/arch/powerpc/configs/86xx/gef_ppc9a_defconfig
@@ -76,13 +76,12 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
 CONFIG_DS1682=y
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECS=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_ATA=y
 CONFIG_SATA_SIL=y
+CONFIG_PATA_PCMCIA=y
 CONFIG_NETDEVICES=y
 CONFIG_BONDING=m
 CONFIG_DUMMY=m
-- 
1.9.1
