From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 12/15] ide: remove ->dma_master field from ide_hwif_t
Date: Wed, 24 Oct 2007 23:24:52 +0200
Message-ID: <200710242324.53080.bzolnier@gmail.com>
References: <200710012339.39304.bzolnier@gmail.com> <200710082303.58761.bzolnier@gmail.com> <47179309.1090906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:14891 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbXJXXce (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 19:32:34 -0400
Received: by nf-out-0910.google.com with SMTP id g13so325232nfb
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 16:32:32 -0700 (PDT)
In-Reply-To: <47179309.1090906@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org


Hi,

On Thursday 18 October 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>>Index: b/drivers/ide/pci/hpt366.c
> >>>>===================================================================
> >>>>--- a/drivers/ide/pci/hpt366.c
> >>>>+++ b/drivers/ide/pci/hpt366.c
> >>>>@@ -845,32 +845,33 @@ static int hpt374_ide_dma_end(ide_drive_
> 
> >>>   This just asks to be:
> 
> >>    No, it doesn't cause that way one would only break it.
> 
> >>>> static void hpt3xxn_set_clock(ide_hwif_t *hwif, u8 mode)
> >>>> {
> 
> >>>    unsigned long base = hwif->extra_base;
> 
> >>    Sorry for a thinko. All offsets below shoud be really 0x6x, not 0x5x...
> 
> > Here we go again... :)
> 
> > [PATCH] ide: remove ->dma_master field from ide_hwif_t (take 4)
> 
> > * Convert cmd64x, hpt366 and pdc202xx_old host drivers to use
> >   pci_resource_start(hwif->pci_dev, 4) instead of hwif->dma_master.
> 
> > * Remove no longer needed ->dma_master field from ide_hwif_t.
> 
> > v2:
> > * Use the more readable 'hwif->dma_base - (hwif->channel * 8)' instead of
> >   pci_resource_start(hwif->pci_dev, 4).
> 
> > v3:
> > * Use hwif->extra_base in hpt366/pdc20xx_old + some cosmetic fixups over v2
> >   (suggested by Sergei).
> 
>     Huh? I don't see where you're using extra_base in hpt366.c

Doh, somebody hand me brown paper bag, please...

> > v4:
> > * Correct offsets in hpt3xxn_set_clock().
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>     Unfortunately, I have to NAK the patch... :-/
> 
> > Index: b/drivers/ide/pci/hpt366.c
> > ===================================================================
> > --- a/drivers/ide/pci/hpt366.c
> > +++ b/drivers/ide/pci/hpt366.c
> > @@ -845,32 +845,33 @@ static int hpt374_ide_dma_end(ide_drive_
> >  
> >  static void hpt3xxn_set_clock(ide_hwif_t *hwif, u8 mode)
> >  {
> > -	u8 scr2 = inb(hwif->dma_master + 0x7b);
> > +	unsigned long base = hwif->dma_base - (hwif->channel * 8);
> 
>     Should be hwif->extra_base - 0x10 or else the following code will touch 
> all the wrong/reserved registers; one also can use hwif->extra_base ISO 'base' 
> and change all the offsets to 0x6x...

Well, I updated all offsets but I somehow forgot about updating 'base'. :)

> > +	u8 scr2 = inb(base + 0x6b);
> >  
> >  	if ((scr2 & 0x7f) == mode)
> >  		return;
> >  
> >  	/* Tristate the bus */
> > -	outb(0x80, hwif->dma_master + 0x73);
> > -	outb(0x80, hwif->dma_master + 0x77);
> > +	outb(0x80, base + 0x63);
> > +	outb(0x80, base + 0x67);
> 
> >  	/* Switch clock and reset channels */
> > -	outb(mode, hwif->dma_master + 0x7b);
> > -	outb(0xc0, hwif->dma_master + 0x79);
> > +	outb(mode, base + 0x6b);
> > +	outb(0xc0, base + 0x69);
> >  
> >  	/*
> >  	 * Reset the state machines.
> >  	 * NOTE: avoid accidentally enabling the disabled channels.
> >  	 */
> > -	outb(inb(hwif->dma_master + 0x70) | 0x32, hwif->dma_master + 0x70);
> > -	outb(inb(hwif->dma_master + 0x74) | 0x32, hwif->dma_master + 0x74);
> > +	outb(inb(base + 0x60) | 0x32, base + 0x60);
> > +	outb(inb(base + 0x64) | 0x32, base + 0x64);
> >  
> >  	/* Complete reset */
> > -	outb(0x00, hwif->dma_master + 0x79);
> > +	outb(0x00, base + 0x69);
> >  
> >  	/* Reconnect channels to bus */
> > -	outb(0x00, hwif->dma_master + 0x73);
> > -	outb(0x00, hwif->dma_master + 0x77);
> > +	outb(0x00, base + 0x63);
> > +	outb(0x00, base + 0x67);
> >  }
> 
>     Huh? That's wrong -- if you're setting base to the value of the former 
> value of hwof->dma_master, the register offsets shouldn't change!
> 
> > Index: b/drivers/ide/pci/pdc202xx_old.c
> > ===================================================================
> > --- a/drivers/ide/pci/pdc202xx_old.c
> > +++ b/drivers/ide/pci/pdc202xx_old.c
> > @@ -193,7 +193,7 @@ static void pdc202xx_old_ide_dma_start(i
> >  	if (drive->media != ide_disk || drive->addressing == 1) {
> >  		struct request *rq	= HWGROUP(drive)->rq;
> >  		ide_hwif_t *hwif	= HWIF(drive);
> > -		unsigned long high_16   = hwif->dma_master;
> > +		unsigned long high_16	= hwif->extra_base - 16;
> >  		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
> 
>     That 'high_16' is *not* a good name in this case -- it would've been if we 
> didn't subtract 16. So, I'd wrote:
> 
>   		unsigned long atapi_reg	= hwif->extra_base +
> 					 (hwif->channel ? 0x14 : 0x10);

'high_16' is used for more than 'atapi_reg' (same is true for other places
defining 'high_16' local variable).  With five revisions of this patch
needed to hopefully, finally get it right I prefer to defer futher cleanups
to the incremental patches (*hint*).


[PATCH] ide: remove ->dma_master field from ide_hwif_t (take 5)

* Convert cmd64x, hpt366 and pdc202xx_old host drivers to use
  pci_resource_start(hwif->pci_dev, 4) instead of hwif->dma_master.

* Remove no longer needed ->dma_master field from ide_hwif_t.

v2:
* Use the more readable 'hwif->dma_base - (hwif->channel * 8)' instead of
  pci_resource_start(hwif->pci_dev, 4).

v3:
* Use hwif->extra_base in hpt366/pdc20xx_old + some cosmetic fixups over v2
  (suggested by Sergei).

v4:
* Correct offsets in hpt3xxn_set_clock().

v5:
* Use hwif->extra_base in hpt366 for _real_ this time. (Noticed by Sergei)

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c          |    7 -------
 drivers/ide/ide.c              |    2 --
 drivers/ide/pci/cmd64x.c       |    8 +++++---
 drivers/ide/pci/hpt366.c       |   21 +++++++++++----------
 drivers/ide/pci/pdc202xx_old.c |   12 ++++++------
 include/linux/ide.h            |    1 -
 6 files changed, 22 insertions(+), 29 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -1002,11 +1002,6 @@ void ide_setup_dma(ide_hwif_t *hwif, uns
 
 	hwif->dma_base = base;
 
-	if (hwif->mate)
-		hwif->dma_master = hwif->channel ? hwif->mate->dma_base : base;
-	else
-		hwif->dma_master = base;
-
 	if (!(hwif->dma_command))
 		hwif->dma_command	= hwif->dma_base;
 	if (!(hwif->dma_vendor1))
@@ -1048,8 +1043,6 @@ void ide_setup_dma(ide_hwif_t *hwif, uns
 		       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
 	}
 	printk("\n");
-
-	BUG_ON(!hwif->dma_master);
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_dma);
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -468,7 +468,6 @@ static void ide_hwif_restore(ide_hwif_t 
 #endif
 
 	hwif->dma_base			= tmp_hwif->dma_base;
-	hwif->dma_master		= tmp_hwif->dma_master;
 	hwif->dma_command		= tmp_hwif->dma_command;
 	hwif->dma_vendor1		= tmp_hwif->dma_vendor1;
 	hwif->dma_status		= tmp_hwif->dma_status;
@@ -602,7 +601,6 @@ void ide_unregister(unsigned int index)
 		(void) ide_release_dma(hwif);
 
 		hwif->dma_base = 0;
-		hwif->dma_master = 0;
 		hwif->dma_command = 0;
 		hwif->dma_vendor1 = 0;
 		hwif->dma_status = 0;
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -333,13 +333,14 @@ static void cmd64x_set_dma_mode(ide_driv
 static int cmd648_ide_dma_end (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
+	unsigned long base	= hwif->dma_base - (hwif->channel * 8);
 	int err			= __ide_dma_end(drive);
 	u8  irq_mask		= hwif->channel ? MRDMODE_INTR_CH1 :
 						  MRDMODE_INTR_CH0;
-	u8  mrdmode		= inb(hwif->dma_master + 0x01);
+	u8  mrdmode		= inb(base + 1);
 
 	/* clear the interrupt bit */
-	outb(mrdmode | irq_mask, hwif->dma_master + 0x01);
+	outb(mrdmode | irq_mask, base + 1);
 
 	return err;
 }
@@ -364,10 +365,11 @@ static int cmd64x_ide_dma_end (ide_drive
 static int cmd648_ide_dma_test_irq (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
+	unsigned long base	= hwif->dma_base - (hwif->channel * 8);
 	u8 irq_mask		= hwif->channel ? MRDMODE_INTR_CH1 :
 						  MRDMODE_INTR_CH0;
 	u8 dma_stat		= inb(hwif->dma_status);
-	u8 mrdmode		= inb(hwif->dma_master + 0x01);
+	u8 mrdmode		= inb(base + 1);
 
 #ifdef DEBUG
 	printk("%s: dma_stat: 0x%02x mrdmode: 0x%02x irq_mask: 0x%02x\n",
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -845,32 +845,33 @@ static int hpt374_ide_dma_end(ide_drive_
 
 static void hpt3xxn_set_clock(ide_hwif_t *hwif, u8 mode)
 {
-	u8 scr2 = inb(hwif->dma_master + 0x7b);
+	unsigned long base = hwif->extra_base;
+	u8 scr2 = inb(base + 0x6b);
 
 	if ((scr2 & 0x7f) == mode)
 		return;
 
 	/* Tristate the bus */
-	outb(0x80, hwif->dma_master + 0x73);
-	outb(0x80, hwif->dma_master + 0x77);
+	outb(0x80, base + 0x63);
+	outb(0x80, base + 0x67);
 
 	/* Switch clock and reset channels */
-	outb(mode, hwif->dma_master + 0x7b);
-	outb(0xc0, hwif->dma_master + 0x79);
+	outb(mode, base + 0x6b);
+	outb(0xc0, base + 0x69);
 
 	/*
 	 * Reset the state machines.
 	 * NOTE: avoid accidentally enabling the disabled channels.
 	 */
-	outb(inb(hwif->dma_master + 0x70) | 0x32, hwif->dma_master + 0x70);
-	outb(inb(hwif->dma_master + 0x74) | 0x32, hwif->dma_master + 0x74);
+	outb(inb(base + 0x60) | 0x32, base + 0x60);
+	outb(inb(base + 0x64) | 0x32, base + 0x64);
 
 	/* Complete reset */
-	outb(0x00, hwif->dma_master + 0x79);
+	outb(0x00, base + 0x69);
 
 	/* Reconnect channels to bus */
-	outb(0x00, hwif->dma_master + 0x73);
-	outb(0x00, hwif->dma_master + 0x77);
+	outb(0x00, base + 0x63);
+	outb(0x00, base + 0x67);
 }
 
 /**
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -162,7 +162,7 @@ static u8 pdc202xx_old_cable_detect (ide
  */
 static void pdc_old_enable_66MHz_clock(ide_hwif_t *hwif)
 {
-	unsigned long clock_reg = hwif->dma_master + 0x11;
+	unsigned long clock_reg = hwif->extra_base + 0x01;
 	u8 clock = inb(clock_reg);
 
 	outb(clock | (hwif->channel ? 0x08 : 0x02), clock_reg);
@@ -170,7 +170,7 @@ static void pdc_old_enable_66MHz_clock(i
 
 static void pdc_old_disable_66MHz_clock(ide_hwif_t *hwif)
 {
-	unsigned long clock_reg = hwif->dma_master + 0x11;
+	unsigned long clock_reg = hwif->extra_base + 0x01;
 	u8 clock = inb(clock_reg);
 
 	outb(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
@@ -193,7 +193,7 @@ static void pdc202xx_old_ide_dma_start(i
 	if (drive->media != ide_disk || drive->addressing == 1) {
 		struct request *rq	= HWGROUP(drive)->rq;
 		ide_hwif_t *hwif	= HWIF(drive);
-		unsigned long high_16   = hwif->dma_master;
+		unsigned long high_16	= hwif->extra_base - 16;
 		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
 		u32 word_count	= 0;
 		u8 clock = inb(high_16 + 0x11);
@@ -212,7 +212,7 @@ static int pdc202xx_old_ide_dma_end(ide_
 {
 	if (drive->media != ide_disk || drive->addressing == 1) {
 		ide_hwif_t *hwif	= HWIF(drive);
-		unsigned long high_16	= hwif->dma_master;
+		unsigned long high_16	= hwif->extra_base - 16;
 		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
 		u8 clock		= 0;
 
@@ -228,7 +228,7 @@ static int pdc202xx_old_ide_dma_end(ide_
 static int pdc202xx_old_ide_dma_test_irq(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
-	unsigned long high_16	= hwif->dma_master;
+	unsigned long high_16	= hwif->extra_base - 16;
 	u8 dma_stat		= inb(hwif->dma_status);
 	u8 sc1d			= inb(high_16 + 0x001d);
 
@@ -271,7 +271,7 @@ static void pdc202xx_dma_timeout(ide_dri
 
 static void pdc202xx_reset_host (ide_hwif_t *hwif)
 {
-	unsigned long high_16	= hwif->dma_master;
+	unsigned long high_16	= hwif->extra_base - 16;
 	u8 udma_speed_flag	= inb(high_16 | 0x001f);
 
 	outb(udma_speed_flag | 0x10, high_16 | 0x001f);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -766,7 +766,6 @@ typedef struct hwif_s {
 	int		rqsize;		/* max sectors per request */
 	int		irq;		/* our irq number */
 
-	unsigned long	dma_master;	/* reference base addr dmabase */
 	unsigned long	dma_base;	/* base addr for dma ports */
 	unsigned long	dma_command;	/* dma command register */
 	unsigned long	dma_vendor1;	/* dma vendor 1 register */
