From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pdc202xx_new: check ide_config_drive_speed() return value
Date: Thu, 26 Jul 2007 21:56:57 +0200
Message-ID: <200707262156.57562.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:62760 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936199AbXGZUAA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 16:00:00 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591339ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_new.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -150,13 +150,13 @@ static int pdcnew_tune_chipset(ide_drive
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 adj			= (drive->dn & 1) ? 0x08 : 0x00;
-	int			err;
 
 	/*
 	 * Issue SETFEATURES_XFER to the drive first. PDC202xx hardware will
 	 * automatically set the timing registers based on 100 MHz PLL output.
 	 */
- 	err = ide_config_drive_speed(drive, speed);
+	if (ide_config_drive_speed(drive, speed))
+		return 1;
 
 	/*
 	 * As we set up the PLL to output 133 MHz for UltraDMA/133 capable
@@ -212,7 +212,7 @@ static int pdcnew_tune_chipset(ide_drive
 		set_indexed_reg(hwif, 0x10 + adj, tmp & 0x7f);
  	}
 
-	return err;
+	return 0;
 }
 
 static void pdcnew_set_pio_mode(ide_drive_t *drive, const u8 pio)
