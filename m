From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/12] it8213: PIO fixes
Date: Sun, 8 Jul 2007 15:35:12 +0200
Message-ID: <200707081535.12938.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:48887 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbXGHOAd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 10:00:33 -0400
Received: by ug-out-1314.google.com with SMTP id j3so991055ugf
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 07:00:32 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Rename it8213_tuneproc() to it8213_tune_pio() and add it8213_tuneproc()
  wrapper.  Move finding of the best PIO mode to the new wrapper.

* Add setting of transfer mode on the device to it8213_tuneproc().

* Don't call it8213_dma_2_pio() for PIO modes in it8213_tune_chipset().

* Use it8213_tuneproc() in it8213_config_drive_for_dma().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/it8213.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -55,14 +55,14 @@ static u8 it8213_dma_2_pio (u8 xfer_rate
 }
 
 /*
- *	it8213_tuneproc	-	tune a drive
+ *	it8213_tune_pio	-	tune a drive
  *	@drive: drive to tune
  *	@pio: desired PIO mode
  *
  *	Set the interface PIO mode.
  */
 
-static void it8213_tuneproc (ide_drive_t *drive, u8 pio)
+static void it8213_tune_pio(ide_drive_t *drive, const u8 pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -82,8 +82,6 @@ static void it8213_tuneproc (ide_drive_t
 					{ 2, 1 },
 					{ 2, 3 }, };
 
-	pio = ide_get_best_pio_mode(drive, pio, 4);
-
 	spin_lock_irqsave(&tune_lock, flags);
 	pci_read_config_word(dev, master_port, &master_data);
 
@@ -113,6 +111,13 @@ static void it8213_tuneproc (ide_drive_t
 	spin_unlock_irqrestore(&tune_lock, flags);
 }
 
+static void it8213_tuneproc(ide_drive_t *drive, u8 pio)
+{
+	pio = ide_get_best_pio_mode(drive, pio, 4);
+	it8213_tune_pio(drive, pio);
+	ide_config_drive_speed(drive, XFER_PIO_0 + pio);
+}
+
 /**
  *	it8213_tune_chipset	-	set controller timings
  *	@drive: Drive to set up
@@ -193,7 +198,12 @@ static int it8213_tune_chipset (ide_driv
 		if (reg55 & w_flag)
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 	}
-	it8213_tuneproc(drive, it8213_dma_2_pio(speed));
+
+	if (speed > XFER_PIO_4)
+		it8213_tune_pio(drive, it8213_dma_2_pio(speed));
+	else
+		it8213_tune_pio(drive, speed - XFER_PIO_0);
+
 	return ide_config_drive_speed(drive, speed);
 }
 
@@ -209,13 +219,10 @@ static int it8213_tune_chipset (ide_driv
 
 static int it8213_config_drive_for_dma (ide_drive_t *drive)
 {
-	u8 pio;
-
 	if (ide_tune_dma(drive))
 		return 0;
 
-	pio = ide_get_best_pio_mode(drive, 255, 4);
-	it8213_tune_chipset(drive, XFER_PIO_0 + pio);
+	it8213_tuneproc(drive, 255);
 
 	return -1;
 }
