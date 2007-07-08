From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/12] jmicron: PIO fixes
Date: Sun, 8 Jul 2007 15:36:04 +0200
Message-ID: <200707081536.04816.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:5711 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756120AbXGHOAL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 10:00:11 -0400
Received: by mu-out-0910.google.com with SMTP id i10so570183mue
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 07:00:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Set transfer mode on the device in jmicron_tuneproc(),
  also add pio == 255 == "auto-tune" handling.

* Use jmicron_tuneproc() in jmicron_config_drive_for_dma().

* Remove no longer needed config_jmicron_chipset_for_pio().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/jmicron.c |   21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -83,23 +83,10 @@ static u8 __devinit ata66_jmicron(ide_hw
 	return ATA_CBL_PATA80;
 }
 
-static void jmicron_tuneproc (ide_drive_t *drive, byte mode_wanted)
+static void jmicron_tuneproc(ide_drive_t *drive, u8 pio)
 {
-	return;
-}
-
-/**
- *	config_jmicron_chipset_for_pio	-	set drive timings
- *	@drive: drive to tune
- *	@speed we want
- *
- */
-
-static void config_jmicron_chipset_for_pio (ide_drive_t *drive, byte set_speed)
-{
-	u8 speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5);
-	if (set_speed)
-		(void) ide_config_drive_speed(drive, speed);
+	pio = ide_get_best_pio_mode(drive, pio, 5);
+	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
 /**
@@ -132,7 +119,7 @@ static int jmicron_config_drive_for_dma 
 	if (ide_tune_dma(drive))
 		return 0;
 
-	config_jmicron_chipset_for_pio(drive, 1);
+	jmicron_tuneproc(drive, 255);
 
 	return -1;
 }
