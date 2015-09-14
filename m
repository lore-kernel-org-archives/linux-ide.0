From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFT PATCH] mips: maltaaprp_defconfig: convert to use libata PATA
 drivers
Date: Mon, 14 Sep 2015 17:51:52 +0200
Message-ID: <1442245918-27631-11-git-send-email-b.zolnierkie@samsung.com>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44675 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831AbbINPyA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Sep 2015 11:54:00 -0400
In-reply-to: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Paul Burton <paul.burton@imgtec.com>, Markos Chandras <markos.chandras@imgtec.com>, "Steven J. Hill" <Steven.Hill@imgtec.com>

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

This patch converts maltaaprp_defconfig to use libata PATA
drivers.

Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/mips/configs/maltaaprp_defconfig | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index fb042ce..a9d433a 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -81,15 +81,14 @@ CONFIG_NET_CLS_IND=y
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
-CONFIG_IDE=y
-# CONFIG_IDE_PROC_FS is not set
-# CONFIG_IDEPCI_PCIBUS_ORDER is not set
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_PIIX=y
-CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 # CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+CONFIG_ATA_PIIX=y
+CONFIG_PATA_OLDPIIX=y
+CONFIG_PATA_MPIIX=y
+CONFIG_ATA_GENERIC=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_3COM is not set
 # CONFIG_NET_VENDOR_ADAPTEC is not set
-- 
1.9.1

