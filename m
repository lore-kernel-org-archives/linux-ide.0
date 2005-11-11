From: Thibaut VARENE <T-Bone@parisc-linux.org>
Subject: Re: [PATCH] Restore support for AEC6285M cards in aec62xx.c
Date: Fri, 11 Nov 2005 17:35:30 +0100
Message-ID: <20051111173530.725484ea@Tatooine.r3z0>
References: <20051029050124.3cee081c@Tatooine.r3z0>
	<58cb370e0511020902r2f031e7ewa9331723d4183e3c@mail.gmail.com>
	<20051106144033.45deb874@Tatooine.r3z0>
	<58cb370e0511100250q319b32eame8112d2412aba659@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=Multipart_Fri__11_Nov_2005_17_35_30_+0100_Jwkezu9giOL_riy3
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2-g19.free.fr ([212.27.42.28]:25026 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750849AbVKKQf5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2005 11:35:57 -0500
In-Reply-To: <58cb370e0511100250q319b32eame8112d2412aba659@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

--Multipart_Fri__11_Nov_2005_17_35_30_+0100_Jwkezu9giOL_riy3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 11 Nov 2005 16:13:57 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On 11/6/05, Thibaut VARENE <T-Bone@parisc-linux.org> wrote:

> Thanks but obvious cleanups and functional changes (conversion
> to use __ide_dma_timout() and PIO fixes) are still mixed.

my bad. I've split the remaining changes in three incremental patches,
hope that's enough granularity ;)

> Just change ->tuneproc() argument in aec62xx_config_drive_xfer_rate()
> from '5' to '255' so best PIO mode will still be tuned correctly.

done

> > > Please note that this code-path is not executed by default
> > > because drive->autotune is set only if DMA base cannot be
> > > obtained (his incorrect because we need PIO to be configured
> > > properly even if DMA is going to be used).  That would be great
> > > if you could also fix this.
> 
> by adding
> 
> hwif->drives[0].autotune = 1;
> hwif->drives[1].autotune = 1;
> 
> to init_hwif_aec62xx() and testing this change
> (please note that it depends on fixing ->tuneproc() discussed earlier)

I removed the wrong 
	if (!hwif->dma_base) {
test

> > patch-1--aec62xxx.c-maccards.diff:
> > - Add missing Macintosh-specific cards initialization sequence
> 
> I will add this to development tree (which will show in -mm kernels
> soon), thanks.

np, you're welcome.

> > - Update aec62xxx_tune_drive()
> > - Update aec62xxx_dma_timeout()
> 
> These should belong to the last patch in the patch series.
> 
> Please also try adding some meaningful descriptions to the patches.

yeah my bad again, i've been a little quick at writing the previous email
:)

The following patches apply on top of 2.6.14+maccards.diff
Built and booted fine.

HTH

T-Bone

PS: please CC me

patch-1-aec62xx.c-remove-dead-code.diff
- remove all dead (#if0'd) code

Signed-off-by: Thibaut VARENE <varenet@parisc-linux.org>

patch-2-aec62xx.c-convert-dma_timeout.diff
- convert aec62xx_irq_timeout() to aec62xx_dma_timeout():
  * removed NOOP code
  * changed 'return 0;' to 'return __ide_dma_timeout(drive);'
  * removed unnecessary hwif->ide_dma_lostirq assignement

Signed-off-by: Thibaut VARENE <varenet@parisc-linux.org>

patch-3-aec62xx.c-fix-tuneproc.diff
- fix a bug in tuneproc logic that would set an incorrect PIO mode
- fix aec62xx_config_drive_xfer_rate() to properly call tuneproc()
- remove unnecessary test in init_hwif_aec62xx(), so that
drives[].autotune is always set to 1

Signed-off-by: Thibaut VARENE <varenet@parisc-linux.org>
--Multipart_Fri__11_Nov_2005_17_35_30_+0100_Jwkezu9giOL_riy3
Content-Type: text/plain; name=patch-1-aec62xx.c-remove-dead-code.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=patch-1-aec62xx.c-remove-dead-code.diff

--- linux-2.6.14/drivers/ide/pci/aec62xx.c.orig	2005-11-06 13:32:50.000000000 +0100
+++ linux-2.6.14/drivers/ide/pci/aec62xx.c	2005-11-11 17:07:30.000000000 +0100
@@ -65,23 +65,6 @@
 #define BUSCLOCK(D)	\
 	((struct chipset_bus_clock_list_entry *) pci_get_drvdata((D)))
 
-#if 0
-		if (dev->device == PCI_DEVICE_ID_ARTOP_ATP850UF) {
-			(void) pci_read_config_byte(dev, 0x54, &art);
-			p += sprintf(p, "DMA Mode:       %s(%s)",
-				(c0&0x20)?((art&0x03)?"UDMA":" DMA"):" PIO",
-				(art&0x02)?"2":(art&0x01)?"1":"0");
-			p += sprintf(p, "          %s(%s)",
-				(c0&0x40)?((art&0x0c)?"UDMA":" DMA"):" PIO",
-				(art&0x08)?"2":(art&0x04)?"1":"0");
-			p += sprintf(p, "         %s(%s)",
-				(c1&0x20)?((art&0x30)?"UDMA":" DMA"):" PIO",
-				(art&0x20)?"2":(art&0x10)?"1":"0");
-			p += sprintf(p, "           %s(%s)\n",
-				(c1&0x40)?((art&0xc0)?"UDMA":" DMA"):" PIO",
-				(art&0x80)?"2":(art&0x40)?"1":"0");
-		} else {
-#endif
 
 /*
  * TO DO: active tuning and correction of cards without a bios.
@@ -112,13 +95,9 @@
 	switch(hwif->pci_dev->device) {
 		case PCI_DEVICE_ID_ARTOP_ATP865:
 		case PCI_DEVICE_ID_ARTOP_ATP865R:
-#if 0
-			mode = (hwif->INB(hwif->dma_master) & 0x10) ? 4 : 3;
-#else
 			mode = (hwif->INB(((hwif->channel) ?
 					hwif->mate->dma_status :
 					hwif->dma_status)) & 0x10) ? 4 : 3;
-#endif
 			break;
 		case PCI_DEVICE_ID_ARTOP_ATP860:
 		case PCI_DEVICE_ID_ARTOP_ATP860R:
@@ -263,35 +242,9 @@
 		case PCI_DEVICE_ID_ARTOP_ATP865:
 		case PCI_DEVICE_ID_ARTOP_ATP865R:
 			printk(" AEC62XX time out ");
-#if 0
-			{
-				int i = 0;
-				u8 reg49h = 0;
-				pci_read_config_byte(HWIF(drive)->pci_dev, 0x49, &reg49h);
-				for (i=0;i<256;i++)
-					pci_write_config_byte(HWIF(drive)->pci_dev, 0x49, reg49h|0x10);
-				pci_write_config_byte(HWIF(drive)->pci_dev, 0x49, reg49h & ~0x10);
-			}
-			return 0;
-#endif
 		default:
 			break;
 	}
-#if 0
-	{
-		ide_hwif_t *hwif	= HWIF(drive);
-		struct pci_dev *dev	= hwif->pci_dev;
-		u8 tmp1 = 0, tmp2 = 0, mode6 = 0;
-
-		pci_read_config_byte(dev, 0x44, &tmp1);
-		pci_read_config_byte(dev, 0x45, &tmp2);
-		printk(" AEC6280 r44=%x r45=%x ",tmp1,tmp2);
-		mode6 = HWIF(drive)->INB(((hwif->channel) ?
-					   hwif->mate->dma_status :
-					   hwif->dma_status));
-		printk(" AEC6280 133=%x ", (mode6 & 0x10));
-	}
-#endif
 	return 0;
 }
 

--Multipart_Fri__11_Nov_2005_17_35_30_+0100_Jwkezu9giOL_riy3
Content-Type: text/plain; name=patch-2-aec62xx.c-convert-dma_timeout.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=patch-2-aec62xx.c-convert-dma_timeout.diff

--- linux-2.6.14/drivers/ide/pci/aec62xx.c.orig	2005-11-11 17:07:30.000000000 +0100
+++ linux-2.6.14/drivers/ide/pci/aec62xx.c	2005-11-11 17:11:57.000000000 +0100
@@ -231,21 +231,9 @@
 	return 0;
 }
 
-static int aec62xx_irq_timeout (ide_drive_t *drive)
+static int aec62xx_dma_timeout (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif	= HWIF(drive);
-	struct pci_dev *dev	= hwif->pci_dev;
-
-	switch(dev->device) {
-		case PCI_DEVICE_ID_ARTOP_ATP860:
-		case PCI_DEVICE_ID_ARTOP_ATP860R:
-		case PCI_DEVICE_ID_ARTOP_ATP865:
-		case PCI_DEVICE_ID_ARTOP_ATP865R:
-			printk(" AEC62XX time out ");
-		default:
-			break;
-	}
-	return 0;
+	return __ide_dma_timeout(drive);
 }
 
 static unsigned int __devinit init_chipset_aec62xx(struct pci_dev *dev, const char *name)
@@ -305,8 +293,7 @@
 	hwif->swdma_mask = 0x07;
 
 	hwif->ide_dma_check	= &aec62xx_config_drive_xfer_rate;
-	hwif->ide_dma_lostirq	= &aec62xx_irq_timeout;
-	hwif->ide_dma_timeout	= &aec62xx_irq_timeout;
+	hwif->ide_dma_timeout	= &aec62xx_dma_timeout;
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->autodma;

--Multipart_Fri__11_Nov_2005_17_35_30_+0100_Jwkezu9giOL_riy3
Content-Type: text/plain; name=patch-3-aec62xx.c-fix-tuneproc.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=patch-3-aec62xx.c-fix-tuneproc.diff

--- linux-2.6.14/drivers/ide/pci/aec62xx.c.orig	2005-11-11 17:28:12.000000000 +0100
+++ linux-2.6.14/drivers/ide/pci/aec62xx.c	2005-11-11 17:30:32.000000000 +0100
@@ -194,17 +194,8 @@
 
 static void aec62xx_tune_drive (ide_drive_t *drive, u8 pio)
 {
-	u8 speed = 0;
-	u8 new_pio = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
+	u8 speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, pio, 4, NULL);
 
-	switch(pio) {
-		case 5:		speed = new_pio; break;
-		case 4:		speed = XFER_PIO_4; break;
-		case 3:		speed = XFER_PIO_3; break;
-		case 2:		speed = XFER_PIO_2; break;
-		case 1:		speed = XFER_PIO_1; break;
-		default:	speed = XFER_PIO_0; break;
-	}
 	(void) aec62xx_tune_chipset(drive, speed);
 }
 
@@ -224,7 +215,7 @@
 
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		aec62xx_tune_drive(drive, 5);
+		aec62xx_tune_drive(drive, 255);
 		return hwif->ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
@@ -282,11 +273,8 @@
 	if (hwif->mate)
 		hwif->mate->serialized = hwif->serialized;
 
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
-		return;
-	}
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].autotune = 1;
 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;

--Multipart_Fri__11_Nov_2005_17_35_30_+0100_Jwkezu9giOL_riy3--
