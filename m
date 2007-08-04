From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/11] ide: remove ide_use_fast_pio()
Date: Sat, 4 Aug 2007 22:09:10 +0200
Message-ID: <200708042209.10987.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:51446 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760014AbXHDUQL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 16:16:11 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1014326fkz
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 13:16:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Remove ide_use_fast_pio() and just re-tune PIO unconditionally if DMA tuning
has failed in ->ide_dma_check.  All host drivers using ide_use_fast_pio() set
drive->autotune so PIO is always tuned anyway and in some cases we _really_
need to re-tune PIO because PIO and DMA timings are shared.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-lib.c          |   15 ---------------
 drivers/ide/pci/aec62xx.c      |    3 +--
 drivers/ide/pci/atiixp.c       |    3 +--
 drivers/ide/pci/cmd64x.c       |    3 +--
 drivers/ide/pci/cs5535.c       |    3 +--
 drivers/ide/pci/hpt34x.c       |    3 +--
 drivers/ide/pci/hpt366.c       |    3 +--
 drivers/ide/pci/pdc202xx_new.c |    3 +--
 drivers/ide/pci/pdc202xx_old.c |    3 +--
 drivers/ide/pci/piix.c         |    3 +--
 drivers/ide/pci/scc_pata.c     |    3 +--
 drivers/ide/pci/serverworks.c  |    3 +--
 drivers/ide/pci/siimage.c      |    3 +--
 drivers/ide/pci/sis5513.c      |    3 +--
 drivers/ide/pci/slc90e66.c     |    3 +--
 drivers/ide/pci/tc86c001.c     |    3 +--
 include/linux/ide.h            |    1 -
 17 files changed, 15 insertions(+), 46 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -96,21 +96,6 @@ static u8 ide_rate_filter(ide_drive_t *d
 	return min(speed, mode);
 }
 
-int ide_use_fast_pio(ide_drive_t *drive)
-{
-	struct hd_driveid *id = drive->id;
-
-	if ((id->capability & 1) && drive->autodma)
-		return 1;
-
-	if ((id->capability & 8) || (id->field_valid & 2))
-		return 1;
-
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(ide_use_fast_pio);
-
 /*
  * Standard (generic) timings for PIO modes, from ATA2 specification.
  * These timings are for access to the IDE data port register *only*.
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -146,8 +146,7 @@ static int aec62xx_config_drive_xfer_rat
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -171,8 +171,7 @@ static int atiixp_dma_check(ide_drive_t 
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -335,8 +335,7 @@ static int cmd64x_config_drive_for_dma (
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -162,8 +162,7 @@ static int cs5535_dma_check(ide_drive_t 
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -85,8 +85,7 @@ static int hpt34x_config_drive_xfer_rate
 	if (ide_tune_dma(drive))
 		return -1;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -696,8 +696,7 @@ static int hpt366_config_drive_xfer_rate
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -228,8 +228,7 @@ static int pdcnew_config_drive_xfer_rate
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -184,8 +184,7 @@ static int pdc202xx_config_drive_xfer_ra
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -267,8 +267,7 @@ static int piix_config_drive_xfer_rate (
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -299,8 +299,7 @@ static int scc_config_drive_for_dma(ide_
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -200,8 +200,7 @@ static int svwks_config_drive_xfer_rate 
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -326,8 +326,7 @@ static int siimage_config_drive_for_dma 
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -606,8 +606,7 @@ static int sis5513_config_xfer_rate(ide_
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -135,8 +135,7 @@ static int slc90e66_config_drive_xfer_ra
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -167,8 +167,7 @@ static int tc86c001_config_drive_xfer_ra
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive))
-		ide_set_max_pio(drive);
+	ide_set_max_pio(drive);
 
 	return -1;
 }
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1385,7 +1385,6 @@ static inline void ide_set_hwifdata (ide
 extern char *ide_xfer_verbose(u8 xfer_rate);
 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
-int ide_use_fast_pio(ide_drive_t *);
 
 static inline int ide_dev_has_iordy(struct hd_driveid *id)
 {
