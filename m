From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFT PATCH] sh: sdk7780_defconfig: convert to use libata PATA drivers
Date: Fri, 08 Jul 2016 18:43:42 +0200
Message-ID: <1467996225-25498-3-git-send-email-b.zolnierkie@samsung.com>
References: <1467996225-25498-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:39557 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbcGHQpC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jul 2016 12:45:02 -0400
In-reply-to: <1467996225-25498-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
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

This patch converts sdk7780_defconfig to use libata PATA
drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Build tested only.
If you have affected hardware please test.  Thank you.

 arch/sh/configs/sdk7780_defconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sh/configs/sdk7780_defconfig b/arch/sh/configs/sdk7780_defconfig
index bbd4c22..4baa4a7 100644
--- a/arch/sh/configs/sdk7780_defconfig
+++ b/arch/sh/configs/sdk7780_defconfig
@@ -48,16 +48,14 @@ CONFIG_PARPORT=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 # CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_PLATFORM=y
-CONFIG_BLK_DEV_GENERIC=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_SPI_ATTRS=y
 CONFIG_SCSI_FC_ATTRS=y
 CONFIG_ATA=y
+CONFIG_PATA_PLATFORM=y
+CONFIG_ATA_GENERIC=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_DM=y
 CONFIG_NETDEVICES=y
-- 
1.9.1

