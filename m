From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/12] ide: add missing ide_rate_filter() calls to ->speedproc()-s
Date: Sun, 8 Jul 2007 15:34:06 +0200
Message-ID: <200707081534.06163.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:47402 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756124AbXGHOAB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 10:00:01 -0400
Received: by ug-out-1314.google.com with SMTP id j3so991056ugf
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 07:00:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Fix icside, cris-ide, au1xxx-ide, amd74xx, via82cxxx and pmac host drivers
  to use ide_rate_filter().

  This results in the following modes (from user requests) being clipped down:
  - invalid modes (values 0x46-0xFF)  [ for all hosts ]
  - unsupported by a host UDMA modes  [ for hosts which support UDMA]
  - all UDMA modes and MWDMA3-4 modes [ for hosts which doesn't support UDMA ]
  - invalid modes (values 0x25-0x39)  [ for hosts which doesn't support UDMA ]

* Host driver specific changes in behavior:

  icside:
    - no change

  cris-ide
    - clip unsupported UDMA3-6 modes down
    - fix BUG() on trying to set unsupported UDMA3-6 modes

  au1xxx-ide/pmac
    - clip unsupported UDMA modes down

  amd74xx/via82cxxx
    - clip unsupported UDMA modes down
    - fix random PIO timings being set for unsupported/invalid modes
    - fix unsupported/invalid modes being set on the device

* While at it remove no longer needed checks from pmac.c driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
This patch series goes before ide-add-ide-set-pio-take3.patch patch
("[PATCH] ide: add ide_set{_max}_pio() (take 3)") in the quilt tree.
The rediffed ide-add-ide-set-pio-take3.patch is also included for
completness.

 drivers/ide/arm/icside.c      |    3 +--
 drivers/ide/cris/ide-cris.c   |    2 ++
 drivers/ide/mips/au1xxx-ide.c |    2 ++
 drivers/ide/pci/amd74xx.c     |    2 ++
 drivers/ide/pci/via82cxxx.c   |    2 ++
 drivers/ide/ppc/pmac.c        |   10 ++--------
 6 files changed, 11 insertions(+), 10 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -255,8 +255,7 @@ static int icside_set_speed(ide_drive_t 
 	/*
 	 * Limit the transfer speed to MW_DMA_2.
 	 */
-	if (xfer_mode > XFER_MW_DMA_2)
-		xfer_mode = XFER_MW_DMA_2;
+	xfer_mode = ide_rate_filter(drive, xfer_mode);
 
 	switch (xfer_mode) {
 	case XFER_MW_DMA_2:
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -730,6 +730,8 @@ static int speed_cris_ide(ide_drive_t *d
 {
 	int cyc = 0, dvs = 0, strobe = 0, hold = 0;
 
+	speed = ide_rate_filter(drive, speed);
+
 	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
 		cris_set_pio_mode(drive, speed - XFER_PIO_0);
 		return ide_config_drive_speed(drive, speed);
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -174,6 +174,8 @@ static int auide_tune_chipset (ide_drive
 	int mem_sttime;
 	int mem_stcfg;
 
+	speed = ide_rate_filter(drive, speed);
+
 	mem_sttime = 0;
 	mem_stcfg  = au_readl(MEM_STCFG2);
 
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -241,6 +241,8 @@ static int amd_set_drive(ide_drive_t *dr
 	struct ide_timing t, p;
 	int T, UT;
 
+	speed = ide_rate_filter(drive, speed);
+
 	if (speed != XFER_PIO_SLOW)
 		ide_config_drive_speed(drive, speed);
 
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -164,6 +164,8 @@ static int via_set_drive(ide_drive_t *dr
 	struct ide_timing t, p;
 	unsigned int T, UT;
 
+	speed = ide_rate_filter(drive, speed);
+
 	if (speed != XFER_PIO_SLOW)
 		ide_config_drive_speed(drive, speed);
 
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -923,6 +923,8 @@ pmac_ide_tune_chipset (ide_drive_t *driv
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
 	u32 *timings, *timings2;
 
+	speed = ide_rate_filter(drive, speed);
+
 	if (pmif == NULL)
 		return 1;
 		
@@ -932,17 +934,9 @@ pmac_ide_tune_chipset (ide_drive_t *driv
 	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
 		case XFER_UDMA_6:
-		        if (pmif->kind != controller_sh_ata6)
-				return 1;
 		case XFER_UDMA_5:
-			if (pmif->kind != controller_un_ata6 &&
-			    pmif->kind != controller_k2_ata6 &&
-			    pmif->kind != controller_sh_ata6)
-				return 1;
 		case XFER_UDMA_4:
 		case XFER_UDMA_3:
-			if (drive->hwif->cbl != ATA_CBL_PATA80)
-				return 1;
 		case XFER_UDMA_2:
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
