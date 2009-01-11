From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Sun, 11 Jan 2009 18:47:11 +0100
Message-ID: <200901111847.12080.bzolnier@gmail.com>
References: <49615667.9020408@iwl.com> <200901051736.18026.bzolnier@gmail.com> <49628C95.7080507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:33209 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbZAKRsQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2009 12:48:16 -0500
Received: by mu-out-0910.google.com with SMTP id g7so4106333muf.1
        for <linux-ide@vger.kernel.org>; Sun, 11 Jan 2009 09:48:13 -0800 (PST)
In-Reply-To: <49628C95.7080507@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com, "Martin K. Petersen" <mkp@mkp.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>


Hi,

On Monday 05 January 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>> 2. The cs5535 ide driver doesn't seem to be able to recognize the
> >>> newer CS5536 controller for IDE.
> >>>       
> >>    No wonder, it's even impossible to determine CS5536 IDE controller's 
> >> device ID from the datasheet; include/linux/pci_ids.h tells me that the 
> >> device ID is 0x209A, so adding another ID to the 'cs5535' driver's ID 
> >> table shouldn't be an issue -- if they are indeed compatible. Looking at 
> >> the datasheets, they are not -- bad luck, we need a new driver... BTW, 
> >> libata seems to already have support for this chipset.
> >>     
> >
> > Indeed...
> >
> > Karl, care to give a try to the following patch (it is completely untested
> > so please backup your data first if necessary)?
> >
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: add CS5536 host driver
> >
> > This is a port of libata's pata_cs5536.c (written by Martin K. Petersen)
> > to IDE subsystem.
> >
> > Changes done while at it:
> >
> > * Reprogram PIO/MWDMA timings if needed before and after DMA transfer
> >   (chipset uses shared PIO/MWDMA timings).
> >   
> > * Fix cable detection to report 80-wires cable if BIOS set it for any
> >   device on a port (IDE core will do drive-side cable detection later).
> >   
> 
>    The original pata_cs5536 cable detection is indeed somewhat bogus...
> 
> > * CS5536 is used mostly for driving CF cards and this allows use of
> >   
> 
>    I woulnd't be so sure -- but anyway, I mostly see the development 
> boards... :-)

I cleaned patch description a bit based on your and Alan's concerns.
 
> > Cc: Martin K. Petersen <mkp@mkp.net>
> > Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > Cc: Karl Auerbach <karl@iwl.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >   
> 
>    Looks good but needs some polishing...
> 
> > Index: b/drivers/ide/Kconfig
> > ===================================================================
> > --- a/drivers/ide/Kconfig
> > +++ b/drivers/ide/Kconfig
> > @@ -465,6 +465,16 @@ config BLK_DEV_CS5535
> >  
> >  	  It is safe to say Y to this question.
> >  
> > +config BLK_DEV_CS5536
> > +	tristate "CS5536 chipset support"
> > +	depends on X86 && !X86_64
> >   
> 
>    Why not just depend on X86_32?

Fixed (it could be that original driver predated x86 merge).

> > Index: b/drivers/ide/cs5536.c
> > ===================================================================
> > --- /dev/null
> > +++ b/drivers/ide/cs5536.c
> > @@ -0,0 +1,303 @@
> >   
> [...]
> > + * The IDE timing registers for the CS5536 live in the Geode Machine
> > + * Specific Register file and not PCI config space.  Most BIOSes
> > + * virtualize the PCI registers so the chip looks like a standard IDE
> > + * controller.  Unfortunately not all implementations get this right.
> > + * In particular some have problems with unaligned accesses to the
> >   
> 
>    I'd say that people doing unaligned accesses are just looking for 
> trouble... :-)
> 
> > +enum {
> > +	MSR_IDE_CFG		= 0x51300010,
> > +	PCI_IDE_CFG		= 0x40,
> > +
> > +	CFG			= 0,
> > +	DTC			= 2,
> > +	CAST			= 3,
> > +	ETC			= 4,
> > +
> > +	IDE_CFG_CHANEN		= (1 << 1),
> > +	IDE_CFG_CABLE		= (1 << 17) | (1 << 16),
> > +
> > +	IDE_D0_SHIFT		= 24,
> > +	IDE_D1_SHIFT		= 16,
> > +	IDE_DRV_MASK		= 0xff,
> > +
> > +	IDE_CAST_D0_SHIFT	= 6,
> > +	IDE_CAST_D1_SHIFT	= 4,
> > +	IDE_CAST_DRV_MASK	= 0x3,
> > +
> > +	IDE_CAST_CMD_SHIFT	= 24,
> > +	IDE_CAST_CMD_MASK	= 0xff,
> > +};
> >   
> 
>    Declaring a lot of semi-related constants is not what enum was 
> intended for I think...

Don't know about that but it is still better than using defines.

> > +static void cs5536_program_dtc(ide_drive_t *drive, u8 tim)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
> > +	int dshift = (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
> >   
> 
>    Masking with 1 is pointless (though harmless) for this single-channel 
> controller.

I prefer not to do such micro-optimizations (the gain of doing it for
whole driver is only 20 bytes) as this keeps code consistent with other
drivers and results in one gotcha less if somebody decides to use this
particular driver as a base for a new one.

> > +/**
> > + *	cs5536_set_pio_mode		-	PIO timing setup
> > + *	@drive: ATA device
> > + *	@pio: PIO mode number
> > + */
> > +
> > +static void cs5536_set_pio_mode(ide_drive_t *drive, const u8 pio)
> > +{
> > +	static const u8 drv_timings[5] = {
> > +		0x98, 0x55, 0x32, 0x21, 0x20,
> > +	};
> > +
> > +	static const u8 addr_timings[5] = {
> > +		0x2, 0x1, 0x0, 0x0, 0x0,
> > +	};
> > +
> > +	static const u8 cmd_timings[5] = {
> > +		0x99, 0x92, 0x90, 0x22, 0x20,
> > +	};
> > +
> > +	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
> > +	ide_drive_t *pair = ide_get_pair_dev(drive);
> > +	int cshift = (drive->dn & 1) ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIFT;
> >   
> 
>    Same comment...
> 
> > +	u32 cast;
> > +	u8 cmd_pio = pio;
> > +
> > +	if (pair)
> > +		cmd_pio = min(pio, ide_get_best_pio_mode(pair, 255, 4));
> > +
> > +	drive->drive_data &= 0xff00;
> 
>    IDE_DRV_MASK << 8?

Fixed.

> > +/**
> > + *	cs5536_set_dma_mode		-	DMA timing setup
> > + *	@drive: ATA device
> > + *	@mode: DMA mode
> > + */
> > +
> > +static void cs5536_set_dma_mode(ide_drive_t *drive, const u8 mode)
> > +{
> > +	static const u8 udma_timings[6] = {
> > +		0xc2, 0xc1, 0xc0, 0xc4, 0xc5, 0xc6,
> > +	};
> > +
> > +	static const u8 mwdma_timings[3] = {
> > +		0x67, 0x21, 0x20,
> > +	};
> > +
> > +	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
> > +	int dshift = (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
> > +	u32 etc;
> > +
> > +	if (mode >= XFER_UDMA_0) {
> > +		cs5536_read(pdev, ETC, &etc);
> > +
> > +		etc &= ~(IDE_DRV_MASK << dshift);
> > +		etc |= udma_timings[mode - XFER_UDMA_0] << dshift;
> > +
> > +		cs5536_write(pdev, ETC, etc);
> > +	} else { /* MWDMA */
> > +		drive->drive_data &= 0xff;
> >   
> 
>    IDE_DRV_MASK?

Fixed.

> > +		drive->drive_data |= mwdma_timings[mode - XFER_MW_DMA_0] << 8;
> >   
> 
>    How about disabling UltraDMA mode? While not an issue in the original 
> driver with the set_{dma|pio}mode() method call order strictly 
> determined and the latter method disabling UltraDMA, here this becames 
> an issue...

Agreed, fixed.

> > +static void cs5536_dma_start(ide_drive_t *drive)
> > +{
> > +	if (drive->current_speed < XFER_UDMA_0)
> > +		cs5536_program_dtc(drive, drive->drive_data >> 8);
> >   
> 
>    Worth comparing the values as PIO4 and MWDMA2 timings exactly 
> correspond. Hm, PIO3 and MWDMA1 too...

Good catch, fixed.

> > +/**
> > + *	cs5536_init_one
> > + *	@dev: PCI device
> > + *	@id: Entry in match table
> > + */
> > +
> > +static int cs5536_init_one(struct pci_dev *dev, const struct pci_device_id *id)
> > +{
> > +	u32 cfg;
> > +
> > +	if (use_msr)
> > +		printk(KERN_ERR DRV_NAME ": Using MSR regs instead of PCI\n");
> >   
> 
>    Why KERN_ERR? :-O

Copied from original driver. :)

I changed it to KERN_INFO.

> > +	cs5536_read(dev, CFG, &cfg);
> > +
> > +	if ((cfg & IDE_CFG_CHANEN) == 0) {
> > +		printk(KERN_ERR DRV_NAME ": disabled by BIOS\n");
> > +		return -ENODEV;
> >   
> 
>    Eh, why not do it via the usual .enablebits mechanism?

Because we may be using MSR access instead of PCI one.

Thanks for review Sergei, new patch description + v1->v2 interdiff
below (v2 has been merged into pata-2.6 tree now if somebody wants
to see the full patch):

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add CS5536 host driver (v2)

This is a port of libata's pata_cs5536.c (written by Martin K. Petersen)
to IDE subsystem.

Changes done while at it:

* Reprogram PIO/MWDMA timings if needed before and after DMA transfer
  (chipset uses shared PIO/MWDMA timings).

* Fix cable detection to report 80-wires cable if BIOS set it for any
  device on a port (IDE core will do drive-side cable detection later).

* Don't disable UDMA while programming PIO timings.

* Simplify PCI/MSR support.

Pros of having IDE host driver in addition to libata's one:

* IDE is much lighter than SCSI+libata, the host driver itself is also
  a bit smaller:

   text    data     bss     dec     hex filename
   1237     500       4    1741     6cd drivers/ata/pata_cs5536.o
   1214     128       4    1346     542 drivers/ide/cs5536.o

* This allows use of IDE features which are unavailable under libata.

v2:
* Fixes per review from Sergei:
  - simplify dependency check in Kconfig
  - use IDE_DRV_MASK also for ->drive_data
  - disable UDMA when programming MWDMA
  - program new DTC timings only when necessary
  - fix printk() level in cs5536_init_one()

* Fix patch description according to comments from Alan and Sergei.

Cc: Martin K. Petersen <mkp@mkp.net>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Karl Auerbach <karl@iwl.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
v1->v2 interdiff only

diff -u b/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- b/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -467,7 +467,7 @@
 
 config BLK_DEV_CS5536
 	tristate "CS5536 chipset support"
-	depends on X86 && !X86_64
+	depends on X86_32
 	select BLK_DEV_IDEDMA_PCI
 	help
 	  This option enables support for the AMD CS5536
diff -u b/drivers/ide/cs5536.c b/drivers/ide/cs5536.c
--- b/drivers/ide/cs5536.c
+++ b/drivers/ide/cs5536.c
@@ -61,6 +61,9 @@
 
 	IDE_CAST_CMD_SHIFT	= 24,
 	IDE_CAST_CMD_MASK	= 0xff,
+
+	IDE_ETC_UDMA_RELSHIFT	= 6,
+	IDE_ETC_UDMA_MASK	= 0x3,
 };
 
 static int use_msr;
@@ -150,7 +153,7 @@
 	if (pair)
 		cmd_pio = min(pio, ide_get_best_pio_mode(pair, 255, 4));
 
-	drive->drive_data &= 0xff00;
+	drive->drive_data &= (IDE_DRV_MASK << 8);
 	drive->drive_data |= drv_timings[pio];
 
 	cs5536_program_dtc(drive, drv_timings[pio]);
@@ -186,22 +189,24 @@
 	int dshift = (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
 	u32 etc;
 
-	if (mode >= XFER_UDMA_0) {
-		cs5536_read(pdev, ETC, &etc);
+	cs5536_read(pdev, ETC, &etc);
 
+	if (mode >= XFER_UDMA_0) {
 		etc &= ~(IDE_DRV_MASK << dshift);
 		etc |= udma_timings[mode - XFER_UDMA_0] << dshift;
-
-		cs5536_write(pdev, ETC, etc);
 	} else { /* MWDMA */
-		drive->drive_data &= 0xff;
+		etc &= ~(IDE_ETC_UDMA_MASK << (dshift + IDE_ETC_UDMA_RELSHIFT));
+		drive->drive_data &= IDE_DRV_MASK;
 		drive->drive_data |= mwdma_timings[mode - XFER_MW_DMA_0] << 8;
 	}
+
+	cs5536_write(pdev, ETC, etc);
 }
 
 static void cs5536_dma_start(ide_drive_t *drive)
 {
-	if (drive->current_speed < XFER_UDMA_0)
+	if (drive->current_speed < XFER_UDMA_0 &&
+	    (drive->drive_data >> 8) != (drive->drive_data & IDE_DRV_MASK))
 		cs5536_program_dtc(drive, drive->drive_data >> 8);
 
 	ide_dma_start(drive);
@@ -211,8 +216,9 @@
 {
 	int ret = ide_dma_end(drive);
 
-	if (drive->current_speed < XFER_UDMA_0)
-		cs5536_program_dtc(drive, drive->drive_data & 0xff);
+	if (drive->current_speed < XFER_UDMA_0 &&
+	    (drive->drive_data >> 8) != (drive->drive_data & IDE_DRV_MASK))
+		cs5536_program_dtc(drive, drive->drive_data & IDE_DRV_MASK);
 
 	return ret;
 }
@@ -255,7 +261,7 @@
 	u32 cfg;
 
 	if (use_msr)
-		printk(KERN_ERR DRV_NAME ": Using MSR regs instead of PCI\n");
+		printk(KERN_INFO DRV_NAME ": Using MSR regs instead of PCI\n");
 
 	cs5536_read(dev, CFG, &cfg);
 
