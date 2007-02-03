From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (2.6.20-rc7) alim15x3: fix PIO mode setup
Date: Sat, 3 Feb 2007 22:19:45 +0300
Message-ID: <200702032219.45153.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5358 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751258AbXBCTTv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Feb 2007 14:19:51 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The driver's tuneproc() method fails to set the drive's own speed -- fix this
by renaming the function to ali15x3_tune_pio() and "wrapping" the new tuneproc()
method around it and making it return the mode set, update the heading comment.

Also, setting PIO mode via the speedproc() method does not work due to passing 
to the tuneproc() method's a mode number not biased by XFER_PIO_0 -- fix this
along with a typo in the heading comment...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/alim15x3.c |   35 +++++++++++++++++++++++++++--------
 1 files changed, 27 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/ide/pci/alim15x3.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/alim15x3.c
+++ linux-2.6/drivers/ide/pci/alim15x3.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/alim15x3.c		Version 0.17	2003/01/02
+ * linux/drivers/ide/pci/alim15x3.c		Version 0.21	2007/02/03
  *
  *  Copyright (C) 1998-2000 Michel Aubry, Maintainer
  *  Copyright (C) 1998-2000 Andrzej Krzysztofowicz, Maintainer
@@ -9,6 +9,7 @@
  *  May be copied or modified under the terms of the GNU General Public License
  *  Copyright (C) 2002 Alan Cox <alan@redhat.com>
  *  ALi (now ULi M5228) support by Clear Zhang <Clear.Zhang@ali.com.tw>
+ *  Copyright (C) 2007 MontaVista Software, Inc. <source@mvista.com>
  *
  *  (U)DMA capable version of ali 1533/1543(C), 1535(D)
  *
@@ -280,15 +281,17 @@ static int ali_get_info (char *buffer, c
 #endif  /* defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS) */
 
 /**
- *	ali15x3_tune_drive	-	set up a drive
+ *	ali15x3_tune_pio	-	set up chipset for PIO mode
  *	@drive: drive to tune
- *	@pio: unused
+ *	@pio: desired mode
  *
- *	Select the best PIO timing for the drive in question. Then
- *	program the controller for this drive set up
+ *	Select the best PIO mode for the drive in question.
+ *	Then program the controller for this mode.
+ *
+ *	Returns the PIO mode programmed.
  */
  
-static void ali15x3_tune_drive (ide_drive_t *drive, u8 pio)
+static u8 ali15x3_tune_pio (ide_drive_t *drive, u8 pio)
 {
 	ide_pio_data_t d;
 	ide_hwif_t *hwif = HWIF(drive);
@@ -356,6 +359,22 @@ static void ali15x3_tune_drive (ide_driv
 	 * { 20,   50,     30  }    PIO Mode 5 with IORDY (nonstandard)
 	 */
 
+	return pio;
+}
+
+/**
+ *	ali15x3_tune_drive	-	set up drive for PIO mode
+ *	@drive: drive to tune
+ *	@pio: desired mode
+ *
+ *	Program the controller with the best PIO timing for the given drive.
+ *	Then set up the drive itself.
+ */
+
+static void ali15x3_tune_drive (ide_drive_t *drive, u8 pio)
+{
+	pio = ali15x3_tune_pio(drive, pio);
+	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
 /**
@@ -430,7 +449,7 @@ static u8 ali15x3_ratemask (ide_drive_t 
 }
 
 /**
- *	ali15x3_tune_chipset	-	set up chiset for new speed
+ *	ali15x3_tune_chipset	-	set up chipset/drive for new speed
  *	@drive: drive to configure for
  *	@xferspeed: desired speed
  *
@@ -461,7 +480,7 @@ static int ali15x3_tune_chipset (ide_dri
 		pci_write_config_byte(dev, m5229_udma, tmpbyte);
 
 		if (speed < XFER_SW_DMA_0)
-			ali15x3_tune_drive(drive, speed);
+			(void) ali15x3_tune_pio(drive, speed - XFER_PIO_0);
 	} else {
 		pci_read_config_byte(dev, m5229_udma, &tmpbyte);
 		tmpbyte &= (0x0f << ((1-unit) << 2));

