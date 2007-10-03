From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 12/15] ide: remove ->dma_master field from ide_hwif_t
Date: Thu, 4 Oct 2007 00:27:18 +0200
Message-ID: <200710040027.18532.bzolnier@gmail.com>
References: <200710012339.39304.bzolnier@gmail.com> <200710022324.01132.bzolnier@gmail.com> <47039024.3090705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:53979 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbXJCWhs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 18:37:48 -0400
Received: by mu-out-0910.google.com with SMTP id i10so7656619mue
        for <linux-ide@vger.kernel.org>; Wed, 03 Oct 2007 15:37:45 -0700 (PDT)
In-Reply-To: <47039024.3090705@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Wednesday 03 October 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>>>* Convert cmd64x, hpt366 and pdc202xx_old host drivers to use
> >>>>>  pci_resource_start(hwif->pci_dev, 4) instead of hwif->dma_master.
> 
> >>>>Before using pci_resource_start(), the code should check 
> >>>>pci_resource_len() to ensure it is the appropriate size.
> 
> >>>>It would be very wise to ensure that pci_resource_flags()&IORESOURCE_IO 
> >>>>is true, too.
> 
> >>>Sure but since the old code hasn't been doing these checks (old code
> >>>just did pci_resource_start() -> hwif->dma_base -> hwif->dma_master)
> >>>this is a separate issue from what the patch tries to achieve.
> 
> >>Nonetheless this is duplicating an existing bug $N times... not ideal :)
> 
> > The existing bug is that the methods converted to use pci_resource_start()
> > may be set in hwif instance and used even if the BAR4 is invalid.  Therefore
> > the above patch is correct and it isn't duplicating the existing bug. :)
> 
> > However I agree that all these pci_resource_start()s could be a bit confusing
> > so here is 'take 2'.
> 
>     Yeah, they are.  Actually, I was thinking about such patch ~1.5 years ago 
> *but* using a different approach -- namely, hwif->extra_base.

good idea!

> [...]
> > Index: b/drivers/ide/pci/cmd64x.c
> > ===================================================================
> > --- a/drivers/ide/pci/cmd64x.c
> > +++ b/drivers/ide/pci/cmd64x.c
> > @@ -333,13 +333,14 @@ static void cmd64x_set_dma_mode(ide_driv
> >  static int cmd648_ide_dma_end (ide_drive_t *drive)
> >  {
> >  	ide_hwif_t *hwif	= HWIF(drive);
> > +	unsigned long addr	= hwif->dma_base - (hwif->channel * 8) + 0x01;
> 
>     Dunno... pci_resource_start() looked better to my taste. Except I'd 
> probably called the variable 'base' and wouldn't + 0x01 right away.

fixed

> >  	int err			= __ide_dma_end(drive);
> >  	u8  irq_mask		= hwif->channel ? MRDMODE_INTR_CH1 :
> >  						  MRDMODE_INTR_CH0;
> > -	u8  mrdmode		= inb(hwif->dma_master + 0x01);
> > +	u8  mrdmode		= inb(addr);
> >  
> >  	/* clear the interrupt bit */
> > -	outb(mrdmode | irq_mask, hwif->dma_master + 0x01);
> > +	outb(mrdmode | irq_mask, addr);
> >  
> >  	return err;
> >  }
> > @@ -364,10 +365,11 @@ static int cmd64x_ide_dma_end (ide_drive
> >  static int cmd648_ide_dma_test_irq (ide_drive_t *drive)
> >  {
> >  	ide_hwif_t *hwif	= HWIF(drive);
> > +	unsigned long addr	= hwif->dma_base - (hwif->channel * 8) + 0x01;
> 
>     Same comment here...

ditto

> >  	u8 irq_mask		= hwif->channel ? MRDMODE_INTR_CH1 :
> >  						  MRDMODE_INTR_CH0;
> >  	u8 dma_stat		= inb(hwif->dma_status);
> > -	u8 mrdmode		= inb(hwif->dma_master + 0x01);
> > +	u8 mrdmode		= inb(addr);
> >  
> >  #ifdef DEBUG
> >  	printk("%s: dma_stat: 0x%02x mrdmode: 0x%02x irq_mask: 0x%02x\n",
> > Index: b/drivers/ide/pci/hpt366.c
> > ===================================================================
> > --- a/drivers/ide/pci/hpt366.c
> > +++ b/drivers/ide/pci/hpt366.c
> > @@ -845,32 +845,33 @@ static int hpt374_ide_dma_end(ide_drive_
> 
>     This just asks to be:
> 
> >  static void hpt3xxn_set_clock(ide_hwif_t *hwif, u8 mode)
> >  {
> 	unsigned long base = hwif->extra_base;
> 	u8 scr2 = inb(base + 0x5b);
> 
>   	if ((scr2 & 0x7f) == mode)
>   		return;
> 
>   	/* Tristate the bus */
> 	outb(0x80, base + 0x53);
> 	outb(0x80, base + 0x57);
> 
>   	/* Switch clock and reset channels */
> 	outb(mode, base + 0x5b);
> 	outb(0xc0, base + 0x59);
> 
>   	/*
>   	 * Reset the state machines.
>    	 * NOTE: avoid accidentally enabling the disabled channels.
>   	 */
> 	outb(inb(base + 0x50) | 0x32, base + 0x50);
> 	outb(inb(base + 0x54) | 0x32, base + 0x54);
> 
>   	/* Complete reset */
> 	outb(0x00, base + 0x59);
> 
> 	/* Reconnect channels to bus */
> 	outb(0x00, base + 0x53);
> 	outb(0x00, base + 0x57);
> }

ditto

> > Index: b/drivers/ide/pci/pdc202xx_old.c
> > ===================================================================
> > --- a/drivers/ide/pci/pdc202xx_old.c
> > +++ b/drivers/ide/pci/pdc202xx_old.c
> > @@ -162,7 +162,7 @@ static u8 pdc202xx_old_cable_detect (ide
> 
>     And this asks to be:
> 
> >   */
> >  static void pdc_old_enable_66MHz_clock(ide_hwif_t *hwif)
> >  {
> > -	unsigned long clock_reg = hwif->dma_master + 0x11;
> +	unsigned long clock_reg = hwif->extra_base + 0x01;

ditto
 
> >  	u8 clock = inb(clock_reg);
> >  
> >  	outb(clock | (hwif->channel ? 0x08 : 0x02), clock_reg);
> > @@ -170,7 +170,7 @@ static void pdc_old_enable_66MHz_clock(i
> >  
> >  static void pdc_old_disable_66MHz_clock(ide_hwif_t *hwif)
> >  {
> > -	unsigned long clock_reg = hwif->dma_master + 0x11;
> 
> +	unsigned long clock_reg = hwif->extra_base + 0x01;

ditto

> >  	u8 clock = inb(clock_reg);
> >  
> >  	outb(clock & ~(hwif->channel ? 0x08 : 0x02), clock_reg);
> > @@ -193,7 +193,7 @@ static void pdc202xx_old_ide_dma_start(i
> >  	if (drive->media != ide_disk || drive->addressing == 1) {
> >  		struct request *rq	= HWGROUP(drive)->rq;
> >  		ide_hwif_t *hwif	= HWIF(drive);
> > -		unsigned long high_16   = hwif->dma_master;
> 
> +		unsigned long high_16	= hwif->extra_base;

fixed but with s/hwif->extra_base/hwif->extra_base - 16/

> >  		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
> >  		u32 word_count	= 0;
> >  		u8 clock = inb(high_16 + 0x11);
> > @@ -212,7 +212,7 @@ static int pdc202xx_old_ide_dma_end(ide_
> >  {
> >  	if (drive->media != ide_disk || drive->addressing == 1) {
> >  		ide_hwif_t *hwif	= HWIF(drive);
> > -		unsigned long high_16	= hwif->dma_master;
> 
> +		unsigned long high_16	= hwif->extra_base;

ditto

> >  		unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x20);
> >  		u8 clock		= 0;
> >  
> > @@ -228,7 +228,7 @@ static int pdc202xx_old_ide_dma_end(ide_
> >  static int pdc202xx_old_ide_dma_test_irq(ide_drive_t *drive)
> >  {
> >  	ide_hwif_t *hwif	= HWIF(drive);
> > -	unsigned long high_16	= hwif->dma_master;
> 
> +	unsigned long high_16	= hwif->extra_base;

ditto

> >  	u8 dma_stat		= inb(hwif->dma_status);
> >  	u8 sc1d			= inb(high_16 + 0x001d);
> >  
> > @@ -271,7 +271,7 @@ static void pdc202xx_dma_timeout(ide_dri
> >  
> >  static void pdc202xx_reset_host (ide_hwif_t *hwif)
> >  {
> > -	unsigned long high_16	= hwif->dma_master;
> > +	unsigned long high_16	= hwif->dma_base - (hwif->channel * 8);
> 
> 	unsigned long high_16	= hwif->extra_base;

ditto

thanks for all hints, new version of the patch below...


[PATCH] ide: remove ->dma_master field from ide_hwif_t (take 3)

* Convert cmd64x, hpt366 and pdc202xx_old host drivers to use
  pci_resource_start(hwif->pci_dev, 4) instead of hwif->dma_master.

* Remove no longer needed ->dma_master field from ide_hwif_t.

v2:
* Use the more readable 'hwif->dma_base - (hwif->channel * 8)' instead of
  pci_resource_start(hwif->pci_dev, 4).

v3:
* Use hwif->extra_base in hpt366/pdc20xx_old + some cosmetic fixups over v2
  (suggested by Sergei).

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
+	unsigned long base = hwif->dma_base - (hwif->channel * 8);
+	u8 scr2 = inb(base + 0x7b);
 
 	if ((scr2 & 0x7f) == mode)
 		return;
 
 	/* Tristate the bus */
-	outb(0x80, hwif->dma_master + 0x73);
-	outb(0x80, hwif->dma_master + 0x77);
+	outb(0x80, base + 0x73);
+	outb(0x80, base + 0x77);
 
 	/* Switch clock and reset channels */
-	outb(mode, hwif->dma_master + 0x7b);
-	outb(0xc0, hwif->dma_master + 0x79);
+	outb(mode, base + 0x7b);
+	outb(0xc0, base + 0x79);
 
 	/*
 	 * Reset the state machines.
 	 * NOTE: avoid accidentally enabling the disabled channels.
 	 */
-	outb(inb(hwif->dma_master + 0x70) | 0x32, hwif->dma_master + 0x70);
-	outb(inb(hwif->dma_master + 0x74) | 0x32, hwif->dma_master + 0x74);
+	outb(inb(base + 0x70) | 0x32, base + 0x70);
+	outb(inb(base + 0x74) | 0x32, base + 0x74);
 
 	/* Complete reset */
-	outb(0x00, hwif->dma_master + 0x79);
+	outb(0x00, base + 0x79);
 
 	/* Reconnect channels to bus */
-	outb(0x00, hwif->dma_master + 0x73);
-	outb(0x00, hwif->dma_master + 0x77);
+	outb(0x00, base + 0x73);
+	outb(0x00, base + 0x77);
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
@@ -764,7 +764,6 @@ typedef struct hwif_s {
 	int		rqsize;		/* max sectors per request */
 	int		irq;		/* our irq number */
 
-	unsigned long	dma_master;	/* reference base addr dmabase */
 	unsigned long	dma_base;	/* base addr for dma ports */
 	unsigned long	dma_command;	/* dma command register */
 	unsigned long	dma_vendor1;	/* dma vendor 1 register */


