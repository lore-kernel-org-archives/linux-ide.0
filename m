From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFT PATCH] mips: bigsur_defconfig: convert to use libata PATA drivers
Date: Mon, 14 Sep 2015 17:51:42 +0200
Message-ID: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49347 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbbINPwS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Sep 2015 11:52:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

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

This patch converts bigsur_defconfig to use libata PATA
drivers (tc86c001 IDE host driver has no corresponding libata
driver yet so it is not converted).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/bigsur_defconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 1cdff6b..b3e7a1b 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -122,20 +122,20 @@ CONFIG_EEPROM_MAX6875=y
 CONFIG_IDE=y
 CONFIG_BLK_DEV_IDECD=y
 CONFIG_BLK_DEV_IDETAPE=y
-CONFIG_IDE_GENERIC=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_CMD64X=y
-CONFIG_BLK_DEV_IT8213=m
 CONFIG_BLK_DEV_TC86C001=m
 CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_ST=m
-CONFIG_BLK_DEV_SR=m
+CONFIG_CHR_DEV_ST=y
+CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=m
 CONFIG_CHR_DEV_SCH=m
 CONFIG_ATA=y
 CONFIG_SATA_SIL24=y
+CONFIG_PATA_CMD64X=y
+CONFIG_PATA_IT8213=m
 CONFIG_PATA_SIL680=y
+CONFIG_ATA_GENERIC=y
+CONFIG_PATA_LEGACY=y
 CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-- 
1.9.1

