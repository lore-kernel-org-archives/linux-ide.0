From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] remove dead CONFIG_IDEDMA_NEW_DRIVE_LISTINGS
Date: Wed, 4 Feb 2004 02:35:09 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402040235.09215.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56029 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266209AbUBDBbl
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Feb 2004 20:31:41 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


[PATCH] remove dead CONFIG_IDEDMA_NEW_DRIVE_LISTINGS

Leftover after switch to IDE DMA Model-Firmware blacklist in kernel 2.5.63.

 linux-2.6.2-rc3-bk3-root/arch/arm/configs/footbridge_defconfig |    1 
 linux-2.6.2-rc3-bk3-root/drivers/ide/Kconfig                   |   11 ----------
 2 files changed, 12 deletions(-)

diff -puN arch/arm/configs/footbridge_defconfig~CONFIG_IDEDMA_NEW_DRIVE_LISTINGS_cleanup arch/arm/configs/footbridge_defconfig
--- linux-2.6.2-rc3-bk3/arch/arm/configs/footbridge_defconfig~CONFIG_IDEDMA_NEW_DRIVE_LISTINGS_cleanup	2004-02-04 01:21:44.930307560 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/arm/configs/footbridge_defconfig	2004-02-04 01:21:59.000000000 +0100
@@ -399,7 +399,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 CONFIG_BLK_DEV_OFFBOARD=y
 CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_BLK_DEV_IDEDMA=y
-# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_AEC62XX_TUNING is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -puN drivers/ide/Kconfig~CONFIG_IDEDMA_NEW_DRIVE_LISTINGS_cleanup drivers/ide/Kconfig
--- linux-2.6.2-rc3-bk3/drivers/ide/Kconfig~CONFIG_IDEDMA_NEW_DRIVE_LISTINGS_cleanup	2004-02-04 01:17:57.000000000 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/Kconfig	2004-02-04 01:18:40.000000000 +0100
@@ -521,17 +521,6 @@ config IDEDMA_PCI_WIP
 
 	  It is SAFEST to say N to this question.
 
-config IDEDMA_NEW_DRIVE_LISTINGS
-	bool "Good-Bad DMA Model-Firmware (WIP)"
-	depends on IDEDMA_PCI_WIP
-	help
-	  If you say Y here, the model and firmware revision of your drive
-	  will be compared against a blacklist of buggy drives that claim to
-	  be (U)DMA capable but aren't. This is a blanket on/off test with no
-	  speed limit options.
-
-	  If in doubt, say N.
-
 config BLK_DEV_ADMA
 	bool
 	depends on PCI && BLK_DEV_IDEPCI

_

