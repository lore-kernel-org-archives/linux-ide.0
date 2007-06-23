From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/6] atiixp: PIO mode setup fixes
Date: Sat, 23 Jun 2007 20:03:40 +0200
Message-ID: <200706232003.40776.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:28198 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871AbXFWRw4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 13:52:56 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1019617ugf
        for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 10:52:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Split off exisiting atiixp_tuneproc() into atiixp_tune_pio()
  and then add setting device PIO mode to atiixp_tuneproc().

* Add missing ide_get_best_pio_mode() call to atiixp_tuneproc() so
  "pio" == 255 (autotune) is handled correctly and "pio" values > 4 && < 255
  are filtered to PIO4 (previously "pio" == 5 could result in wrong timings
  being used and "pio" values > 4 && < 255 in an OOPS).

* Handle PIO modes early in atiixp_speedproc() so save_mdma_mode[]
  doesn't get cleared.

* In atiixp_dma_check():
  - fix max_mode argument for ide_get_best_pio_mode()
  - don't call atiixp_dma_2_pio() so PIO1 doesn't get remapped to PIO0
  - use atiixp_tuneproc() instead of atiixp_speedproc()

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/atiixp.c |   32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -1,9 +1,8 @@
 /*
- *  linux/drivers/ide/pci/atiixp.c	Version 0.01-bart2	Feb. 26, 2004
+ *  linux/drivers/ide/pci/atiixp.c	Version 0.02	Jun 16 2007
  *
  *  Copyright (C) 2003 ATI Inc. <hyu@ati.com>
- *  Copyright (C) 2004 Bartlomiej Zolnierkiewicz
- *
+ *  Copyright (C) 2004,2007 Bartlomiej Zolnierkiewicz
  */
 
 #include <linux/types.h>
@@ -123,14 +122,14 @@ static void atiixp_dma_host_off(ide_driv
 }
 
 /**
- *	atiixp_tune_drive		-	tune a drive attached to a ATIIXP
+ *	atiixp_tune_pio	-	tune a drive attached to a ATIIXP
  *	@drive: drive to tune
  *	@pio: desired PIO mode
  *
  *	Set the interface PIO mode.
  */
 
-static void atiixp_tuneproc(ide_drive_t *drive, u8 pio)
+static void atiixp_tune_pio(ide_drive_t *drive, u8 pio)
 {
 	struct pci_dev *dev = drive->hwif->pci_dev;
 	unsigned long flags;
@@ -154,6 +153,13 @@ static void atiixp_tuneproc(ide_drive_t 
 	spin_unlock_irqrestore(&atiixp_lock, flags);
 }
 
+static void atiixp_tuneproc(ide_drive_t *drive, u8 pio)
+{
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	atiixp_tune_pio(drive, pio);
+	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
+}
+
 /**
  *	atiixp_tune_chipset	-	tune a ATIIXP interface
  *	@drive: IDE drive to tune
@@ -175,6 +181,11 @@ static int atiixp_speedproc(ide_drive_t 
 
 	speed = ide_rate_filter(drive, xferspeed);
 
+	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
+		atiixp_tune_pio(drive, speed - XFER_PIO_0);
+		return ide_config_drive_speed(drive, speed);
+	}
+
 	spin_lock_irqsave(&atiixp_lock, flags);
 
 	save_mdma_mode[drive->dn] = 0;
@@ -201,7 +212,7 @@ static int atiixp_speedproc(ide_drive_t 
 	else
 		pio = speed - XFER_PIO_0;
 
-	atiixp_tuneproc(drive, pio);
+	atiixp_tune_pio(drive, pio);
 
 	return ide_config_drive_speed(drive, speed);
 }
@@ -216,18 +227,13 @@ static int atiixp_speedproc(ide_drive_t 
 
 static int atiixp_dma_check(ide_drive_t *drive)
 {
-	u8 tspeed, speed;
-
 	drive->init_speed = 0;
 
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive)) {
-		tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
-		speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) + XFER_PIO_0;
-		atiixp_speedproc(drive, speed);
-	}
+	if (ide_use_fast_pio(drive))
+		atiixp_tuneproc(drive, 255);
 
 	return -1;
 }
