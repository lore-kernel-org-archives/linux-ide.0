From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/12] cs5535: PIO fixes
Date: Sun, 8 Jul 2007 15:34:31 +0200
Message-ID: <200707081534.31610.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:5731 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756124AbXGHOAJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 10:00:09 -0400
Received: by mu-out-0910.google.com with SMTP id i10so570149mue
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 07:00:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Fix cs5535_tuneproc() to pass PIO transfer mode value instead of PIO mode
  number to cs5535_set_speed() (fixes random PIO timings being programmed
  and a possible OOPS).  Do a little cleanup while at it.

* Fix cs5535_set_speed() to check if the mate device is present (fixes PIO0
  taskfile timings being used if there is no other device on the cable).

* Use cs5535_tuneproc() in cs5535_dma_check().  The old code had the same
  issue as cs5535_tuneproc() and add additionally caused 0x00-0x04 transfer
  mode values (== default PIO, default PIO w/ IORDY + two invalid values)
  being set on the device instead of values 0x08-0x0c (XFER_PIO_[0,4]).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5535.c |   42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -2,6 +2,7 @@
  * linux/drivers/ide/pci/cs5535.c
  *
  * Copyright (C) 2004-2005 Advanced Micro Devices, Inc.
+ * Copyright (C)      2007 Bartlomiej Zolnierkiewicz
  *
  * History:
  * 09/20/2005 - Jaya Kumar <jayakumar.ide@gmail.com>
@@ -83,14 +84,17 @@ static void cs5535_set_speed(ide_drive_t
 
 	/* Set the PIO timings */
 	if ((speed & XFER_MODE) == XFER_PIO) {
-		u8 pioa;
-		u8 piob;
-		u8 cmd;
-
-		pioa = speed - XFER_PIO_0;
-		piob = ide_get_best_pio_mode(&(drive->hwif->drives[!unit]),
-						255, 4);
-		cmd = pioa < piob ? pioa : piob;
+		ide_drive_t *pair = &drive->hwif->drives[drive->dn ^ 1];
+		u8 cmd, pioa;
+
+		cmd = pioa = speed - XFER_PIO_0;
+
+		if (pair->present) {
+			u8 piob = ide_get_best_pio_mode(pair, 255, 4);
+
+			if (piob < cmd)
+				cmd = piob;
+		}
 
 		/* Write the speed of the current drive */
 		reg = (cs5535_pio_cmd_timings[cmd] << 16) |
@@ -151,32 +155,22 @@ static int cs5535_set_drive(ide_drive_t 
  *
  *	A callback from the upper layers for PIO-only tuning.
  */
-static void cs5535_tuneproc(ide_drive_t *drive, u8 xferspeed)
+static void cs5535_tuneproc(ide_drive_t *drive, u8 pio)
 {
-	u8 modes[] = {	XFER_PIO_0, XFER_PIO_1, XFER_PIO_2, XFER_PIO_3,
-			XFER_PIO_4 };
-
-	/* cs5535 max pio is pio 4, best_pio will check the blacklist.
-	i think we don't need to rate_filter the incoming xferspeed
-	since we know we're only going to choose pio */
-	xferspeed = ide_get_best_pio_mode(drive, xferspeed, 4);
-	ide_config_drive_speed(drive, modes[xferspeed]);
-	cs5535_set_speed(drive, xferspeed);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
+	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
+	cs5535_set_speed(drive, XFER_PIO_0 + pio);
 }
 
 static int cs5535_dma_check(ide_drive_t *drive)
 {
-	u8 speed;
-
 	drive->init_speed = 0;
 
 	if (ide_tune_dma(drive))
 		return 0;
 
-	if (ide_use_fast_pio(drive)) {
-		speed = ide_get_best_pio_mode(drive, 255, 4);
-		cs5535_set_drive(drive, speed);
-	}
+	if (ide_use_fast_pio(drive))
+		cs5535_tuneproc(drive, 255);
 
 	return -1;
 }
