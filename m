From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] SLC90E66: config_drive_for_dma() cleanup
Date: Thu, 11 May 2006 23:38:12 +0400
Message-ID: <446392A4.7010101@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020900010302020206080407"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:17613 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750729AbWEKTjO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 15:39:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020900010302020206080407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Clean up config_drive_for_dma() from the useless code as there's no need
for PIO fallback here since this is done by its caller,
slc90e66_config_drive_xfer_rate().
    Also, while at it, simplify slc90e66_config_drive_xfer_rate() a bit.

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------020900010302020206080407
Content-Type: text/plain;
 name="slc90e66-config_drive_for_dma-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slc90e66-config_drive_for_dma-cleanup.patch"

Index: linus/drivers/ide/pci/slc90e66.c
===================================================================
--- linus.orig/drivers/ide/pci/slc90e66.c
+++ linus/drivers/ide/pci/slc90e66.c
@@ -2,6 +2,7 @@
  *  linux/drivers/ide/pci/slc90e66.c	Version 0.11	September 11, 2002
  *
  *  Copyright (C) 2000-2002 Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (C) 2006 MontaVista Software, Inc. <source@mvista.com>
  *
  * This a look-a-like variation of the ICH0 PIIX4 Ultra-66,
  * but this keeps the ISA-Bridge and slots alive.
@@ -161,10 +162,8 @@ static int slc90e66_config_drive_for_dma
 {
 	u8 speed = ide_dma_speed(drive, slc90e66_ratemask(drive));
 
-	if (!(speed)) {
-		u8 tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
-		speed = slc90e66_dma_2_pio(XFER_PIO_0 + tspeed);
-	}
+	if (!speed)
+		return 0;
 
 	(void) slc90e66_tune_chipset(drive, speed);
 	return ide_dma_enable(drive);
@@ -179,10 +178,8 @@ static int slc90e66_config_drive_xfer_ra
 
 	if (id && (id->capability & 1) && drive->autodma) {
 
-		if (ide_use_dma(drive)) {
-			if (slc90e66_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
+		if (ide_use_dma(drive) && slc90e66_config_drive_for_dma(drive))
+			return hwif->ide_dma_on(drive);
 
 		goto fast_ata_pio;
 


--------------020900010302020206080407--
