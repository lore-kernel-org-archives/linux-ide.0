From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFT PATCH] ia64: zx1_defconfig: convert to use libata PATA drivers
Date: Mon, 17 Aug 2015 17:46:28 +0200
Message-ID: <1439826388-31456-5-git-send-email-b.zolnierkie@samsung.com>
References: <1439826388-31456-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1439826388-31456-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
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

This patch converts zx1_defconfig to use libata PATA
drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/ia64/configs/zx1_defconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/configs/zx1_defconfig b/arch/ia64/configs/zx1_defconfig
index b504c8e..1ecda7e 100644
--- a/arch/ia64/configs/zx1_defconfig
+++ b/arch/ia64/configs/zx1_defconfig
@@ -27,11 +27,6 @@ CONFIG_IP_MULTICAST=y
 CONFIG_NETFILTER=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_CMD64X=y
-CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=y
 CONFIG_CHR_DEV_OSST=y
@@ -43,6 +38,9 @@ CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_SYM53C8XX_2=y
 CONFIG_SCSI_QLOGIC_1280=y
+CONFIG_ATA=y
+CONFIG_PATA_CMD64X=y
+CONFIG_ATA_GENERIC=y
 CONFIG_FUSION=y
 CONFIG_FUSION_SPI=y
 CONFIG_FUSION_FC=y
-- 
1.9.1
