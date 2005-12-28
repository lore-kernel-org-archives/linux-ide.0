From: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
Subject: [PATCH] [TRIVIAL] Fix PDC202XX_FORCE kconfig selection
Date: Wed, 28 Dec 2005 22:04:30 +0300
Message-ID: <20051228190430.GL12561@kmv.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TD8GDToEDw0WLGOL"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750789AbVL2QTW@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

Split PDC202XX_FORCE selection into two independ option and allow user 
select it only for specific driver.

Signed-off-by: Andrey Melnikov <temnota@kmv.ru>

---
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


-- 
 Best regards, TEMHOTA-RIPN aka MJA13-RIPE
 System Administrator. mailto:temnota@kmv.ru


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pdc202xx-fix-force-define.diff"

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

--TD8GDToEDw0WLGOL--
