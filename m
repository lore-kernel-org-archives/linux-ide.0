From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/4] alim15x3: PIO mode setup fixes
Date: Fri, 20 Jul 2007 12:24:33 +0200
Message-ID: <200707201224.33356.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:57100 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbXGTKJE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 06:09:04 -0400
Received: by ug-out-1314.google.com with SMTP id j3so586011ugf
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 03:09:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Return failure in ->speedproc method for unsupported/invalid transfer
  modes passed from user-space (fixes theoretical OOPS in ali_tune_pio()
  and/or setting random PIO timings on host controller + disabling UDMA
  bit + setting unsupported/invalid transfer mode on the device).

* Don't disable UDMA bit when programming PIO modes.

* Add FIXME about DMA timings never being set.

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/alim15x3.c		Version 0.25	Jun 9 2007
+ * linux/drivers/ide/pci/alim15x3.c		Version 0.26	Jul 14 2007
  *
  *  Copyright (C) 1998-2000 Michel Aubry, Maintainer
  *  Copyright (C) 1998-2000 Andrzej Krzysztofowicz, Maintainer
@@ -418,6 +418,14 @@ static int ali15x3_tune_chipset(ide_driv
 	u8 tmpbyte		= 0x00;
 	int m5229_udma		= (hwif->channel) ? 0x57 : 0x56;
 
+	if (speed < XFER_PIO_0)
+		return 1;
+
+	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_5) {
+		ali_tune_pio(drive, speed - XFER_PIO_0);
+		return ide_config_drive_speed(drive, speed);
+	}
+
 	if (speed == XFER_UDMA_6)
 		speed1 = 0x47;
 
@@ -430,8 +438,9 @@ static int ali15x3_tune_chipset(ide_driv
 		tmpbyte &= ultra_enable;
 		pci_write_config_byte(dev, m5229_udma, tmpbyte);
 
-		if (speed < XFER_SW_DMA_0)
-			ali_tune_pio(drive, speed - XFER_PIO_0);
+		/*
+		 * FIXME: Oh, my... DMA timings are never set.
+		 */
 	} else {
 		pci_read_config_byte(dev, m5229_udma, &tmpbyte);
 		tmpbyte &= (0x0f << ((1-unit) << 2));
