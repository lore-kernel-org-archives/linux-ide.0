From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFT PATCH] mips: maltaup_xpa_defconfig: convert to use libata PATA
 drivers
Date: Mon, 14 Sep 2015 17:51:55 +0200
Message-ID: <1442245918-27631-14-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Paul Burton <paul.burton@imgtec.com>, Markos Chandras <markos.chandras@imgtec.com>, "Steven J. Hill" <Steven.Hill@imgtec.com>
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

This patch converts maltaup_xpa_defconfig to use libata PATA
drivers (tc86c001 IDE host driver has no corresponding libata
driver yet so it is not converted).

Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

BTW Does this platform really use tc86c001 chipset or has
this defconfig been derived from the one already using
tc86c001 driver?

 arch/mips/configs/maltaup_xpa_defconfig | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index c388bff..7322157 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -244,17 +244,12 @@ CONFIG_CDROM_PKTCDVD=m
 CONFIG_ATA_OVER_ETH=m
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECD=y
-CONFIG_IDE_GENERIC=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_PIIX=y
-CONFIG_BLK_DEV_IT8213=m
 CONFIG_BLK_DEV_TC86C001=m
 CONFIG_RAID_ATTRS=m
-CONFIG_SCSI=m
-CONFIG_BLK_DEV_SD=m
+CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
 CONFIG_CHR_DEV_OSST=m
-CONFIG_BLK_DEV_SR=m
+CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_CONSTANTS=y
@@ -269,6 +264,13 @@ CONFIG_SCSI_AACRAID=m
 CONFIG_SCSI_AIC7XXX=m
 CONFIG_AIC7XXX_RESET_DELAY_MS=15000
 # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
+CONFIG_ATA=y
+CONFIG_ATA_PIIX=y
+CONFIG_PATA_IT8213=m
+CONFIG_PATA_OLDPIIX=y
+CONFIG_PATA_MPIIX=y
+CONFIG_ATA_GENERIC=y
+CONFIG_PATA_LEGACY=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=m
 CONFIG_MD_LINEAR=m
-- 
1.9.1
