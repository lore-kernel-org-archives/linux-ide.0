From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/13] it821x: PIO mode setup fixes
Date: Sat, 10 Mar 2007 22:12:39 +0100
Message-ID: <200703102212.39936.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:46176 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932375AbXCJVJX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749119uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:21 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] it821x: PIO mode setup fixes

* limit max PIO mode to PIO4, this driver doesn't support PIO5 and attempt
  to setup PIO5 by it821x_tuneproc() could result in incorrect PIO timings
  + incorrect base clock being set for controller in the passthrough mode

* move code limiting max PIO according to the pair device capabilities from
  config_it821x_chipset_for_pio() to it821x_tuneproc() so the check is also
  applied for mode change requests coming through ->tuneproc and ->speedproc
  interfaces

* set device speed in it821x_tuneproc()

* in it821x_tune_chipset() call it821x_tuneproc() also if the controller is
  in the smart mode (so the check for pair device max PIO is done)

* rename it821x_tuneproc() to it821x_tune_pio(), then add it821x_tuneproc()
  wrapper which does the max PIO mode check;  it worked by the pure luck
  previously, pio[4] and pio_want[4] arrays were used with index == 255
  so random PIO timings and base clock were set for the controller in the
  passthrough mode, thankfully PIO timings and base clock were corrected
  later by config_it821x_chipset_for_pio() call (but it was not called for
  PIO-only devices during resume and for user requested PIO autotuning)

* remove config_it821x_chipset_for_pio() call from config_chipset_for_dma()
  as the driver sets ->autotune to 1 and ->tuneproc does the proper job now

* convert the last user of config_it821x_chipset_for_pio() to use
  it821x_tuneproc(drive, 255) and remove no longer needed function

While at it:

* fix few comments

* bump driver version

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/pci/it821x.c |  126 +++++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 68 deletions(-)

Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -1,8 +1,9 @@
 
 /*
- * linux/drivers/ide/pci/it821x.c		Version 0.09	December 2004
+ * linux/drivers/ide/pci/it821x.c		Version 0.10	Mar 10 2007
  *
  * Copyright (C) 2004		Red Hat <alan@redhat.com>
+ * Copyright (C) 2007		Bartlomiej Zolnierkiewicz
  *
  *  May be copied or modified under the terms of the GNU General Public License
  *  Based in part on the ITE vendor provided SCSI driver.
@@ -104,6 +105,7 @@ static int it8212_noraid;
 /**
  *	it821x_program	-	program the PIO/MWDMA registers
  *	@drive: drive to tune
+ *	@timing: timing info
  *
  *	Program the PIO/MWDMA timing for this channel according to the
  *	current clock.
@@ -127,6 +129,7 @@ static void it821x_program(ide_drive_t *
 /**
  *	it821x_program_udma	-	program the UDMA registers
  *	@drive: drive to tune
+ *	@timing: timing info
  *
  *	Program the UDMA timing for this drive according to the
  *	current clock.
@@ -153,10 +156,9 @@ static void it821x_program_udma(ide_driv
 	}
 }
 
-
 /**
  *	it821x_clock_strategy
- *	@hwif: hardware interface
+ *	@drive: drive to set up
  *
  *	Select between the 50 and 66Mhz base clocks to get the best
  *	results for this interface.
@@ -182,8 +184,11 @@ static void it821x_clock_strategy(ide_dr
 		altclock = itdev->want[0][1];
 	}
 
-	/* Master doesn't care does the slave ? */
-	if(clock == ATA_ANY)
+	/*
+	 * if both clocks can be used for the mode with the higher priority
+	 * use the clock needed by the mode with the lower priority
+	 */
+	if (clock == ATA_ANY)
 		clock = altclock;
 
 	/* Nobody cares - keep the same clock */
@@ -224,37 +229,56 @@ static void it821x_clock_strategy(ide_dr
 }
 
 /**
- *	it821x_tuneproc	-	tune a drive
+ *	it821x_tunepio	-	tune a drive
  *	@drive: drive to tune
- *	@mode_wanted: the target operating mode
- *
- *	Load the timing settings for this device mode into the
- *	controller. By the time we are called the mode has been
- *	modified as neccessary to handle the absence of seperate
- *	master/slave timers for MWDMA/PIO.
+ *	@pio: the desired PIO mode
  *
- *	This code is only used in pass through mode.
+ *	Try to tune the drive/host to the desired PIO mode taking into
+ *	the consideration the maximum PIO mode supported by the other
+ *	device on the cable.
  */
 
-static void it821x_tuneproc (ide_drive_t *drive, byte mode_wanted)
+static int it821x_tunepio(ide_drive_t *drive, u8 set_pio)
 {
 	ide_hwif_t *hwif	= drive->hwif;
 	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
 	int unit = drive->select.b.unit;
+	ide_drive_t *pair = &hwif->drives[1 - unit];
 
 	/* Spec says 89 ref driver uses 88 */
 	static u16 pio[]	= { 0xAA88, 0xA382, 0xA181, 0x3332, 0x3121 };
 	static u8 pio_want[]    = { ATA_66, ATA_66, ATA_66, ATA_66, ATA_ANY };
 
-	if(itdev->smart)
-		return;
+	/*
+	 * Compute the best PIO mode we can for a given device. We must
+	 * pick a speed that does not cause problems with the other device
+	 * on the cable.
+	 */
+	if (pair) {
+		u8 pair_pio = ide_get_best_pio_mode(pair, 255, 4, NULL);
+		/* trim PIO to the slowest of the master/slave */
+		if (pair_pio < set_pio)
+			set_pio = pair_pio;
+	}
+
+	if (itdev->smart)
+		goto set_drive_speed;
 
 	/* We prefer 66Mhz clock for PIO 0-3, don't care for PIO4 */
-	itdev->want[unit][1] = pio_want[mode_wanted];
+	itdev->want[unit][1] = pio_want[set_pio];
 	itdev->want[unit][0] = 1;	/* PIO is lowest priority */
-	itdev->pio[unit] = pio[mode_wanted];
+	itdev->pio[unit] = pio[set_pio];
 	it821x_clock_strategy(drive);
 	it821x_program(drive, itdev->pio[unit]);
+
+set_drive_speed:
+	return ide_config_drive_speed(drive, XFER_PIO_0 + set_pio);
+}
+
+static void it821x_tuneproc(ide_drive_t *drive, u8 pio)
+{
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	(void)it821x_tunepio(drive, pio);
 }
 
 /**
@@ -338,40 +362,6 @@ static void it821x_tune_udma (ide_drive_
 }
 
 /**
- *	config_it821x_chipset_for_pio	-	set drive timings
- *	@drive: drive to tune
- *	@speed we want
- *
- *	Compute the best pio mode we can for a given device. We must
- *	pick a speed that does not cause problems with the other device
- *	on the cable.
- */
-
-static void config_it821x_chipset_for_pio (ide_drive_t *drive, byte set_speed)
-{
-	u8 unit = drive->select.b.unit;
-	ide_hwif_t *hwif = drive->hwif;
-	ide_drive_t *pair = &hwif->drives[1-unit];
-	u8 speed = 0, set_pio	= ide_get_best_pio_mode(drive, 255, 5, NULL);
-	u8 pair_pio;
-
-	/* We have to deal with this mess in pairs */
-	if(pair != NULL) {
-		pair_pio = ide_get_best_pio_mode(pair, 255, 5, NULL);
-		/* Trim PIO to the slowest of the master/slave */
-		if(pair_pio < set_pio)
-			set_pio = pair_pio;
-	}
-	it821x_tuneproc(drive, set_pio);
-	speed = XFER_PIO_0 + set_pio;
-	/* XXX - We trim to the lowest of the pair so the other drive
-	   will always be fine at this point until we do hotplug passthru */
-
-	if (set_speed)
-		(void) ide_config_drive_speed(drive, speed);
-}
-
-/**
  *	it821x_dma_read	-	DMA hook
  *	@drive: drive for DMA
  *
@@ -434,15 +424,17 @@ static int it821x_tune_chipset (ide_driv
 	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
 	u8 speed		= ide_rate_filter(drive, xferspeed);
 
-	if(!itdev->smart) {
-		switch(speed) {
-			case XFER_PIO_4:
-			case XFER_PIO_3:
-			case XFER_PIO_2:
-			case XFER_PIO_1:
-			case XFER_PIO_0:
-				it821x_tuneproc(drive, (speed - XFER_PIO_0));
-				break;
+	switch (speed) {
+	case XFER_PIO_4:
+	case XFER_PIO_3:
+	case XFER_PIO_2:
+	case XFER_PIO_1:
+	case XFER_PIO_0:
+		return it821x_tunepio(drive, speed - XFER_PIO_0);
+	}
+
+	if (itdev->smart == 0) {
+		switch (speed) {
 			/* MWDMA tuning is really hard because our MWDMA and PIO
 			   timings are kept in the same place. We can switch in the
 			   host dma on/off callbacks */
@@ -482,14 +474,12 @@ static int config_chipset_for_dma (ide_d
 {
 	u8 speed = ide_max_dma_mode(drive);
 
-	if (speed) {
-		config_it821x_chipset_for_pio(drive, 0);
-		it821x_tune_chipset(drive, speed);
+	if (speed == 0)
+		return 0;
 
-		return ide_dma_enable(drive);
-	}
+	it821x_tune_chipset(drive, speed);
 
-	return 0;
+	return ide_dma_enable(drive);
 }
 
 /**
@@ -507,7 +497,7 @@ static int it821x_config_drive_for_dma (
 	if (ide_use_dma(drive) && config_chipset_for_dma(drive))
 		return 0;
 
-	config_it821x_chipset_for_pio(drive, 1);
+	it821x_tuneproc(drive, 255);
 
 	return -1;
 }
