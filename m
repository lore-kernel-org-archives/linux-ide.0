From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/6] siimage: PIO mode setup fixes
Date: Sat, 30 Jun 2007 00:12:12 +0200
Message-ID: <200706300012.12394.bzolnier@gmail.com>
References: <200706232004.08914.bzolnier@gmail.com> <46816E5A.6010208@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:9479 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129AbXF2WBN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 18:01:13 -0400
Received: by ug-out-1314.google.com with SMTP id j3so895202ugf
        for <linux-ide@vger.kernel.org>; Fri, 29 Jun 2007 15:01:12 -0700 (PDT)
In-Reply-To: <46816E5A.6010208@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Tuesday 26 June 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>     A lot to argue about here...
> 
> > * Add sil_tuneproc() wrapper for siimage_tuneproc() which also sets
> >   PIO mode on the device.
> 
>     Planning on the global prefix change? :-)

Yep.

> > * Add code limiting maximum PIO mode according to the pair device capabilities
> >   to sil_tuneproc().
> 
>     Ugh... that part is terrible. :-/
>     Actually, we only need to limit the taskfile, not the data transfers --
> unlike it was done before.

Fixed.

> > * Remove no longer needed siimage_taskfile_timing()
> >   and config_siimage_chipset_for_pio().
> 
>     Yeah, time to get rid of that garbage. :-)
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>     Note that PIO setup keeps being somewhat borken IODRY-wise even with this
> patch as sil_tune_pio() only controls taskfile IORDY sampling -- the Right
> Thing could only be done via speedproc() method...

After rehashing the datasheet I see the source of the issue:

IORDY is controlled in two registers and moreover it is always enabled
if MDMA or UDMA transfer modes are selected.

> > Index: b/drivers/ide/pci/siimage.c
> > ===================================================================
> > --- a/drivers/ide/pci/siimage.c
> > +++ b/drivers/ide/pci/siimage.c
> [...]
> > -/**
> > - *	simmage_tuneproc	-	tune a drive
> > + *	sil_tune_pio	-	tune a drive
> >   *	@drive: drive to tune
> > - *	@mode_wanted: the target operating mode
> > + *	@pio: the desired PIO mode
> >   *
> >   *	Load the timing settings for this device mode into the
> >   *	controller. If we are in PIO mode 3 or 4 turn on IORDY
> >   *	monitoring (bit 9). The TF timing is bits 31:16
> >   */
> > - 
> > -static void siimage_tuneproc (ide_drive_t *drive, byte mode_wanted)
> > +
> > +static void sil_tune_pio(ide_drive_t *drive, u8 pio)
> >  {
> >  	ide_hwif_t *hwif	= HWIF(drive);
> > +	ide_drive_t *pair	= &hwif->drives[1 - drive->select.b.unit];
> 
>     I'd suggest simpler [drive->dn ^ 1]...

Fixed.

> >  	u32 speedt		= 0;
> >  	u16 speedp		= 0;
> >  	unsigned long addr	= siimage_seldev(drive, 0x04);
> >  	unsigned long tfaddr	= siimage_selreg(hwif, 0x02);
> > -	
> > +
> > +	/*
> > +	 * Compute the best PIO mode we can for a given device. We must
> > +	 * pick a speed that does not cause problems with the other device
> > +	 * on the cable.
> > +	 */
> > +	if (pair) {
> 
>     Huh? It can *not* really be NULL.

It was supposed to be pair->present, fixed.  Thanks!

> > +		u8 pair_pio = ide_get_best_pio_mode(pair, 255, 4, NULL);
> 
>     I'm not quite sure it's safe enough to trim to the maximum supported mode 
> of the other drive -- the current mode would be the safest bet... well, after 
> referring to the ATA spec., it's considered safe enough there.
> 
> > +
> > +		/* trim PIO to the slowest of the master/slave */
> > +		if (pair_pio < pio)
> > +			pio = pair_pio;
> 
>     No need to trim the *data* PIO mode.

Fixed.

> > +	}
> > +
> >  	/* cheat for now and use the docs */
> > -	switch (mode_wanted) {
> > +	switch (pio) {
> >  	case 4:
> >  		speedp = 0x10c1;
> >  		speedt = 0x10c1;
> 
>     What I envisioned was putting speedt into drive->drive_data, calculating 
> the maximum value for 2 drives and using it to actually program the taskfile 
> timing. Either that or put PIO mode there, and add the second switch to 
> calculate the taskfile timings after getting the minimum PIO mode for 2 drives 
> (but that's not as neat).

I did something similar to the second solution (should be sufficient for now)
but improvenments are welcomed.

> > @@ -235,7 +224,7 @@ static void siimage_tuneproc (ide_drive_
> >  		hwif->OUTW(speedp, addr);
> >  		hwif->OUTW(speedt, tfaddr);
> >  		/* Now set up IORDY */
> > -		if(mode_wanted == 3 || mode_wanted == 4)
> > +		if (pio == 3 || pio == 4)
> 
>     Why not just (pio > 2)?

Fixed.

> >  			hwif->OUTW(hwif->INW(tfaddr-2)|0x200, tfaddr-2);
> 
>     Erm, the same comments about taskfile IORDY as before: it should be 
> selected if the drive supports it. In fact, if either of 2 drives do.
> 
> >  		else
> >  			hwif->OUTW(hwif->INW(tfaddr-2)&~0x200, tfaddr-2);
> 
>     This is wrong logic: thus we may turn off IORDY although the 2nd drive may 
> support it.

Indeed, but since I don't want to be selfish and keep all bugfixes to myself
I'm giving other people opportunity to fix it. :-)

ditto for ->speedproc vs IORDY problems

> > @@ -245,42 +234,17 @@ static void siimage_tuneproc (ide_drive_
> >  		pci_read_config_word(hwif->pci_dev, tfaddr-2, &speedp);
> >  		speedp &= ~0x200;
> >  		/* Set IORDY for mode 3 or 4 */
> > -		if(mode_wanted == 3 || mode_wanted == 4)
> > +		if (pio == 3 || pio == 4)
> >  			speedp |= 0x200;
> >  		pci_write_config_word(hwif->pci_dev, tfaddr-2, speedp);
> >  	}
> >  }
> 
>     Same here...

Fixed.

> [...]
> > @@ -335,7 +299,7 @@ static int siimage_tune_chipset (ide_dri
> >  		case XFER_PIO_2:
> >  		case XFER_PIO_1:
> >  		case XFER_PIO_0:
> > -			siimage_tuneproc(drive, (speed - XFER_PIO_0));
> > +			sil_tune_pio(drive, speed - XFER_PIO_0);
> >  			mode |= ((unit) ? 0x10 : 0x01);
> 
>     The last line enables IORDY sampling for data transfers.
> 
> >  			break;
> >  		case XFER_MW_DMA_2:
> > @@ -343,7 +307,7 @@ static int siimage_tune_chipset (ide_dri
> >  		case XFER_MW_DMA_0:
> >  			multi = dma[speed - XFER_MW_DMA_0];
> >  			mode |= ((unit) ? 0x20 : 0x02);
> 
>     ... and this line also enables IORDY. And the one in UltraDMA case group too.
> 
> > -			config_siimage_chipset_for_pio(drive, 0);
> > +			sil_tune_pio(drive, 4); /* FIXME */
> 
>     Why we still need this nonsense here...

I was _really_ hoping that /* FIXME */ would make this clear. ;-)

> >  			break;
> >  		case XFER_UDMA_6:
> >  		case XFER_UDMA_5:
> > @@ -356,7 +320,7 @@ static int siimage_tune_chipset (ide_dri
> >  			ultra |= ((scsc) ? (ultra6[speed - XFER_UDMA_0]) :
> >  					   (ultra5[speed - XFER_UDMA_0]));
> >  			mode |= ((unit) ? 0x30 : 0x03);
> > -			config_siimage_chipset_for_pio(drive, 0);
> > +			sil_tune_pio(drive, 4); /* FIXME */
> 
>     ... and here? If we so desperately want to setup PIO data/taskfile
> timings, it's better to do via setting the 'autotune' field unconditionally.

I had a follow-up patch doing exactly that (done later than this patch).
I integrated it into current patch since there was a need for respin...

take 2 follows:

[PATCH] siimage: PIO mode setup fixes (take 2)

* Add sil_tuneproc() wrapper for siimage_tuneproc() which also sets
  PIO mode on the device.

* Add missing ide_get_best_pio_mode() call to sil_tuneproc() so
  "pio" == 255 (autotune) is handled correctly (previously PIO0 was used)
  and "pio" values > 4 && < 255 are filtered to PIO4 (instead of PIO0).

* Add code limiting maximum PIO mode according to the pair device capabilities
  to sil_tuneproc().

* Convert users of config_siimage_chipset_for_pio() to use sil_tune_pio() and
  sil_tuneproc().  This fixes PIO fallback in siimage_config_drive_for_dma() to
  use max PIO mode available instead of PIO4 (config_siimage_chipset_for_pio()
  used wrong arguments for ide_get_best_pio_mode() and as a results always
  tried to set PIO4).

* Remove no longer needed siimage_taskfile_timing()
  and config_siimage_chipset_for_pio().

* Enable ->autotune unconditionally and remove PIO tuning for UDMA/MDMA modes
  from siimage_speedproc()

* Bump driver version.

v2:
* Fix issues noticed by Sergei:
  - correct pair device check
  - trim only taskfile PIO to the slowest of the master/slave
  - enable ->autotune unconditionally and remove PIO tuning for UDMA/MDMA modes
    from siimage_speedproc()
  - add TODO item for IORDY bugs
  - minor cleanups

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reviewed-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---
 drivers/ide/pci/siimage.c |  137 +++++++++++++---------------------------------
 1 file changed, 39 insertions(+), 98 deletions(-)

Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -1,9 +1,10 @@
 /*
- * linux/drivers/ide/pci/siimage.c		Version 1.12	Mar 10 2007
+ * linux/drivers/ide/pci/siimage.c		Version 1.15	Jun 29 2007
  *
  * Copyright (C) 2001-2002	Andre Hedrick <andre@linux-ide.org>
  * Copyright (C) 2003		Red Hat <alan@redhat.com>
  * Copyright (C) 2007		MontaVista Software, Inc.
+ * Copyright (C) 2007		Bartlomiej Zolnierkiewicz
  *
  *  May be copied or modified under the terms of the GNU General Public License
  *
@@ -31,6 +32,10 @@
  *  unplugging/replugging the virtual CD interface when the DRAC is reset.
  *  This often causes drivers/ide/siimage to panic but is ok with the rather
  *  smarter code in libata.
+ *
+ * TODO:
+ * - IORDY fixes
+ * - VDMA support
  */
 
 #include <linux/types.h>
@@ -160,82 +165,45 @@ out:
 }
 
 /**
- *	siimage_taskfile_timing	-	turn timing data to a mode
- *	@hwif: interface to query
- *
- *	Read the timing data for the interface and return the 
- *	mode that is being used.
- */
- 
-static byte siimage_taskfile_timing (ide_hwif_t *hwif)
-{
-	u16 timing	= 0x328a;
-	unsigned long addr = siimage_selreg(hwif, 2);
-
-	if (hwif->mmio)
-		timing = hwif->INW(addr);
-	else
-		pci_read_config_word(hwif->pci_dev, addr, &timing);
-
-	switch (timing) {
-		case 0x10c1:	return 4;
-		case 0x10c3:	return 3;
-		case 0x1104:
-		case 0x1281:	return 2;
-		case 0x2283:	return 1;
-		case 0x328a:
-		default:	return 0;
-	}
-}
-
-/**
- *	simmage_tuneproc	-	tune a drive
+ *	sil_tune_pio	-	tune a drive
  *	@drive: drive to tune
- *	@mode_wanted: the target operating mode
+ *	@pio: the desired PIO mode
  *
  *	Load the timing settings for this device mode into the
  *	controller. If we are in PIO mode 3 or 4 turn on IORDY
  *	monitoring (bit 9). The TF timing is bits 31:16
  */
- 
-static void siimage_tuneproc (ide_drive_t *drive, byte mode_wanted)
+
+static void sil_tune_pio(ide_drive_t *drive, u8 pio)
 {
+	const u16 tf_speed[]	= { 0x328a, 0x2283, 0x1281, 0x10c3, 0x10c1 };
+	const u16 data_speed[]	= { 0x328a, 0x2283, 0x1104, 0x10c3, 0x10c1 };
+
 	ide_hwif_t *hwif	= HWIF(drive);
+	ide_drive_t *pair	= &hwif->drives[drive->dn ^ 1];
 	u32 speedt		= 0;
 	u16 speedp		= 0;
 	unsigned long addr	= siimage_seldev(drive, 0x04);
 	unsigned long tfaddr	= siimage_selreg(hwif, 0x02);
-	
-	/* cheat for now and use the docs */
-	switch (mode_wanted) {
-	case 4:
-		speedp = 0x10c1;
-		speedt = 0x10c1;
-		break;
-	case 3:
-		speedp = 0x10c3;
-		speedt = 0x10c3;
-		break;
-	case 2:
-		speedp = 0x1104;
-		speedt = 0x1281;
-		break;
-	case 1:
-		speedp = 0x2283;
-		speedt = 0x2283;
-		break;
-	case 0:
-	default:
-		speedp = 0x328a;
-		speedt = 0x328a;
-		break;
+	u8 tf_pio		= pio;
+
+	/* trim *taskfile* PIO to the slowest of the master/slave */
+	if (pair->present) {
+		u8 pair_pio = ide_get_best_pio_mode(pair, 255, 4, NULL);
+
+		if (pair_pio < tf_pio)
+			tf_pio = pair_pio;
 	}
 
+	/* cheat for now and use the docs */
+	speedp = data_speed[pio];
+	speedt = tf_speed[tf_pio];
+
 	if (hwif->mmio) {
 		hwif->OUTW(speedp, addr);
 		hwif->OUTW(speedt, tfaddr);
 		/* Now set up IORDY */
-		if(mode_wanted == 3 || mode_wanted == 4)
+		if (pio > 2)
 			hwif->OUTW(hwif->INW(tfaddr-2)|0x200, tfaddr-2);
 		else
 			hwif->OUTW(hwif->INW(tfaddr-2)&~0x200, tfaddr-2);
@@ -245,42 +213,17 @@ static void siimage_tuneproc (ide_drive_
 		pci_read_config_word(hwif->pci_dev, tfaddr-2, &speedp);
 		speedp &= ~0x200;
 		/* Set IORDY for mode 3 or 4 */
-		if(mode_wanted == 3 || mode_wanted == 4)
+		if (pio > 2)
 			speedp |= 0x200;
 		pci_write_config_word(hwif->pci_dev, tfaddr-2, speedp);
 	}
 }
 
-/**
- *	config_siimage_chipset_for_pio	-	set drive timings
- *	@drive: drive to tune
- *	@speed we want
- *
- *	Compute the best pio mode we can for a given device. Also honour
- *	the timings for the driver when dealing with mixed devices. Some
- *	of this is ugly but its all wrapped up here
- *
- *	The SI680 can also do VDMA - we need to start using that
- *
- *	FIXME: we use the BIOS channel timings to avoid driving the task
- *	files too fast at the disk. We need to compute the master/slave
- *	drive PIO mode properly so that we can up the speed on a hotplug
- *	system.
- */
- 
-static void config_siimage_chipset_for_pio (ide_drive_t *drive, byte set_speed)
+static void sil_tuneproc(ide_drive_t *drive, u8 pio)
 {
-	u8 channel_timings	= siimage_taskfile_timing(HWIF(drive));
-	u8 speed = 0, set_pio	= ide_get_best_pio_mode(drive, 4, 5, NULL);
-
-	/* WARNING PIO timing mess is going to happen b/w devices, argh */
-	if ((channel_timings != set_pio) && (set_pio > channel_timings))
-		set_pio = channel_timings;
-
-	siimage_tuneproc(drive, set_pio);
-	speed = XFER_PIO_0 + set_pio;
-	if (set_speed)
-		(void) ide_config_drive_speed(drive, speed);
+	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	sil_tune_pio(drive, pio);
+	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
 /**
@@ -335,7 +278,7 @@ static int siimage_tune_chipset (ide_dri
 		case XFER_PIO_2:
 		case XFER_PIO_1:
 		case XFER_PIO_0:
-			siimage_tuneproc(drive, (speed - XFER_PIO_0));
+			sil_tune_pio(drive, speed - XFER_PIO_0);
 			mode |= ((unit) ? 0x10 : 0x01);
 			break;
 		case XFER_MW_DMA_2:
@@ -343,7 +286,6 @@ static int siimage_tune_chipset (ide_dri
 		case XFER_MW_DMA_0:
 			multi = dma[speed - XFER_MW_DMA_0];
 			mode |= ((unit) ? 0x20 : 0x02);
-			config_siimage_chipset_for_pio(drive, 0);
 			break;
 		case XFER_UDMA_6:
 		case XFER_UDMA_5:
@@ -356,7 +298,6 @@ static int siimage_tune_chipset (ide_dri
 			ultra |= ((scsc) ? (ultra6[speed - XFER_UDMA_0]) :
 					   (ultra5[speed - XFER_UDMA_0]));
 			mode |= ((unit) ? 0x30 : 0x03);
-			config_siimage_chipset_for_pio(drive, 0);
 			break;
 		default:
 			return 1;
@@ -390,7 +331,7 @@ static int siimage_config_drive_for_dma 
 		return 0;
 
 	if (ide_use_fast_pio(drive))
-		config_siimage_chipset_for_pio(drive, 1);
+		sil_tuneproc(drive, 255);
 
 	return -1;
 }
@@ -961,7 +902,7 @@ static void __devinit init_hwif_siimage(
 	
 	hwif->resetproc = &siimage_reset;
 	hwif->speedproc = &siimage_tune_chipset;
-	hwif->tuneproc	= &siimage_tuneproc;
+	hwif->tuneproc	= &sil_tuneproc;
 	hwif->reset_poll = &siimage_reset_poll;
 	hwif->pre_reset = &siimage_pre_reset;
 	hwif->udma_filter = &sil_udma_filter;
@@ -976,11 +917,11 @@ static void __devinit init_hwif_siimage(
 			first = 0;
 		}
 	}
-	if (!hwif->dma_base) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
+
+	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
+
+	if (hwif->dma_base == 0)
 		return;
-	}
 
 	hwif->ultra_mask = 0x7f;
 	hwif->mwdma_mask = 0x07;
