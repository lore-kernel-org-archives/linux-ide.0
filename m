From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] trivial IDE cleanups for 2.6.5-rc2-bk3 (2/4)
Date: Tue, 23 Mar 2004 19:40:11 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403231940.11978.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64430 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262796AbUCWSdD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Mar 2004 13:33:03 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


[IDE] remove unused CONFIG_BLK_DEV_TIVO

TiVo IDE support was never merged only this option was (in 2.4.0-test2), sigh.

 linux-2.6.5-rc2-bk3-root/arch/sh/configs/defconfig-adx    |    1 -
 linux-2.6.5-rc2-bk3-root/arch/sh/configs/defconfig-cqreek |    1 -
 linux-2.6.5-rc2-bk3-root/drivers/ide/Kconfig              |    3 ---
 3 files changed, 5 deletions(-)

diff -puN arch/sh/configs/defconfig-adx~ide_blk_dev_tivo arch/sh/configs/defconfig-adx
--- linux-2.6.5-rc2-bk3/arch/sh/configs/defconfig-adx~ide_blk_dev_tivo	2004-03-23 19:18:41.313684248 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/sh/configs/defconfig-adx	2004-03-23 19:18:41.324682576 +0100
@@ -135,7 +135,6 @@ CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
 # CONFIG_BLK_DEV_IDEDISK_WD is not set
 # CONFIG_BLK_DEV_COMMERIAL is not set
-# CONFIG_BLK_DEV_TIVO is not set
 # CONFIG_BLK_DEV_IDECS is not set
 # CONFIG_BLK_DEV_IDECD is not set
 # CONFIG_BLK_DEV_IDETAPE is not set
diff -puN arch/sh/configs/defconfig-cqreek~ide_blk_dev_tivo arch/sh/configs/defconfig-cqreek
--- linux-2.6.5-rc2-bk3/arch/sh/configs/defconfig-cqreek~ide_blk_dev_tivo	2004-03-23 19:18:41.317683640 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/sh/configs/defconfig-cqreek	2004-03-23 19:18:41.325682424 +0100
@@ -133,7 +133,6 @@ CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
 # CONFIG_BLK_DEV_IDEDISK_WD is not set
 # CONFIG_BLK_DEV_COMMERIAL is not set
-# CONFIG_BLK_DEV_TIVO is not set
 # CONFIG_BLK_DEV_IDECS is not set
 # CONFIG_BLK_DEV_IDECD is not set
 # CONFIG_BLK_DEV_IDETAPE is not set
diff -puN drivers/ide/Kconfig~ide_blk_dev_tivo drivers/ide/Kconfig
--- linux-2.6.5-rc2-bk3/drivers/ide/Kconfig~ide_blk_dev_tivo	2004-03-23 19:18:41.321683032 +0100
+++ linux-2.6.5-rc2-bk3-root/drivers/ide/Kconfig	2004-03-23 19:18:41.326682272 +0100
@@ -1114,9 +1114,6 @@ config IDEDMA_IVB
 config IDEDMA_AUTO
 	def_bool IDEDMA_PCI_AUTO || BLK_DEV_IDEDMA_PMAC_AUTO || IDEDMA_ICS_AUTO
 
-config DMA_NONPCI
-	def_bool BLK_DEV_TIVO
-
 endif
 
 config BLK_DEV_HD_ONLY

_

