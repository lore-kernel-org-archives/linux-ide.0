From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] remove ide_hwif_t->initializing
Date: Tue, 16 Mar 2004 23:21:41 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403162321.41917.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56518 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261748AbUCPWOM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Mar 2004 17:14:12 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


[IDE] remove ide_hwif_t->initializing

 linux-2.6.5-rc1-root/drivers/ide/ide-probe.c        |    2 --
 linux-2.6.5-rc1-root/drivers/ide/ide.c              |    1 -
 linux-2.6.5-rc1-root/drivers/ide/pci/pdc202xx_new.c |    4 ----
 linux-2.6.5-rc1-root/drivers/ide/pci/pdc202xx_old.c |    4 ----
 linux-2.6.5-rc1-root/include/linux/ide.h            |    1 -
 5 files changed, 12 deletions(-)

diff -puN drivers/ide/ide.c~ide_initializing drivers/ide/ide.c
--- linux-2.6.5-rc1/drivers/ide/ide.c~ide_initializing	2004-03-16 23:12:27.976895432 +0100
+++ linux-2.6.5-rc1-root/drivers/ide/ide.c	2004-03-16 23:12:27.999891936 +0100
@@ -851,7 +851,6 @@ void ide_unregister (unsigned int index)
 #ifndef CONFIG_BLK_DEV_IDECS
 	hwif->irq			= old_hwif.irq;
 #endif /* CONFIG_BLK_DEV_IDECS */
-	hwif->initializing		= old_hwif.initializing;
 
 	hwif->dma_base			= old_hwif.dma_base;
 	hwif->dma_master		= old_hwif.dma_master;
diff -puN drivers/ide/ide-probe.c~ide_initializing drivers/ide/ide-probe.c
--- linux-2.6.5-rc1/drivers/ide/ide-probe.c~ide_initializing	2004-03-16 23:12:27.981894672 +0100
+++ linux-2.6.5-rc1-root/drivers/ide/ide-probe.c	2004-03-16 23:12:28.000891784 +0100
@@ -844,7 +844,6 @@ EXPORT_SYMBOL(probe_hwif);
 int hwif_init (ide_hwif_t *hwif);
 int probe_hwif_init (ide_hwif_t *hwif)
 {
-	hwif->initializing = 1;
 	probe_hwif(hwif);
 	hwif_init(hwif);
 
@@ -860,7 +859,6 @@ int probe_hwif_init (ide_hwif_t *hwif)
 			}
 		}
 	}
-	hwif->initializing = 0;
 	return 0;
 }
 
diff -puN drivers/ide/pci/pdc202xx_new.c~ide_initializing drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.5-rc1/drivers/ide/pci/pdc202xx_new.c~ide_initializing	2004-03-16 23:12:27.985894064 +0100
+++ linux-2.6.5-rc1-root/drivers/ide/pci/pdc202xx_new.c	2004-03-16 23:12:28.002891480 +0100
@@ -339,7 +339,6 @@ void pdcnew_reset (ide_drive_t *drive)
 	 */
 	if (hwif->present) {
 		u16 hunit = 0;
-		hwif->initializing = 1;
 		for (hunit = 0; hunit < MAX_DRIVES; ++hunit) {
 			ide_drive_t *hdrive = &hwif->drives[hunit];
 			if (hdrive->present) {
@@ -349,11 +348,9 @@ void pdcnew_reset (ide_drive_t *drive)
 					hwif->tuneproc(hdrive, 5);
 			}
 		}
-		hwif->initializing = 0;
 	}
 	if (mate->present) {
 		u16 munit = 0;
-		mate->initializing = 1;
 		for (munit = 0; munit < MAX_DRIVES; ++munit) {
 			ide_drive_t *mdrive = &mate->drives[munit];
 			if (mdrive->present) {
@@ -363,7 +360,6 @@ void pdcnew_reset (ide_drive_t *drive)
 					mate->tuneproc(mdrive, 5);
 			}
 		}
-		mate->initializing = 0;
 	}
 #else
 	hwif->tuneproc(drive, 5);
diff -puN drivers/ide/pci/pdc202xx_old.c~ide_initializing drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.5-rc1/drivers/ide/pci/pdc202xx_old.c~ide_initializing	2004-03-16 23:12:27.989893456 +0100
+++ linux-2.6.5-rc1-root/drivers/ide/pci/pdc202xx_old.c	2004-03-16 23:12:28.003891328 +0100
@@ -618,7 +618,6 @@ void pdc202xx_reset (ide_drive_t *drive)
 	 */
 	if (hwif->present) {
 		u16 hunit = 0;
-		hwif->initializing = 1;
 		for (hunit = 0; hunit < MAX_DRIVES; ++hunit) {
 			ide_drive_t *hdrive = &hwif->drives[hunit];
 			if (hdrive->present) {
@@ -628,11 +627,9 @@ void pdc202xx_reset (ide_drive_t *drive)
 					hwif->tuneproc(hdrive, 5);
 			}
 		}
-		hwif->initializing = 0;
 	}
 	if (mate->present) {
 		u16 munit = 0;
-		mate->initializing = 1;
 		for (munit = 0; munit < MAX_DRIVES; ++munit) {
 			ide_drive_t *mdrive = &mate->drives[munit];
 			if (mdrive->present) {
@@ -642,7 +639,6 @@ void pdc202xx_reset (ide_drive_t *drive)
 					mate->tuneproc(mdrive, 5);
 			}
 		}
-		mate->initializing = 0;
 	}
 #else
 	hwif->tuneproc(drive, 5);
diff -puN include/linux/ide.h~ide_initializing include/linux/ide.h
--- linux-2.6.5-rc1/include/linux/ide.h~ide_initializing	2004-03-16 23:12:27.994892696 +0100
+++ linux-2.6.5-rc1-root/include/linux/ide.h	2004-03-16 23:12:28.005891024 +0100
@@ -935,7 +935,6 @@ typedef struct hwif_s {
 	int		mmio;		/* hosts iomio (0), mmio (1) or custom (2) select */
 	int		rqsize;		/* max sectors per request */
 	int		irq;		/* our irq number */
-	int		initializing;	/* set while initializing self */
 
 	unsigned long	dma_master;	/* reference base addr dmabase */
 	unsigned long	dma_base;	/* base addr for dma ports */

_

