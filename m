From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (pata-2.6 fix queue) piix/slc90e66: more tuneproc() fixing
Date: Tue, 6 Feb 2007 22:14:28 +0300
Message-ID: <200702062214.28136.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:26112 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752215AbXBFTOd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 14:14:33 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The tuneproc() method in both these drivers failed to set the drive's own speed.
Fix this by renaming the function and "wrapping around it" the new tuneproc()
method.  While at it, convert the rest of the PIO setup code into proper C. :-)

Warning: this has only been compile tested (but we are in the merge window
already anyway :-).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/piix.c     |   45 +++++++++++++++++++++++++++++----------------
 drivers/ide/pci/slc90e66.c |   35 +++++++++++++++++++----------------
 2 files changed, 48 insertions(+), 32 deletions(-)

Index: linux-2.6/drivers/ide/pci/piix.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/piix.c
+++ linux-2.6/drivers/ide/pci/piix.c
@@ -1,10 +1,10 @@
 /*
- *  linux/drivers/ide/pci/piix.c	Version 0.46	December 3, 2006
+ *  linux/drivers/ide/pci/piix.c	Version 0.47	February 5, 2007
  *
  *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2003 Red Hat Inc <alan@redhat.com>
- *  Copyright (C) 2006 MontaVista Software, Inc. <source@mvista.com>
+ *  Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.com>
  *
  *  May be copied or modified under the terms of the GNU General Public License
  *
@@ -205,14 +205,13 @@ static u8 piix_dma_2_pio (u8 xfer_rate) 
 }
 
 /**
- *	piix_tune_drive		-	tune a drive attached to a PIIX
+ *	piix_tune_pio		-	tune PIIX for PIO mode
  *	@drive: drive to tune
  *	@pio: desired PIO mode
  *
- *	Set the interface PIO mode based upon  the settings done by AMI BIOS
- *	(might be useful if drive is not registered in CMOS for any reason).
+ *	Set the interface PIO mode based upon the settings done by AMI BIOS.
  */
-static void piix_tune_drive (ide_drive_t *drive, u8 pio)
+static void piix_tune_pio (ide_drive_t *drive, u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -233,8 +232,6 @@ static void piix_tune_drive (ide_drive_t
 					{ 2, 1 },
 					{ 2, 3 }, };
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
-
 	/*
 	 * Master vs slave is synchronized above us but the slave register is
 	 * shared by the two hwifs so the corner case of two slave timeouts in
@@ -253,19 +250,20 @@ static void piix_tune_drive (ide_drive_t
 		master_data |=  0x4000;
 		master_data &= ~0x0070;
 		if (pio > 1) {
-			/* enable PPE, IE and TIME */
-			master_data = master_data | (control << 4);
+			/* Set PPE, IE and TIME */
+			master_data |= control << 4;
 		}
 		pci_read_config_byte(dev, slave_port, &slave_data);
-		slave_data = slave_data & (hwif->channel ? 0x0f : 0xf0);
-		slave_data = slave_data | (((timings[pio][0] << 2) | timings[pio][1]) << (hwif->channel ? 4 : 0));
+		slave_data &= hwif->channel ? 0x0f : 0xf0;
+		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) <<
+			       (hwif->channel ? 4 : 0);
 	} else {
 		master_data &= ~0x3307;
 		if (pio > 1) {
 			/* enable PPE, IE and TIME */
-			master_data = master_data | control;
+			master_data |= control;
 		}
-		master_data = master_data | (timings[pio][0] << 12) | (timings[pio][1] << 8);
+		master_data |= (timings[pio][0] << 12) | (timings[pio][1] << 8);
 	}
 	pci_write_config_word(dev, master_port, master_data);
 	if (is_slave)
@@ -274,6 +272,21 @@ static void piix_tune_drive (ide_drive_t
 }
 
 /**
+ *	piix_tune_drive		-	tune a drive attached to PIIX
+ *	@drive: drive to tune
+ *	@pio: desired PIO mode
+ *
+ *	Set the drive's PIO mode (might be useful if drive is not registered
+ *	in CMOS for any reason).
+ */
+static void piix_tune_drive (ide_drive_t *drive, u8 pio)
+{
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	piix_tune_pio(drive, pio);
+	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
+}
+
+/**
  *	piix_tune_chipset	-	tune a PIIX interface
  *	@drive: IDE drive to tune
  *	@xferspeed: speed to configure
@@ -348,8 +361,8 @@ static int piix_tune_chipset (ide_drive_
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 	}
 
-	piix_tune_drive(drive, piix_dma_2_pio(speed));
-	return (ide_config_drive_speed(drive, speed));
+	piix_tune_pio(drive, piix_dma_2_pio(speed));
+	return ide_config_drive_speed(drive, speed);
 }
 
 /**
Index: linux-2.6/drivers/ide/pci/slc90e66.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/slc90e66.c
+++ linux-2.6/drivers/ide/pci/slc90e66.c
@@ -1,8 +1,8 @@
 /*
- *  linux/drivers/ide/pci/slc90e66.c	Version 0.13	December 30, 2006
+ *  linux/drivers/ide/pci/slc90e66.c	Version 0.14	February 5, 2007
  *
  *  Copyright (C) 2000-2002 Andre Hedrick <andre@linux-ide.org>
- *  Copyright (C) 2006 MontaVista Software, Inc. <source@mvista.com>
+ *  Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.com>
  *
  * This is a look-alike variation of the ICH0 PIIX4 Ultra-66,
  * but this keeps the ISA-Bridge and slots alive.
@@ -57,11 +57,7 @@ static u8 slc90e66_dma_2_pio (u8 xfer_ra
 	}
 }
 
-/*
- *  Based on settings done by AMI BIOS
- *  (might be useful if drive is not registered in CMOS for any reason).
- */
-static void slc90e66_tune_drive (ide_drive_t *drive, u8 pio)
+static void slc90e66_tune_pio (ide_drive_t *drive, u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -80,7 +76,6 @@ static void slc90e66_tune_drive (ide_dri
 					{ 2, 1 },
 					{ 2, 3 }, };
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
 	spin_lock_irqsave(&ide_lock, flags);
 	pci_read_config_word(dev, master_port, &master_data);
 
@@ -94,19 +89,20 @@ static void slc90e66_tune_drive (ide_dri
 		master_data |=  0x4000;
 		master_data &= ~0x0070;
 		if (pio > 1) {
-			/* enable PPE, IE and TIME */
-			master_data = master_data | (control << 4);
+			/* Set PPE, IE and TIME */
+			master_data |= control << 4;
 		}
 		pci_read_config_byte(dev, slave_port, &slave_data);
-		slave_data = slave_data & (hwif->channel ? 0x0f : 0xf0);
-		slave_data = slave_data | (((timings[pio][0] << 2) | timings[pio][1]) << (hwif->channel ? 4 : 0));
+		slave_data &= hwif->channel ? 0x0f : 0xf0;
+		slave_data |= ((timings[pio][0] << 2) | timings[pio][1]) <<
+			       (hwif->channel ? 4 : 0);
 	} else {
 		master_data &= ~0x3307;
 		if (pio > 1) {
 			/* enable PPE, IE and TIME */
-			master_data = master_data | control;
+			master_data |= control;
 		}
-		master_data = master_data | (timings[pio][0] << 12) | (timings[pio][1] << 8);
+		master_data |= (timings[pio][0] << 12) | (timings[pio][1] << 8);
 	}
 	pci_write_config_word(dev, master_port, master_data);
 	if (is_slave)
@@ -114,6 +110,13 @@ static void slc90e66_tune_drive (ide_dri
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
+static void slc90e66_tune_drive (ide_drive_t *drive, u8 pio)
+{
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	slc90e66_tune_pio(drive, pio);
+	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
+}
+
 static int slc90e66_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -162,8 +165,8 @@ static int slc90e66_tune_chipset (ide_dr
 			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
 	}
 
-	slc90e66_tune_drive(drive, slc90e66_dma_2_pio(speed));
-	return (ide_config_drive_speed(drive, speed));
+	slc90e66_tune_pio(drive, slc90e66_dma_2_pio(speed));
+	return ide_config_drive_speed(drive, speed);
 }
 
 static int slc90e66_config_drive_for_dma (ide_drive_t *drive)

