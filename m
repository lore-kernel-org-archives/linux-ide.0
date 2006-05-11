From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] PIIX: config_drive_for_dma() cleanup
Date: Thu, 11 May 2006 23:02:39 +0400
Message-ID: <44638A4F.2090502@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020502020806040301080106"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:5835 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1750708AbWEKTDr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 May 2006 15:03:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, liknux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020502020806040301080106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Clean up config_drive_for_dma() from the useless code:

  - there's no need for PIO fallback here since this is done by the caller,
    piix_config_drive_xfer_rate();

  - there's no need for MWDMA mode 0 check, since this mode is not supported by
    the driver (hwif->mwdma_mask == 0x6), and hence can't be selected by
    ide_dma_speed().

    Also, while at it, simplify piix_config_drive_xfer_rate() a bit.

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------020502020806040301080106
Content-Type: text/plain;
 name="piix-config_drive_for_dma-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="piix-config_drive_for_dma-cleanup.patch"

Index: linus/drivers/ide/pci/piix.c
===================================================================
--- linus.orig/drivers/ide/pci/piix.c
+++ linus/drivers/ide/pci/piix.c
@@ -4,10 +4,11 @@
  *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2003 Red Hat Inc <alan@redhat.com>
+ *  Copyright (C) 2006 MontaVista Software, Inc. <source@mvista.com>
  *
  *  May be copied or modified under the terms of the GNU General Public License
  *
- *  PIO mode setting function for Intel chipsets.  
+ *  PIO mode setting function for Intel chipsets.
  *  For use instead of BIOS settings.
  *
  * 40-41
@@ -25,7 +26,7 @@
  * sitre = word42 & 0x4000; secondary
  *
  * 44 8421|8421    hdd|hdb
- * 
+ *
  * 48 8421         hdd|hdc|hdb|hda udma enabled
  *
  *    0001         hda
@@ -73,8 +74,6 @@
  *	PIIX4	errata #15	- Must not read control registers
  * 				  during a PIO transfer
  *	440MX   errata #13	- As PIIX4 errata #15
- *	ICH2	errata #21	- DMA mode 0 doesn't work right
- *	ICH0/1  errata #55	- As ICH2 errata #21
  *	ICH2	spec c #9	- Extra operations needed to handle
  *				  drive hotswap [NOT YET SUPPORTED]
  *	ICH2    spec c #20	- IDE PRD must not cross a 64K boundary
@@ -333,56 +332,24 @@ static int piix_tune_chipset (ide_drive_
 }
 
 /**
- *	piix_faulty_dma0		-	check for DMA0 errata
- *	@hwif: IDE interface to check
- *
- *	If an ICH/ICH0/ICH2 interface is is operating in multi-word
- *	DMA mode with 600nS cycle time the IDE PIO prefetch buffer will
- *	inadvertently provide an extra piece of secondary data to the primary
- *	device resulting in data corruption.
- *
- *	With such a device this test function returns true. This allows
- *	our tuning code to follow Intel recommendations and use PIO on
- *	such devices.
- */
- 
-static int piix_faulty_dma0(ide_hwif_t *hwif)
-{
-	switch(hwif->pci_dev->device)
-	{
-		case PCI_DEVICE_ID_INTEL_82801AA_1:	/* ICH */
-		case PCI_DEVICE_ID_INTEL_82801AB_1:	/* ICH0 */
-		case PCI_DEVICE_ID_INTEL_82801BA_8:	/* ICH2 */
-		case PCI_DEVICE_ID_INTEL_82801BA_9:	/* ICH2 */
-			return 1;
-	}
-	return 0;
-}
-
-/**
  *	piix_config_drive_for_dma	-	configure drive for DMA
  *	@drive: IDE drive to configure
  *
  *	Set up a PIIX interface channel for the best available speed.
- *	We prefer UDMA if it is available and then MWDMA. If DMA is 
- *	not available we switch to PIO and return 0. 
+ *	We prefer UDMA if it is available and then MWDMA.  If DMA is
+ *	not available we return 0.
  */
  
 static int piix_config_drive_for_dma (ide_drive_t *drive)
 {
 	u8 speed = ide_dma_speed(drive, piix_ratemask(drive));
-	
-	/* Some ICH devices cannot support DMA mode 0 */
-	if(speed == XFER_MW_DMA_0 && piix_faulty_dma0(HWIF(drive)))
-		speed = 0;
-
-	/* If no DMA speed was available or the chipset has DMA bugs
-	   then disable DMA and use PIO */
-	   
-	if (!speed || no_piix_dma) {
-		u8 tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
-		speed = piix_dma_2_pio(XFER_PIO_0 + tspeed);
-	}
+
+	/*
+	 * If no DMA speed was available or the chipset has DMA bugs
+	 * then disable DMA and use PIO
+	 */
+	if (!speed || no_piix_dma)
+		return 0;
 
 	(void) piix_tune_chipset(drive, speed);
 	return ide_dma_enable(drive);
@@ -405,10 +372,8 @@ static int piix_config_drive_xfer_rate (
 
 	if ((id->capability & 1) && drive->autodma) {
 
-		if (ide_use_dma(drive)) {
-			if (piix_config_drive_for_dma(drive))
-				return hwif->ide_dma_on(drive);
-		}
+		if (ide_use_dma(drive) && piix_config_drive_for_dma(drive))
+			return hwif->ide_dma_on(drive);
 
 		goto fast_ata_pio;
 


--------------020502020806040301080106--
