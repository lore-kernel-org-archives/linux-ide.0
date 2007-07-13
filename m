From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cs5520: don't enable VDMA in ->speedproc
Date: Fri, 13 Jul 2007 23:11:19 +0200
Message-ID: <200707132311.19938.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:9157 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167AbXGMVbK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 17:31:10 -0400
Received: by nf-out-0910.google.com with SMTP id g13so42355nfb
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 14:31:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


There is no need to do it in cs5520_tune_chipset() (->speedproc method)
since it is correctly handled by cs5520_dma_on() (->ide_dma_on method).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cs5520.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -73,7 +73,6 @@ static int cs5520_tune_chipset(ide_drive
 	int pio = speed;
 	u8 reg;
 	int controller = drive->dn > 1 ? 1 : 0;
-	int error;
 
 	switch(speed)
 	{
@@ -114,14 +113,9 @@ static int cs5520_tune_chipset(ide_drive
 	reg = inb(hwif->dma_base + 0x02 + 8*controller);
 	reg |= 1<<((drive->dn&1)+5);
 	outb(reg, hwif->dma_base + 0x02 + 8*controller);
-		
-	error = ide_config_drive_speed(drive, speed);
-	/* ATAPI is harder so leave it for now */
-	if(!error && drive->media == ide_disk)
-		error = hwif->ide_dma_on(drive);
 
-	return error;
-}	
+	return ide_config_drive_speed(drive, speed);
+}
 
 static void cs5520_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
@@ -177,7 +171,8 @@ static void __devinit init_hwif_cs5520(i
 		hwif->drives[1].autotune = 1;
 		return;
 	}
-	
+
+	/* ATAPI is harder so leave it for now */
 	hwif->atapi_dma = 0;
 	hwif->ultra_mask = 0;
 	hwif->swdma_mask = 0;
