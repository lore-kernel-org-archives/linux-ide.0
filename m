From: Thibaut VARENE <T-Bone@parisc-linux.org>
Subject: [PATCH] Restore support for AEC6285M cards in aec62xx.c
Date: Sat, 29 Oct 2005 05:01:24 +0200
Message-ID: <20051029050124.3cee081c@Tatooine.r3z0>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=Multipart_Sat__29_Oct_2005_05_01_24_+0200_lXBRK.mqdIPvozco
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2-g19.free.fr ([212.27.42.28]:58840 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751108AbVJ2DAS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Oct 2005 23:00:18 -0400
Received: from mail.zigoo.net (freebz.slashdirt.org [82.228.130.181])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 7828351BED
	for <linux-ide@vger.kernel.org>; Sat, 29 Oct 2005 05:00:17 +0200 (CEST)
Received: from Tatooine.r3z0 (Tatooine.r3z0 [192.168.69.3])
	by mail.zigoo.net (Postfix) with ESMTP id 34B5833C8F
	for <linux-ide@vger.kernel.org>; Sat, 29 Oct 2005 05:00:04 +0200 (CEST)
Received: from localhost
	([127.0.0.1] helo=Tatooine.r3z0 ident=varenet)
	by Tatooine.r3z0 with esmtp (Exim 3.36 #1 (Debian))
	id 1EVgyC-0007ph-00
	for <linux-ide@vger.kernel.org>; Sat, 29 Oct 2005 05:01:24 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Multipart_Sat__29_Oct_2005_05_01_24_+0200_lXBRK.mqdIPvozco
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

Following my previous mail, here's the explanation for the "almost works"
statement:

Once i somewhat solved the badness in pmac ide code, the aec62xx would
have trouble dealing with my AEC6285M "Macintosh" card:

AEC6280R: IDE controller at PCI slot 0001:11:03.0
AEC6280R: chipset revision 7
AEC6280R: ROM enabled at 0x800a0000
AEC6280R: 100% native mode on irq 53
    ide3: BM-DMA at 0x1000-0x1007, BIOS settings: hdg:pio, hdh:pio
    ide4: BM-DMA at 0x1008-0x100f, BIOS settings: hdi:pio, hdj:pio
Probing IDE interface ide3...
hdg: Maxtor 7Y250P0, ATA DISK drive
hdh: ST3120026A, ATA DISK drive
ide3 at 0x10b0-0x10b7,0x10a2 on irq 53
hdg: max request size: 1024KiB
hdg: lost interrupt
hdg: lost interrupt
hdg: lost interrupt
hdg: lost interrupt
hdg: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63,
UDMA(100) hdg: lost interrupt
hdg: cache flushes supported
 hdg:<4>hdg: dma_timer_expiry: dma status == 0x64
hdg: DMA interrupt recovery
hdg: lost interrupt
 [mac] hdg1 hdg2 hdg3 hdg4
hdg: lost interrupt
hdh: max request size: 1024KiB
hdh: lost interrupt
hdh: lost interrupt
hdh: lost interrupt
hdh: lost interrupt
hdh: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100) hdh: lost interrupt
hdh: cache flushes supported
 hdh:<4>hdh: dma_timer_expiry: dma status == 0x64
hdh: DMA interrupt recovery
hdh: lost interrupt
 [mac] hdh1 hdh2 hdh3 hdh4

I tested the card and driver on a x86 box and ended up with the exact same
problem. After some investigation, and thanks to the help of Benh, it
appeared that some previously existing initialisation code has
been removed from the driver, making it unable to deal with that type of
cards.

The attached patch restore the original code, and I took the opportunity
to do a very limited cleanup. What's ought to be mentioned is that the
aec62xx_dma_timeout() does actually nothing (it's all #if 0'd), so I think
it can be safely either removed or commented out for debugging purpose,
and the remaing hwif->dma_timeout assignement can be removed from
init_hwif_aec62xx(). I can produce another patch to do that if needed.

With the attached patch, the card works again just fine with very decent
performance:

AEC6280R: IDE controller at PCI slot 0001:11:03.0
AEC6280R: chipset revision 7
AEC6280R: ROM enabled at 0x800a0000
AEC6280R: 100% native mode on irq 53
    ide3: BM-DMA at 0x1000-0x1007, BIOS settings: hdg:pio, hdh:pio
    ide4: BM-DMA at 0x1008-0x100f, BIOS settings: hdi:pio, hdj:pio
Probing IDE interface ide3...
hdg: Maxtor 7Y250P0, ATA DISK drive
hdh: ST3120026A, ATA DISK drive
ide3 at 0x10b0-0x10b7,0x10a2 on irq 53
hdg: max request size: 1024KiB
hdg: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63,
UDMA(100) hdg: cache flushes supported
 hdg: [mac] hdg1 hdg2 hdg3 hdg4
hdh: max request size: 1024KiB
hdh: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(100) hdh: cache flushes supported
 hdh: [mac] hdh1 hdh2 hdh3 hdh4
Probing IDE interface ide4...

/dev/hdh:
 Timing cached reads:   956 MB in  2.01 seconds = 476.10 MB/sec
 Timing buffered disk reads:  124 MB in  3.04 seconds =  40.79 MB/sec

HTH

T-Bone

PS: please CC me in answers

Signed-off-by: Thibaut VARENE <varenet@parisc-linux.org>
--Multipart_Sat__29_Oct_2005_05_01_24_+0200_lXBRK.mqdIPvozco
Content-Type: text/plain; name=aec62xx.c.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=aec62xx.c.diff

--- linux-2.6.14-rc5.old/drivers/ide/pci/aec62xx.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc5.new/drivers/ide/pci/aec62xx.c	2005-10-29 04:24:07.000000000 +0200
@@ -204,28 +204,22 @@
 
 static int config_chipset_for_dma (ide_drive_t *drive)
 {
+	ide_hwif_t *hwif	= HWIF(drive);
 	u8 speed = ide_dma_speed(drive, aec62xx_ratemask(drive));	
 
-	if (!(speed))
+	if (!(speed)) {
+		hwif->tuneproc(drive, 5);
 		return 0;
+	}
 
-	(void) aec62xx_tune_chipset(drive, speed);
+	(void) hwif->speedproc(drive, speed);
 	return ide_dma_enable(drive);
 }
 
 static void aec62xx_tune_drive (ide_drive_t *drive, u8 pio)
 {
 	u8 speed = 0;
-	u8 new_pio = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
-
-	switch(pio) {
-		case 5:		speed = new_pio; break;
-		case 4:		speed = XFER_PIO_4; break;
-		case 3:		speed = XFER_PIO_3; break;
-		case 2:		speed = XFER_PIO_2; break;
-		case 1:		speed = XFER_PIO_1; break;
-		default:	speed = XFER_PIO_0; break;
-	}
+	speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, pio, NULL);
 	(void) aec62xx_tune_chipset(drive, speed);
 }
 
@@ -252,7 +246,7 @@
 	return 0;
 }
 
-static int aec62xx_irq_timeout (ide_drive_t *drive)
+static int aec62xx_dma_timeout(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
@@ -262,8 +256,8 @@
 		case PCI_DEVICE_ID_ARTOP_ATP860R:
 		case PCI_DEVICE_ID_ARTOP_ATP865:
 		case PCI_DEVICE_ID_ARTOP_ATP865R:
-			printk(" AEC62XX time out ");
 #if 0
+			printk(" AEC62XX time out ");
 			{
 				int i = 0;
 				u8 reg49h = 0;
@@ -292,7 +286,7 @@
 		printk(" AEC6280 133=%x ", (mode6 & 0x10));
 	}
 #endif
-	return 0;
+	return __ide_dma_timeout(drive);
 }
 
 static unsigned int __devinit init_chipset_aec62xx(struct pci_dev *dev, const char *name)
@@ -337,8 +331,7 @@
 	hwif->swdma_mask = 0x07;
 
 	hwif->ide_dma_check	= &aec62xx_config_drive_xfer_rate;
-	hwif->ide_dma_lostirq	= &aec62xx_irq_timeout;
-	hwif->ide_dma_timeout	= &aec62xx_irq_timeout;
+	hwif->ide_dma_timeout	= &aec62xx_dma_timeout;
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->autodma;
@@ -386,6 +379,21 @@
 			strcpy(d->name, "AEC6280R");
 	}
 
+	/* These are necessary to get AEC6280 Macintosh cards to work */
+	if ((dev->device == PCI_DEVICE_ID_ARTOP_ATP865) ||
+	    (dev->device == PCI_DEVICE_ID_ARTOP_ATP865R)) {
+		u8 reg49h = 0, reg4ah = 0;
+		/* Clear reset and test bits.  */
+		pci_read_config_byte(dev, 0x49, &reg49h);
+		pci_write_config_byte(dev, 0x49, reg49h & ~0x30);
+		/* Enable chip interrupt output.  */
+		pci_read_config_byte(dev, 0x4a, &reg4ah);
+		pci_write_config_byte(dev, 0x4a, reg4ah & ~0x01);
+		/* Enable burst mode. */
+		pci_read_config_byte(dev, 0x4a, &reg4ah);
+		pci_write_config_byte(dev, 0x4a, reg4ah | 0x80);
+	}
+
 	return ide_setup_pci_device(dev, d);
 }
 

--Multipart_Sat__29_Oct_2005_05_01_24_+0200_lXBRK.mqdIPvozco--
