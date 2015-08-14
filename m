From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFT PATCH] arm: spitz_defconfig: convert to use libata PATA drivers
Date: Fri, 14 Aug 2015 19:04:35 +0200
Message-ID: <1439571876-13758-20-git-send-email-b.zolnierkie@samsung.com>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, b.zolnierkie@samsung.com, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
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

This patch converts spitz_defconfig to use libata PATA
drivers.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/arm/configs/spitz_defconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index a1ede19..d8c5293 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -96,15 +96,13 @@ CONFIG_MTD_COMPLEX_MAPPINGS=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_SHARPSL=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECS=y
-CONFIG_SCSI=m
-CONFIG_BLK_DEV_SD=m
+CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_CHR_DEV_OSST=m
 CONFIG_BLK_DEV_SR=m
 CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_MULTI_LUN=y
+CONFIG_ATA=y
+CONFIG_PATA_PCMCIA=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_USB_CATC=m
-- 
1.9.1
