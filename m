From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] always enable CONFIG_PDC202XX_FORCE
Date: Sun, 22 Jan 2006 18:12:39 +0100
Message-ID: <20060122171239.GD10003@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38927 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932107AbWAVRMi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jan 2006 12:12:38 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

This patch removes the CONFIG_PDC202XX_FORCE=n case.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 14 Jan 2006

 drivers/ide/Kconfig            |    7 -------
 drivers/ide/pci/pdc202xx_new.c |    6 ------
 drivers/ide/pci/pdc202xx_old.c |   15 ---------------
 3 files changed, 28 deletions(-)

--- linux-2.6.15-mm4-full/drivers/ide/Kconfig.old	2006-01-14 20:43:13.000000000 +0100
+++ linux-2.6.15-mm4-full/drivers/ide/Kconfig	2006-01-14 20:43:23.000000000 +0100
@@ -673,13 +673,6 @@
 config BLK_DEV_PDC202XX_NEW
 	tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"
 
-# FIXME - probably wants to be one for old and for new
-config PDC202XX_FORCE
-	bool "Enable controller even if disabled by BIOS"
-	depends on BLK_DEV_PDC202XX_NEW
-	help
-	  Enable the PDC202xx controller even if it has been disabled in the BIOS setup.
-
 config BLK_DEV_SVWKS
 	tristate "ServerWorks OSB4/CSB5/CSB6 chipsets support"
 	help
--- linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_new.c.old	2006-01-14 20:43:30.000000000 +0100
+++ linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_new.c	2006-01-14 20:43:51.000000000 +0100
@@ -420,9 +420,6 @@
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 	},{	/* 3 */
 		.name		= "PDC20271",
@@ -447,9 +444,6 @@
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 	},{	/* 6 */
 		.name		= "PDC20277",
--- linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_old.c.old	2006-01-14 20:44:01.000000000 +0100
+++ linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_old.c	2006-01-14 20:44:21.000000000 +0100
@@ -786,9 +786,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 16,
 	},{	/* 1 */
@@ -799,9 +796,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
 		.flags		= IDEPCI_FLAG_FORCE_PDC,
@@ -813,9 +807,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
 	},{	/* 3 */
@@ -826,9 +817,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
 		.flags		= IDEPCI_FLAG_FORCE_PDC,
@@ -840,9 +828,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
 	}

