From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFT PATCH] mips: capcella_defconfig: convert to use libata PATA
 drivers
Date: Mon, 14 Sep 2015 17:51:43 +0200
Message-ID: <1442245918-27631-2-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
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

This patch converts capcella_defconfig to use libata PATA
drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/capcella_defconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/configs/capcella_defconfig b/arch/mips/configs/capcella_defconfig
index 5135dc0..2924ba3 100644
--- a/arch/mips/configs/capcella_defconfig
+++ b/arch/mips/configs/capcella_defconfig
@@ -31,9 +31,9 @@ CONFIG_NETWORK_SECMARK=y
 CONFIG_IP_SCTP=m
 CONFIG_FW_LOADER=m
 CONFIG_BLK_DEV_RAM=y
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
 CONFIG_PHYLIB=m
 CONFIG_MARVELL_PHY=m
-- 
1.9.1
