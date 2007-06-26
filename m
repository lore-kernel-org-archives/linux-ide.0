From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/6] siimage: PIO mode setup fixes
Date: Tue, 26 Jun 2007 23:51:54 +0400
Message-ID: <46816E5A.6010208@ru.mvista.com>
References: <200706232004.08914.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:42035 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759479AbXFZTuK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jun 2007 15:50:10 -0400
In-Reply-To: <200706232004.08914.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

    A lot to argue about here...

> * Add sil_tuneproc() wrapper for siimage_tuneproc() which also sets
>   PIO mode on the device.

    Planning on the global prefix change? :-)

> * Add code limiting maximum PIO mode according to the pair device capabilities
>   to sil_tuneproc().

    Ugh... that part is terrible. :-/
    Actually, we only need to limit the taskfile, not the data transfers --
unlike it was done before.

> * Remove no longer needed siimage_taskfile_timing()
>   and config_siimage_chipset_for_pio().

    Yeah, time to get rid of that garbage. :-)

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    Note that PIO setup keeps being somewhat borken IODRY-wise even with this
patch as sil_tune_pio() only controls taskfile IORDY sampling -- the Right
Thing could only be done via speedproc() method...

> Index: b/drivers/ide/pci/siimage.c
> ===================================================================
> --- a/drivers/ide/pci/siimage.c
> +++ b/drivers/ide/pci/siimage.c
[...]
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
>  	ide_hwif_t *hwif	= HWIF(drive);
> +	ide_drive_t *pair	= &hwif->drives[1 - drive->select.b.unit];

    I'd suggest simpler [drive->dn ^ 1]...

>  	u32 speedt		= 0;
>  	u16 speedp		= 0;
>  	unsigned long addr	= siimage_seldev(drive, 0x04);
>  	unsigned long tfaddr	= siimage_selreg(hwif, 0x02);
> -	
> +
> +	/*
> +	 * Compute the best PIO mode we can for a given device. We must
> +	 * pick a speed that does not cause problems with the other device
> +	 * on the cable.
> +	 */
> +	if (pair) {

    Huh? It can *not* really be NULL.

> +		u8 pair_pio = ide_get_best_pio_mode(pair, 255, 4, NULL);

    I'm not quite sure it's safe enough to trim to the maximum supported mode 
of the other drive -- the current mode would be the safest bet... well, after 
referring to the ATA spec., it's considered safe enough there.

> +
> +		/* trim PIO to the slowest of the master/slave */
> +		if (pair_pio < pio)
> +			pio = pair_pio;

    No need to trim the *data* PIO mode.

> +	}
> +
>  	/* cheat for now and use the docs */
> -	switch (mode_wanted) {
> +	switch (pio) {
>  	case 4:
>  		speedp = 0x10c1;
>  		speedt = 0x10c1;

    What I envisioned was putting speedt into drive->drive_data, calculating 
the maximum value for 2 drives and using it to actually program the taskfile 
timing. Either that or put PIO mode there, and add the second switch to 
calculate the taskfile timings after getting the minimum PIO mode for 2 drives 
(but that's not as neat).

> @@ -235,7 +224,7 @@ static void siimage_tuneproc (ide_drive_
>  		hwif->OUTW(speedp, addr);
>  		hwif->OUTW(speedt, tfaddr);
>  		/* Now set up IORDY */
> -		if(mode_wanted == 3 || mode_wanted == 4)
> +		if (pio == 3 || pio == 4)

    Why not just (pio > 2)?

>  			hwif->OUTW(hwif->INW(tfaddr-2)|0x200, tfaddr-2);

    Erm, the same comments about taskfile IORDY as before: it should be 
selected if the drive supports it. In fact, if either of 2 drives do.

>  		else
>  			hwif->OUTW(hwif->INW(tfaddr-2)&~0x200, tfaddr-2);

    This is wrong logic: thus we may turn off IORDY although the 2nd drive may 
support it.

> @@ -245,42 +234,17 @@ static void siimage_tuneproc (ide_drive_
>  		pci_read_config_word(hwif->pci_dev, tfaddr-2, &speedp);
>  		speedp &= ~0x200;
>  		/* Set IORDY for mode 3 or 4 */
> -		if(mode_wanted == 3 || mode_wanted == 4)
> +		if (pio == 3 || pio == 4)
>  			speedp |= 0x200;
>  		pci_write_config_word(hwif->pci_dev, tfaddr-2, speedp);
>  	}
>  }

    Same here...

[...]
> @@ -335,7 +299,7 @@ static int siimage_tune_chipset (ide_dri
>  		case XFER_PIO_2:
>  		case XFER_PIO_1:
>  		case XFER_PIO_0:
> -			siimage_tuneproc(drive, (speed - XFER_PIO_0));
> +			sil_tune_pio(drive, speed - XFER_PIO_0);
>  			mode |= ((unit) ? 0x10 : 0x01);

    The last line enables IORDY sampling for data transfers.

>  			break;
>  		case XFER_MW_DMA_2:
> @@ -343,7 +307,7 @@ static int siimage_tune_chipset (ide_dri
>  		case XFER_MW_DMA_0:
>  			multi = dma[speed - XFER_MW_DMA_0];
>  			mode |= ((unit) ? 0x20 : 0x02);

    ... and this line also enables IORDY. And the one in UltraDMA case group too.

> -			config_siimage_chipset_for_pio(drive, 0);
> +			sil_tune_pio(drive, 4); /* FIXME */

    Why we still need this nonsense here...

>  			break;
>  		case XFER_UDMA_6:
>  		case XFER_UDMA_5:
> @@ -356,7 +320,7 @@ static int siimage_tune_chipset (ide_dri
>  			ultra |= ((scsc) ? (ultra6[speed - XFER_UDMA_0]) :
>  					   (ultra5[speed - XFER_UDMA_0]));
>  			mode |= ((unit) ? 0x30 : 0x03);
> -			config_siimage_chipset_for_pio(drive, 0);
> +			sil_tune_pio(drive, 4); /* FIXME */

    ... and here? If we so desperately want to setup PIO data/taskfile
timings, it's better to do via setting the 'autotune' field unconditionally.

>  			break;
>  		default:
>  			return 1;

MBR, Sergei

