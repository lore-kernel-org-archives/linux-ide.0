From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] trivial IDE cleanups for 2.6.5-rc2-bk3 (3/4)
Date: Tue, 23 Mar 2004 19:40:26 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403231940.26488.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64430 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262800AbUCWSd1
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Mar 2004 13:33:27 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


[IDE] remove unused CONFIG_DMA_NONPCI

It has been dead since kernel 2.5.18.

 linux-2.6.5-rc2-bk3-root/arch/alpha/defconfig                 |    1 
 linux-2.6.5-rc2-bk3-root/arch/arm/configs/cerfcube_defconfig  |    1 
 linux-2.6.5-rc2-bk3-root/arch/arm/configs/lart_defconfig      |    1 
 linux-2.6.5-rc2-bk3-root/arch/arm/configs/netwinder_defconfig |    1 
 linux-2.6.5-rc2-bk3-root/arch/arm/configs/shark_defconfig     |    1 
 linux-2.6.5-rc2-bk3-root/arch/arm/configs/trizeps_defconfig   |    1 
 linux-2.6.5-rc2-bk3-root/arch/i386/defconfig                  |    1 
 linux-2.6.5-rc2-bk3-root/arch/ia64/configs/generic_defconfig  |    1 
 linux-2.6.5-rc2-bk3-root/arch/ia64/configs/sn2_defconfig      |    1 
 linux-2.6.5-rc2-bk3-root/arch/ia64/configs/zx1_defconfig      |    1 
 linux-2.6.5-rc2-bk3-root/arch/ia64/defconfig                  |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/capcella_defconfig |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/cobalt_defconfig   |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/db1500_defconfig   |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/ddb5476_defconfig  |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/e55_defconfig      |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/eagle_defconfig    |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/hp-lj_defconfig    |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/it8172_defconfig   |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/ivr_defconfig      |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/lasat200_defconfig |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/pb1500_defconfig   |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/tb0226_defconfig   |    1 
 linux-2.6.5-rc2-bk3-root/arch/mips/configs/workpad_defconfig  |    1 
 linux-2.6.5-rc2-bk3-root/arch/parisc/configs/c3000_defconfig  |    1 
 linux-2.6.5-rc2-bk3-root/arch/ppc/configs/common_defconfig    |    1 
 linux-2.6.5-rc2-bk3-root/arch/ppc/configs/cpci405_defconfig   |    1 
 linux-2.6.5-rc2-bk3-root/arch/ppc/configs/pmac_defconfig      |    1 
 linux-2.6.5-rc2-bk3-root/arch/ppc/configs/pplus_defconfig     |    1 
 linux-2.6.5-rc2-bk3-root/arch/ppc/configs/redwood5_defconfig  |    1 
 linux-2.6.5-rc2-bk3-root/arch/ppc/defconfig                   |    1 
 linux-2.6.5-rc2-bk3-root/arch/ppc64/configs/g5_defconfig      |    1 
 linux-2.6.5-rc2-bk3-root/arch/ppc64/configs/pSeries_defconfig |    1 
 linux-2.6.5-rc2-bk3-root/arch/ppc64/defconfig                 |    1 
 linux-2.6.5-rc2-bk3-root/arch/sh/configs/defconfig-adx        |    1 
 linux-2.6.5-rc2-bk3-root/arch/sh/configs/defconfig-cqreek     |    1 
 linux-2.6.5-rc2-bk3-root/arch/sh/configs/defconfig-hp680      |    1 
 linux-2.6.5-rc2-bk3-root/arch/sh/defconfig                    |    1 
 linux-2.6.5-rc2-bk3-root/arch/sparc64/defconfig               |    1 
 linux-2.6.5-rc2-bk3-root/arch/x86_64/defconfig                |    1 
 linux-2.6.5-rc2-bk3-root/drivers/ide/ide-iops.c               |   16 ++++------
 linux-2.6.5-rc2-bk3-root/drivers/ide/ide.c                    |    5 ---
 42 files changed, 8 insertions(+), 53 deletions(-)

diff -puN arch/alpha/defconfig~ide_dma_nonpci arch/alpha/defconfig
--- linux-2.6.5-rc2-bk3/arch/alpha/defconfig~ide_dma_nonpci	2004-03-23 19:24:27.504055312 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/alpha/defconfig	2004-03-23 19:24:34.301022016 +0100
@@ -207,7 +207,6 @@ CONFIG_BLK_DEV_CY82C693=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/arm/configs/cerfcube_defconfig~ide_dma_nonpci arch/arm/configs/cerfcube_defconfig
--- linux-2.6.5-rc2-bk3/arch/arm/configs/cerfcube_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.674021376 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/arm/configs/cerfcube_defconfig	2004-03-23 19:18:45.842995688 +0100
@@ -449,7 +449,6 @@ CONFIG_BLK_DEV_IDECS=m
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/arm/configs/lart_defconfig~ide_dma_nonpci arch/arm/configs/lart_defconfig
--- linux-2.6.5-rc2-bk3/arch/arm/configs/lart_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.679020616 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/arm/configs/lart_defconfig	2004-03-23 19:18:45.843995536 +0100
@@ -470,7 +470,6 @@ CONFIG_BLK_DEV_IDECD=m
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/arm/configs/netwinder_defconfig~ide_dma_nonpci arch/arm/configs/netwinder_defconfig
--- linux-2.6.5-rc2-bk3/arch/arm/configs/netwinder_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.683020008 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/arm/configs/netwinder_defconfig	2004-03-23 19:18:45.844995384 +0100
@@ -464,7 +464,6 @@ CONFIG_BLK_DEV_ADMA=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/arm/configs/shark_defconfig~ide_dma_nonpci arch/arm/configs/shark_defconfig
--- linux-2.6.5-rc2-bk3/arch/arm/configs/shark_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.687019400 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/arm/configs/shark_defconfig	2004-03-23 19:18:45.845995232 +0100
@@ -382,7 +382,6 @@ CONFIG_BLK_DEV_IDEFLOPPY=y
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/arm/configs/trizeps_defconfig~ide_dma_nonpci arch/arm/configs/trizeps_defconfig
--- linux-2.6.5-rc2-bk3/arch/arm/configs/trizeps_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.691018792 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/arm/configs/trizeps_defconfig	2004-03-23 19:18:45.846995080 +0100
@@ -494,7 +494,6 @@ CONFIG_BLK_DEV_IDECS=m
 # CONFIG_BLK_DEV_IDE_RAPIDE is not set
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 
 #
 # SCSI support
diff -puN arch/i386/defconfig~ide_dma_nonpci arch/i386/defconfig
--- linux-2.6.5-rc2-bk3/arch/i386/defconfig~ide_dma_nonpci	2004-03-23 19:18:45.695018184 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/i386/defconfig	2004-03-23 19:18:45.847994928 +0100
@@ -304,7 +304,6 @@ CONFIG_BLK_DEV_PIIX=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ia64/configs/generic_defconfig~ide_dma_nonpci arch/ia64/configs/generic_defconfig
--- linux-2.6.5-rc2-bk3/arch/ia64/configs/generic_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.698017728 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ia64/configs/generic_defconfig	2004-03-23 19:18:45.849994624 +0100
@@ -214,7 +214,6 @@ CONFIG_BLK_DEV_PIIX=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ia64/configs/sn2_defconfig~ide_dma_nonpci arch/ia64/configs/sn2_defconfig
--- linux-2.6.5-rc2-bk3/arch/ia64/configs/sn2_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.702017120 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ia64/configs/sn2_defconfig	2004-03-23 19:18:45.850994472 +0100
@@ -211,7 +211,6 @@ CONFIG_BLK_DEV_SGIIOC4=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ia64/configs/zx1_defconfig~ide_dma_nonpci arch/ia64/configs/zx1_defconfig
--- linux-2.6.5-rc2-bk3/arch/ia64/configs/zx1_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.706016512 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ia64/configs/zx1_defconfig	2004-03-23 19:18:45.854993864 +0100
@@ -211,7 +211,6 @@ CONFIG_BLK_DEV_CMD64X=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ia64/defconfig~ide_dma_nonpci arch/ia64/defconfig
--- linux-2.6.5-rc2-bk3/arch/ia64/defconfig~ide_dma_nonpci	2004-03-23 19:18:45.710015904 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ia64/defconfig	2004-03-23 19:18:45.855993712 +0100
@@ -218,7 +218,6 @@ CONFIG_BLK_DEV_SIIMAGE=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/capcella_defconfig~ide_dma_nonpci arch/mips/configs/capcella_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/capcella_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.715015144 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/capcella_defconfig	2004-03-23 19:18:45.856993560 +0100
@@ -196,7 +196,6 @@ CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEPCI is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/cobalt_defconfig~ide_dma_nonpci arch/mips/configs/cobalt_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/cobalt_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.718014688 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/cobalt_defconfig	2004-03-23 19:18:45.857993408 +0100
@@ -189,7 +189,6 @@ CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEPCI is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/db1500_defconfig~ide_dma_nonpci arch/mips/configs/db1500_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/db1500_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.722014080 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/db1500_defconfig	2004-03-23 19:18:45.858993256 +0100
@@ -268,7 +268,6 @@ CONFIG_BLK_DEV_IDECS=m
 CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/ddb5476_defconfig~ide_dma_nonpci arch/mips/configs/ddb5476_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/ddb5476_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.727013320 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/ddb5476_defconfig	2004-03-23 19:18:45.859993104 +0100
@@ -188,7 +188,6 @@ CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEPCI is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/e55_defconfig~ide_dma_nonpci arch/mips/configs/e55_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/e55_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.731012712 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/e55_defconfig	2004-03-23 19:18:45.860992952 +0100
@@ -188,7 +188,6 @@ CONFIG_IDE_TASKFILE_IO=y
 CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/eagle_defconfig~ide_dma_nonpci arch/mips/configs/eagle_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/eagle_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.735012104 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/eagle_defconfig	2004-03-23 19:18:45.861992800 +0100
@@ -273,7 +273,6 @@ CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEPCI is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/hp-lj_defconfig~ide_dma_nonpci arch/mips/configs/hp-lj_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/hp-lj_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.738011648 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/hp-lj_defconfig	2004-03-23 19:18:45.862992648 +0100
@@ -245,7 +245,6 @@ CONFIG_IDE_TASKFILE_IO=y
 CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/it8172_defconfig~ide_dma_nonpci arch/mips/configs/it8172_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/it8172_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.742011040 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/it8172_defconfig	2004-03-23 19:18:45.865992192 +0100
@@ -243,7 +243,6 @@ CONFIG_IDE_TASKFILE_IO=y
 CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/ivr_defconfig~ide_dma_nonpci arch/mips/configs/ivr_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/ivr_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.746010432 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/ivr_defconfig	2004-03-23 19:18:45.866992040 +0100
@@ -191,7 +191,6 @@ CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEPCI is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/lasat200_defconfig~ide_dma_nonpci arch/mips/configs/lasat200_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/lasat200_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.751009672 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/lasat200_defconfig	2004-03-23 19:18:45.868991736 +0100
@@ -284,7 +284,6 @@ CONFIG_BLK_DEV_CMD64X=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/pb1500_defconfig~ide_dma_nonpci arch/mips/configs/pb1500_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/pb1500_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.756008912 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/pb1500_defconfig	2004-03-23 19:18:45.869991584 +0100
@@ -251,7 +251,6 @@ CONFIG_BLK_DEV_HPT366=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/tb0226_defconfig~ide_dma_nonpci arch/mips/configs/tb0226_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/tb0226_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.760008304 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/tb0226_defconfig	2004-03-23 19:18:45.870991432 +0100
@@ -192,7 +192,6 @@ CONFIG_IDE_TASKFILE_IO=y
 CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/mips/configs/workpad_defconfig~ide_dma_nonpci arch/mips/configs/workpad_defconfig
--- linux-2.6.5-rc2-bk3/arch/mips/configs/workpad_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.764007696 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/mips/configs/workpad_defconfig	2004-03-23 19:18:45.871991280 +0100
@@ -188,7 +188,6 @@ CONFIG_IDE_TASKFILE_IO=y
 CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/parisc/configs/c3000_defconfig~ide_dma_nonpci arch/parisc/configs/c3000_defconfig
--- linux-2.6.5-rc2-bk3/arch/parisc/configs/c3000_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.769006936 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/parisc/configs/c3000_defconfig	2004-03-23 19:18:45.872991128 +0100
@@ -186,7 +186,6 @@ CONFIG_BLK_DEV_SIIMAGE=m
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ppc64/configs/g5_defconfig~ide_dma_nonpci arch/ppc64/configs/g5_defconfig
--- linux-2.6.5-rc2-bk3/arch/ppc64/configs/g5_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.774006176 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ppc64/configs/g5_defconfig	2004-03-23 19:18:45.874990824 +0100
@@ -195,7 +195,6 @@ CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ppc64/configs/pSeries_defconfig~ide_dma_nonpci arch/ppc64/configs/pSeries_defconfig
--- linux-2.6.5-rc2-bk3/arch/ppc64/configs/pSeries_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.778005568 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ppc64/configs/pSeries_defconfig	2004-03-23 19:18:45.875990672 +0100
@@ -197,7 +197,6 @@ CONFIG_BLK_DEV_AMD74XX=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ppc64/defconfig~ide_dma_nonpci arch/ppc64/defconfig
--- linux-2.6.5-rc2-bk3/arch/ppc64/defconfig~ide_dma_nonpci	2004-03-23 19:18:45.782004960 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ppc64/defconfig	2004-03-23 19:18:45.876990520 +0100
@@ -197,7 +197,6 @@ CONFIG_BLK_DEV_AMD74XX=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ppc/configs/common_defconfig~ide_dma_nonpci arch/ppc/configs/common_defconfig
--- linux-2.6.5-rc2-bk3/arch/ppc/configs/common_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.786004352 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ppc/configs/common_defconfig	2004-03-23 19:18:45.877990368 +0100
@@ -241,7 +241,6 @@ CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ppc/configs/cpci405_defconfig~ide_dma_nonpci arch/ppc/configs/cpci405_defconfig
--- linux-2.6.5-rc2-bk3/arch/ppc/configs/cpci405_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.789003896 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ppc/configs/cpci405_defconfig	2004-03-23 19:18:45.878990216 +0100
@@ -177,7 +177,6 @@ CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_BLK_DEV_IDEPCI is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ppc/configs/pmac_defconfig~ide_dma_nonpci arch/ppc/configs/pmac_defconfig
--- linux-2.6.5-rc2-bk3/arch/ppc/configs/pmac_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.794003136 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ppc/configs/pmac_defconfig	2004-03-23 19:18:45.880989912 +0100
@@ -247,7 +247,6 @@ CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ppc/configs/pplus_defconfig~ide_dma_nonpci arch/ppc/configs/pplus_defconfig
--- linux-2.6.5-rc2-bk3/arch/ppc/configs/pplus_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.798002528 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ppc/configs/pplus_defconfig	2004-03-23 19:18:45.881989760 +0100
@@ -180,7 +180,6 @@ CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEPCI is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ppc/configs/redwood5_defconfig~ide_dma_nonpci arch/ppc/configs/redwood5_defconfig
--- linux-2.6.5-rc2-bk3/arch/ppc/configs/redwood5_defconfig~ide_dma_nonpci	2004-03-23 19:18:45.802001920 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ppc/configs/redwood5_defconfig	2004-03-23 19:18:45.881989760 +0100
@@ -173,7 +173,6 @@ CONFIG_BLK_DEV_IDEDISK=y
 #
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/ppc/defconfig~ide_dma_nonpci arch/ppc/defconfig
--- linux-2.6.5-rc2-bk3/arch/ppc/defconfig~ide_dma_nonpci	2004-03-23 19:18:45.806001312 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/ppc/defconfig	2004-03-23 19:18:45.883989456 +0100
@@ -248,7 +248,6 @@ CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/sh/configs/defconfig-adx~ide_dma_nonpci arch/sh/configs/defconfig-adx
--- linux-2.6.5-rc2-bk3/arch/sh/configs/defconfig-adx~ide_dma_nonpci	2004-03-23 19:18:45.810000704 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/sh/configs/defconfig-adx	2004-03-23 19:18:45.883989456 +0100
@@ -145,7 +145,6 @@ CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_BLK_DEV_ISAPNP is not set
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
diff -puN arch/sh/configs/defconfig-cqreek~ide_dma_nonpci arch/sh/configs/defconfig-cqreek
--- linux-2.6.5-rc2-bk3/arch/sh/configs/defconfig-cqreek~ide_dma_nonpci	2004-03-23 19:18:45.814000096 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/sh/configs/defconfig-cqreek	2004-03-23 19:18:45.884989304 +0100
@@ -143,7 +143,6 @@ CONFIG_BLK_DEV_IDEDISK=y
 # CONFIG_BLK_DEV_ISAPNP is not set
 # CONFIG_IDE_CHIPSETS is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_ATARAID is not set
 # CONFIG_BLK_DEV_ATARAID_PDC is not set
 # CONFIG_BLK_DEV_ATARAID_HPT is not set
diff -puN arch/sh/configs/defconfig-hp680~ide_dma_nonpci arch/sh/configs/defconfig-hp680
--- linux-2.6.5-rc2-bk3/arch/sh/configs/defconfig-hp680~ide_dma_nonpci	2004-03-23 19:18:45.817999488 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/sh/configs/defconfig-hp680	2004-03-23 19:18:45.885989152 +0100
@@ -157,7 +157,6 @@ CONFIG_BLK_DEV_IDEDISK=y
 #
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/sh/defconfig~ide_dma_nonpci arch/sh/defconfig
--- linux-2.6.5-rc2-bk3/arch/sh/defconfig~ide_dma_nonpci	2004-03-23 19:18:45.821998880 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/sh/defconfig	2004-03-23 19:18:45.886989000 +0100
@@ -152,7 +152,6 @@ CONFIG_BLK_DEV_IDEDISK=y
 CONFIG_IDE_GENERIC=y
 # CONFIG_BLK_DEV_IDEDMA is not set
 # CONFIG_IDEDMA_AUTO is not set
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/sparc64/defconfig~ide_dma_nonpci arch/sparc64/defconfig
--- linux-2.6.5-rc2-bk3/arch/sparc64/defconfig~ide_dma_nonpci	2004-03-23 19:18:45.825998272 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/sparc64/defconfig	2004-03-23 19:18:45.888988696 +0100
@@ -277,7 +277,6 @@ CONFIG_BLK_DEV_VIA82CXXX=m
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN arch/x86_64/defconfig~ide_dma_nonpci arch/x86_64/defconfig
--- linux-2.6.5-rc2-bk3/arch/x86_64/defconfig~ide_dma_nonpci	2004-03-23 19:18:45.829997664 +0100
+++ linux-2.6.5-rc2-bk3-root/arch/x86_64/defconfig	2004-03-23 19:18:45.891988240 +0100
@@ -235,7 +235,6 @@ CONFIG_BLK_DEV_PIIX=y
 CONFIG_BLK_DEV_IDEDMA=y
 # CONFIG_IDEDMA_IVB is not set
 CONFIG_IDEDMA_AUTO=y
-# CONFIG_DMA_NONPCI is not set
 # CONFIG_BLK_DEV_HD is not set
 
 #
diff -puN drivers/ide/ide.c~ide_dma_nonpci drivers/ide/ide.c
--- linux-2.6.5-rc2-bk3/drivers/ide/ide.c~ide_dma_nonpci	2004-03-23 19:18:45.833997056 +0100
+++ linux-2.6.5-rc2-bk3-root/drivers/ide/ide.c	2004-03-23 19:18:45.893987936 +0100
@@ -737,7 +737,6 @@ void ide_unregister (unsigned int index)
 	unregister_blkdev(hwif->major, hwif->name);
 	spin_lock_irq(&ide_lock);
 
-#if !defined(CONFIG_DMA_NONPCI)
 	if (hwif->dma_base) {
 		(void) ide_release_dma(hwif);
 
@@ -749,7 +748,7 @@ void ide_unregister (unsigned int index)
 		hwif->dma_vendor3 = 0;
 		hwif->dma_prdtable = 0;
 	}
-#endif /* !(CONFIG_DMA_NONPCI) */
+
 	old_hwif			= *hwif;
 	init_hwif_data(index);	/* restore hwif data to pristine status */
 	hwif->hwgroup			= old_hwif.hwgroup;
@@ -2424,10 +2423,8 @@ void cleanup_module (void)
 
 	for (index = 0; index < MAX_HWIFS; ++index) {
 		ide_unregister(index);
-#if !defined(CONFIG_DMA_NONPCI)
 		if (ide_hwifs[index].dma_base)
 			(void) ide_release_dma(&ide_hwifs[index]);
-#endif /* !(CONFIG_DMA_NONPCI) */
 	}
 
 #ifdef CONFIG_PROC_FS
diff -puN drivers/ide/ide-iops.c~ide_dma_nonpci drivers/ide/ide-iops.c
--- linux-2.6.5-rc2-bk3/drivers/ide/ide-iops.c~ide_dma_nonpci	2004-03-23 19:18:45.837996448 +0100
+++ linux-2.6.5-rc2-bk3-root/drivers/ide/ide-iops.c	2004-03-23 19:18:45.895987632 +0100
@@ -829,10 +829,10 @@ int ide_config_drive_speed (ide_drive_t 
 //	while (HWGROUP(drive)->busy)
 //		ide_delay_50ms();
 
-#if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
+#ifdef CONFIG_BLK_DEV_IDEDMA
 	if (hwif->ide_dma_check)	 /* check if host supports DMA */
 		hwif->ide_dma_host_off(drive);
-#endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
+#endif
 
 	/*
 	 * Don't use ide_wait_cmd here - it will
@@ -906,14 +906,12 @@ int ide_config_drive_speed (ide_drive_t 
 	drive->id->dma_mword &= ~0x0F00;
 	drive->id->dma_1word &= ~0x0F00;
 
-#if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
-	if (speed >= XFER_SW_DMA_0) {
+#ifdef CONFIG_BLK_DEV_IDEDMA
+	if (speed >= XFER_SW_DMA_0)
 		hwif->ide_dma_host_on(drive);
-	} else {
-		if (hwif->ide_dma_check) /* check if host supports DMA */
-			hwif->ide_dma_off_quietly(drive);
-	}
-#endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
+	else if (hwif->ide_dma_check)	/* check if host supports DMA */
+		hwif->ide_dma_off_quietly(drive);
+#endif
 
 	switch(speed) {
 		case XFER_UDMA_7:   drive->id->dma_ultra |= 0x8080; break;

_

