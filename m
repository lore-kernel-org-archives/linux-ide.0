From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] Fix PDC202XX_FORCE kconfig selection
Date: Sat, 14 Jan 2006 16:21:19 +0100
Message-ID: <20060114152119.GN29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964778AbWANPVW@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Andrey J. Melnikoff" <temnota@kmv.ru>
List-Id: linux-ide@vger.kernel.org

Split PDC202XX_FORCE selection into two independ option and allow user
select it only for specific driver.


Signed-off-by: Andrey Melnikov <temnota@kmv.ru>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Andrey J. Melnikoff on:
- 28 Dec 2005

 drivers/ide/Kconfig            |    9 +++++++--
 drivers/ide/pci/pdc202xx_new.c |    4 ++--
 drivers/ide/pci/pdc202xx_old.c |   10 +++++-----
 3 files changed, 14 insertions(+), 9 deletions(-)

--- linux/drivers/ide/Kconfig~	2005-12-28 21:51:52.000000000 +0300
+++ linux/drivers/ide/Kconfig	2005-12-28 21:51:52.000000000 +0300
@@ -670,11 +670,16 @@
 
 	  If unsure, say N.
 
+config PDC202XX_OLD_FORCE
+	bool "Enable controller even if disabled by BIOS"
+	depends on BLK_DEV_PDC202XX_OLD
+	help
+	  Enable the PDC202xx controller even if it has been disabled in the BIOS setup.
+
 config BLK_DEV_PDC202XX_NEW
 	tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"
 
-# FIXME - probably wants to be one for old and for new
-config PDC202XX_FORCE
+config PDC202XX_NEW_FORCE
 	bool "Enable controller even if disabled by BIOS"
 	depends on BLK_DEV_PDC202XX_NEW
 	help
--- linux/drivers/ide/pci/pdc202xx_new.c~	2005-12-28 21:52:32.000000000 +0300
+++ linux/drivers/ide/pci/pdc202xx_new.c	2005-12-28 21:52:32.000000000 +0300
@@ -420,7 +420,7 @@
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_NEW_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -447,7 +447,7 @@
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_NEW_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
--- linux/drivers/ide/pci/pdc202xx_old.c~	2005-12-28 21:53:26.000000000 +0300
+++ linux/drivers/ide/pci/pdc202xx_old.c	2005-12-28 21:53:26.000000000 +0300
@@ -786,7 +786,7 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_OLD_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -799,7 +799,7 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_OLD_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -813,7 +813,7 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_OLD_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -826,7 +826,7 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_OLD_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
@@ -840,7 +840,7 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
+#ifndef CONFIG_PDC202XX_OLD_FORCE
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 #endif
 		.bootable	= OFF_BOARD,
