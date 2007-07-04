From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/6] siimage: PIO mode setup fixes
Date: Wed, 04 Jul 2007 20:16:18 +0400
Message-ID: <468BC7D2.2030901@ru.mvista.com>
References: <200706232004.08914.bzolnier@gmail.com> <46816E5A.6010208@ru.mvista.com> <200706300012.12394.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:32323 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752065AbXGDQOX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jul 2007 12:14:23 -0400
In-Reply-To: <200706300012.12394.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>    A lot to argue about here...

>>>* Add sil_tuneproc() wrapper for siimage_tuneproc() which also sets
>>>  PIO mode on the device.

>>    Planning on the global prefix change? :-)

> Yep.

    Well, it didn't work out with 'ata_'... ;-)

>>>* Add code limiting maximum PIO mode according to the pair device capabilities
>>>  to sil_tuneproc().

>>    Ugh... that part is terrible. :-/
>>    Actually, we only need to limit the taskfile, not the data transfers --
>>unlike it was done before.

> Fixed.

    Let's see... :-)

>>    Note that PIO setup keeps being somewhat borken IODRY-wise even with this
>>patch as sil_tune_pio() only controls taskfile IORDY sampling -- the Right
>>Thing could only be done via speedproc() method...

> After rehashing the datasheet I see the source of the issue:

> IORDY is controlled in two registers and moreover it is always enabled
> if MDMA or UDMA transfer modes are selected.

    Yeah. I drafted some patch for pata_sil.c but Alan fixed it first and in a 
more simple way -- libata calls PIO/DMA setting methods in the strict 
sequence, and that allowed to bypass some checks...

>>>Index: b/drivers/ide/pci/siimage.c
>>>===================================================================
>>>--- a/drivers/ide/pci/siimage.c
>>>+++ b/drivers/ide/pci/siimage.c
>>[...]
>>>+	}
>>>+
>>> 	/* cheat for now and use the docs */
>>>-	switch (mode_wanted) {
>>>+	switch (pio) {
>>> 	case 4:
>>> 		speedp = 0x10c1;
>>> 		speedt = 0x10c1;

>>    What I envisioned was putting speedt into drive->drive_data, calculating 
>>the maximum value for 2 drives and using it to actually program the taskfile 
>>timing. Either that or put PIO mode there, and add the second switch to 
>>calculate the taskfile timings after getting the minimum PIO mode for 2 drives 
>>(but that's not as neat).

> I did something similar to the second solution (should be sufficient for now)
> but improvenments are welcomed.

    Thanks, looks good.

>>> 			hwif->OUTW(hwif->INW(tfaddr-2)|0x200, tfaddr-2);

>>    Erm, the same comments about taskfile IORDY as before: it should be 
>>selected if the drive supports it. In fact, if either of 2 drives do.

>>> 		else
>>> 			hwif->OUTW(hwif->INW(tfaddr-2)&~0x200, tfaddr-2);

>>    This is wrong logic: thus we may turn off IORDY although the 2nd drive may 
>>support it.

> Indeed, but since I don't want to be selfish and keep all bugfixes to myself
> I'm giving other people opportunity to fix it. :-)

> ditto for ->speedproc vs IORDY problems

    Wow, drivers/ide/ is a land of opportunity. B-)

>>[...]

>>>@@ -335,7 +299,7 @@ static int siimage_tune_chipset (ide_dri
>>> 		case XFER_PIO_2:
>>> 		case XFER_PIO_1:
>>> 		case XFER_PIO_0:
>>>-			siimage_tuneproc(drive, (speed - XFER_PIO_0));
>>>+			sil_tune_pio(drive, speed - XFER_PIO_0);
>>> 			mode |= ((unit) ? 0x10 : 0x01);

>>    The last line enables IORDY sampling for data transfers.

>>> 			break;
>>> 		case XFER_MW_DMA_2:
>>>@@ -343,7 +307,7 @@ static int siimage_tune_chipset (ide_dri
>>> 		case XFER_MW_DMA_0:
>>> 			multi = dma[speed - XFER_MW_DMA_0];
>>> 			mode |= ((unit) ? 0x20 : 0x02);

>>    ... and this line also enables IORDY. And the one in UltraDMA case group too.

>>>-			config_siimage_chipset_for_pio(drive, 0);
>>>+			sil_tune_pio(drive, 4); /* FIXME */
>>
>>    Why we still need this nonsense here...

> I was _really_ hoping that /* FIXME */ would make this clear. ;-)

    You were under/over-etimatating me. ;-)

>>>@@ -356,7 +320,7 @@ static int siimage_tune_chipset (ide_dri
>>> 			ultra |= ((scsc) ? (ultra6[speed - XFER_UDMA_0]) :
>>> 					   (ultra5[speed - XFER_UDMA_0]));
>>> 			mode |= ((unit) ? 0x30 : 0x03);
>>>-			config_siimage_chipset_for_pio(drive, 0);
>>>+			sil_tune_pio(drive, 4); /* FIXME */

>>    ... and here? If we so desperately want to setup PIO data/taskfile
>>timings, it's better to do via setting the 'autotune' field unconditionally.

> I had a follow-up patch doing exactly that (done later than this patch).
> I integrated it into current patch since there was a need for respin...

    Thanks, looks better now. :-)

> take 2 follows:

> [PATCH] siimage: PIO mode setup fixes (take 2)

> * Add sil_tuneproc() wrapper for siimage_tuneproc() which also sets
>   PIO mode on the device.

> * Add missing ide_get_best_pio_mode() call to sil_tuneproc() so
>   "pio" == 255 (autotune) is handled correctly (previously PIO0 was used)
>   and "pio" values > 4 && < 255 are filtered to PIO4 (instead of PIO0).

> * Add code limiting maximum PIO mode according to the pair device capabilities
>   to sil_tuneproc().

> * Convert users of config_siimage_chipset_for_pio() to use sil_tune_pio() and
>   sil_tuneproc().  This fixes PIO fallback in siimage_config_drive_for_dma() to
>   use max PIO mode available instead of PIO4 (config_siimage_chipset_for_pio()
>   used wrong arguments for ide_get_best_pio_mode() and as a results always
>   tried to set PIO4).

> * Remove no longer needed siimage_taskfile_timing()
>   and config_siimage_chipset_for_pio().

> * Enable ->autotune unconditionally and remove PIO tuning for UDMA/MDMA modes
>   from siimage_speedproc()

> * Bump driver version.

> v2:
> * Fix issues noticed by Sergei:
>   - correct pair device check
>   - trim only taskfile PIO to the slowest of the master/slave
>   - enable ->autotune unconditionally and remove PIO tuning for UDMA/MDMA modes
>     from siimage_speedproc()
>   - add TODO item for IORDY bugs
>   - minor cleanups

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Reviewed-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/pci/siimage.c
> ===================================================================
> --- a/drivers/ide/pci/siimage.c
> +++ b/drivers/ide/pci/siimage.c
[...]
> @@ -31,6 +32,10 @@
>   *  unplugging/replugging the virtual CD interface when the DRAC is reset.
>   *  This often causes drivers/ide/siimage to panic but is ok with the rather
>   *  smarter code in libata.
> + *
> + * TODO:
> + * - IORDY fixes
> + * - VDMA support
>   */

    Not sure if VDMA support would be worth it...

> -/**
> - *	simmage_tuneproc	-	tune a drive
> + *	sil_tune_pio	-	tune a drive
>   *	@drive: drive to tune
> - *	@mode_wanted: the target operating mode
> + *	@pio: the desired PIO mode
>   *
>   *	Load the timing settings for this device mode into the
>   *	controller. If we are in PIO mode 3 or 4 turn on IORDY
>   *	monitoring (bit 9). The TF timing is bits 31:16
>   */
> - 
> -static void siimage_tuneproc (ide_drive_t *drive, byte mode_wanted)
> +
> +static void sil_tune_pio(ide_drive_t *drive, u8 pio)
>  {
> +	const u16 tf_speed[]	= { 0x328a, 0x2283, 0x1281, 0x10c3, 0x10c1 };
> +	const u16 data_speed[]	= { 0x328a, 0x2283, 0x1104, 0x10c3, 0x10c1 };

    Yeah, that's better than switch! :-)

> +
>  	ide_hwif_t *hwif	= HWIF(drive);
> +	ide_drive_t *pair	= &hwif->drives[drive->dn ^ 1];
>  	u32 speedt		= 0;
>  	u16 speedp		= 0;
>  	unsigned long addr	= siimage_seldev(drive, 0x04);
>  	unsigned long tfaddr	= siimage_selreg(hwif, 0x02);
> -	
> -	/* cheat for now and use the docs */
> -	switch (mode_wanted) {
> -	case 4:
> -		speedp = 0x10c1;
> -		speedt = 0x10c1;
> -		break;
> -	case 3:
> -		speedp = 0x10c3;
> -		speedt = 0x10c3;
> -		break;
> -	case 2:
> -		speedp = 0x1104;
> -		speedt = 0x1281;
> -		break;
> -	case 1:
> -		speedp = 0x2283;
> -		speedt = 0x2283;
> -		break;
> -	case 0:
> -	default:
> -		speedp = 0x328a;
> -		speedt = 0x328a;
> -		break;
> +	u8 tf_pio		= pio;
> +
> +	/* trim *taskfile* PIO to the slowest of the master/slave */
> +	if (pair->present) {
> +		u8 pair_pio = ide_get_best_pio_mode(pair, 255, 4, NULL);
> +
> +		if (pair_pio < tf_pio)
> +			tf_pio = pair_pio;
>  	}
>  
> +	/* cheat for now and use the docs */
> +	speedp = data_speed[pio];
> +	speedt = tf_speed[tf_pio];
> +
>  	if (hwif->mmio) {
>  		hwif->OUTW(speedp, addr);
>  		hwif->OUTW(speedt, tfaddr);
>  		/* Now set up IORDY */
> -		if(mode_wanted == 3 || mode_wanted == 4)
> +		if (pio > 2)

    Not tf_pio? This IORDY bit is for taskfile accesses...

>  			hwif->OUTW(hwif->INW(tfaddr-2)|0x200, tfaddr-2);
>  		else
>  			hwif->OUTW(hwif->INW(tfaddr-2)&~0x200, tfaddr-2);
> @@ -245,42 +213,17 @@ static void siimage_tuneproc (ide_drive_
>  		pci_read_config_word(hwif->pci_dev, tfaddr-2, &speedp);
>  		speedp &= ~0x200;
>  		/* Set IORDY for mode 3 or 4 */
> -		if(mode_wanted == 3 || mode_wanted == 4)
> +		if (pio > 2)

    Same question here.
    However... this logic should rely on both drives' PIO modes, so would be 
broken either way until this is fixed...

>  			speedp |= 0x200;
>  		pci_write_config_word(hwif->pci_dev, tfaddr-2, speedp);
>  	}
>  }

MBR, Sergei
