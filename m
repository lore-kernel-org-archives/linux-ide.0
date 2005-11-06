From: Thibaut VARENE <T-Bone@parisc-linux.org>
Subject: Re: [PATCH] Restore support for AEC6285M cards in aec62xx.c
Date: Sun, 6 Nov 2005 14:40:33 +0100
Message-ID: <20051106144033.45deb874@Tatooine.r3z0>
References: <20051029050124.3cee081c@Tatooine.r3z0>
	<58cb370e0511020902r2f031e7ewa9331723d4183e3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__6_Nov_2005_14_40_33_+0100_//LZpa/DLRBoqV_Q"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2-g19.free.fr ([212.27.42.28]:2005 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750832AbVKFNkw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Nov 2005 08:40:52 -0500
In-Reply-To: <58cb370e0511020902r2f031e7ewa9331723d4183e3c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

--Multipart_Sun__6_Nov_2005_14_40_33_+0100_//LZpa/DLRBoqV_Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Sun, 06 Nov 2005 14:25:40 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> Hi,
> 
> On 10/29/05, Thibaut VARENE <T-Bone@parisc-linux.org> wrote:

> > The attached patch restore the original code, and I took the
opportunity
> > to do a very limited cleanup. What's ought to be mentioned is that the
> > aec62xx_dma_timeout() does actually nothing (it's all #if 0'd), so I
think
> > it can be safely either removed or commented out for debugging
purpose,
> > and the remaing hwif->dma_timeout assignement can be removed from
> > init_hwif_aec62xx(). I can produce another patch to do that if needed.
> 
> Please do so (remove dead code) but leave empty ae62xx_dma_timeout()
> and do the change from aec62xx_dma_timeout() -> __ide_dma_timeout()
> in the other patch.

done in patch-2-aec62xxx.c-cleanup.diff

>   static void aec62xx_tune_drive (ide_drive_t *drive, u8 pio)
>  {
>  	u8 speed = 0;
> -	u8 new_pio = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5,
NULL);
> -
> -	switch(pio) {
> -		case 5:		speed = new_pio; break;
> -		case 4:		speed = XFER_PIO_4; break;
> -		case 3:		speed = XFER_PIO_3; break;
> -		case 2:		speed = XFER_PIO_2; break;
> -		case 1:		speed = XFER_PIO_1; break;
> -		default:	speed = XFER_PIO_0; break;
> -	}
> +	speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, pio, NULL);
> 
> This should be ide_get_best_pio_mode(drive, pio, 4, NULL)

ACK

> 2-nd argument is PIO mode wanted (255 == best one)
> 3-rd argument is max PIO mode supported by controller
> 
> and you should fix ->tuneproc() in aec62xx_config_drive_xfer_rate()
instead.

That I'm not sure how to do. This is the first time I have a look at the
IDE layer, so I'm not really "at ease"...

> This will also fix three other bugs:
> - user wants to ->tuneproc() best PIO but instead PIO 0 is tuned
> - user wants to ->tuneproc() PIO 5 but instead best PIO is tuned
> - user wants to ->speedproc() PIO 5 but chipset is configured for
>   PIO 0 (PCI == 33 MHz) or incorrect PIO timing (PCI == 34 MHz)
> 
> Please note that this code-path is not executed by default
> because drive->autotune is set only if DMA base cannot be
> obtained (his incorrect because we need PIO to be configured
> properly even if DMA is going to be used).  That would be great
> if you could also fix this.

> +	/* These are necessary to get AEC6280 Macintosh cards to work */
> +	if ((dev->device == PCI_DEVICE_ID_ARTOP_ATP865) ||
> +	    (dev->device == PCI_DEVICE_ID_ARTOP_ATP865R)) {
> +		u8 reg49h = 0, reg4ah = 0;
> +		/* Clear reset and test bits.  */
> +		pci_read_config_byte(dev, 0x49, &reg49h);
> +		pci_write_config_byte(dev, 0x49, reg49h & ~0x30);
> +		/* Enable chip interrupt output.  */
> +		pci_read_config_byte(dev, 0x4a, &reg4ah);
> +		pci_write_config_byte(dev, 0x4a, reg4ah & ~0x01);
> +		/* Enable burst mode. */
> +		pci_read_config_byte(dev, 0x4a, &reg4ah);
> +		pci_write_config_byte(dev, 0x4a, reg4ah | 0x80);
> +	}
> 
> This belongs to init_chipset_aec62xx().
> 
> I suppose that this is the part which makes the driver work for you?
> Could you separate it into another patch?

Done, in patch-1-aec62xxx.c-maccards.diff

As the name suggests, these two patches are incremental.

HTH

T-Bone

PS: Please CC me

patch-1--aec62xxx.c-maccards.diff:
- Add missing Macintosh-specific cards initialization sequence

Signed-off-by: Thibaut VARENE <varenet@parisc-linux.org>

patch-2-aec62xxx.c-cleanup.diff:
- Remove dead code
- Update aec62xxx_tune_drive()
- Update aec62xxx_dma_timeout()

Signed-off-by: Thibaut VARENE <varenet@parisc-linux.org>
--Multipart_Sun__6_Nov_2005_14_40_33_+0100_//LZpa/DLRBoqV_Q
Content-Type: text/plain; name=patch-1-aec62xx.c-maccards.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=patch-1-aec62xx.c-maccards.diff

--- linux-2.6.14/drivers/ide/pci/aec62xx.c.orig	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14/drivers/ide/pci/aec62xx.c	2005-11-06 13:14:22.000000000 +0100
@@ -309,6 +309,21 @@
 	else
 		pci_set_drvdata(dev, (void *) aec6xxx_34_base);
 
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
 	return dev->irq;
 }
 

--Multipart_Sun__6_Nov_2005_14_40_33_+0100_//LZpa/DLRBoqV_Q
Content-Type: text/plain; name=patch-2-aec62xx.c-cleanup.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=patch-2-aec62xx.c-cleanup.diff

--- linux-2.6.14/drivers/ide/pci/aec62xx.c.orig	2005-11-06 13:32:50.000000000 +0100
+++ linux-2.6.14/drivers/ide/pci/aec62xx.c	2005-11-06 13:31:04.000000000 +0100
@@ -65,24 +65,6 @@
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
-
 /*
  * TO DO: active tuning and correction of cards without a bios.
  */
@@ -112,13 +94,9 @@
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
@@ -215,17 +193,8 @@
 
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
 
@@ -252,47 +221,9 @@
 	return 0;
 }
 
-static int aec62xx_irq_timeout (ide_drive_t *drive)
+static int aec62xx_dma_timeout(ide_drive_t *drive)
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
-		default:
-			break;
-	}
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
-	return 0;
+	return __ide_dma_timeout(drive);
 }
 
 static unsigned int __devinit init_chipset_aec62xx(struct pci_dev *dev, const char *name)
@@ -352,8 +283,7 @@
 	hwif->swdma_mask = 0x07;
 
 	hwif->ide_dma_check	= &aec62xx_config_drive_xfer_rate;
-	hwif->ide_dma_lostirq	= &aec62xx_irq_timeout;
-	hwif->ide_dma_timeout	= &aec62xx_irq_timeout;
+	hwif->ide_dma_timeout	= &aec62xx_dma_timeout;
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->autodma;

--Multipart_Sun__6_Nov_2005_14_40_33_+0100_//LZpa/DLRBoqV_Q--
