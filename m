From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/12] ide: remove CONFIG_IDEDMA_IVB config option
Date: Sun, 29 Jul 2007 19:50:13 +0200
Message-ID: <200707291950.14039.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:59697 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765058AbXG2SFP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:15 -0400
Received: by ug-out-1314.google.com with SMTP id j3so945455ugf
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Devices which don't set word 93 validation bit should be now handled by
ide-iops.c::ivb_list[] and for debugging purposes cable detection can be
completely overriden with "idex=ata66" parameter.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig    |   16 ----------------
 drivers/ide/ide-iops.c |    4 ----
 2 files changed, 20 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -1065,22 +1065,6 @@ endif
 config BLK_DEV_IDEDMA
 	def_bool BLK_DEV_IDEDMA_PCI || BLK_DEV_IDEDMA_PMAC || BLK_DEV_IDEDMA_ICS || BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
 
-config IDEDMA_IVB
-	bool "IGNORE word93 Validation BITS"
-	depends on BLK_DEV_IDEDMA_PCI || BLK_DEV_IDEDMA_PMAC || BLK_DEV_IDEDMA_ICS
-	---help---
-	  There are unclear terms in ATA-4 and ATA-5 standards how certain
-	  hardware (an 80c ribbon) should be detected. Different interpretations
-	  of the standards have been released in hardware. This causes problems:
-	  for example, a host with Ultra Mode 4 (or higher) will not run
-	  in that mode with an 80c ribbon.
-
-	  If you are experiencing compatibility or performance problems, you
-	  MAY try to answer Y here. However, it does not necessarily solve
-	  any of your problems, it could even cause more of them.
-
-	  It is normally safe to answer Y; however, the default is N.
-
 endif
 
 config BLK_DEV_HD_ONLY
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -615,11 +615,7 @@ u8 eighty_ninty_three (ide_drive_t *driv
 	 * - force bit13 (80c cable present) check also for !ivb devices
 	 *   (unless the slave device is pre-ATA3)
 	 */
-#ifndef CONFIG_IDEDMA_IVB
 	if ((id->hw_config & 0x4000) || (ivb && (id->hw_config & 0x2000)))
-#else
-	if (id->hw_config & 0x6000)
-#endif
 		return 1;
 
 no_80w:
