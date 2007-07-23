From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide patches
Date: Mon, 23 Jul 2007 23:22:22 +0200
Message-ID: <200707232322.22129.bzolnier@gmail.com>
References: <200707222019.03684.bzolnier@gmail.com> <1185155835.5439.91.camel@localhost.localdomain> <1185156084.5439.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:51030 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758821AbXGWVZf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jul 2007 17:25:35 -0400
Received: by ug-out-1314.google.com with SMTP id j3so40027ugf
        for <linux-ide@vger.kernel.org>; Mon, 23 Jul 2007 14:25:34 -0700 (PDT)
In-Reply-To: <1185156084.5439.93.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org


Hi,

Thanks for reviewing and testing this patch series.

On Monday 23 July 2007, Benjamin Herrenschmidt wrote:
> 
> > Ok, there's a combination of things here:
> > 
> >  - First, doing a set_pio from userland (hdparm -p XX) causes the kernel
> > to disable DMA, which I think is incorrect. It's not the case with
> > 2.6.22 from my quick tests. The problem is that ide_config_drive_speed
> > disables DMA, but only re-enables it when setting a DMA speed. I think

The problem is that _many_ chipsets don't support separate PIO and DMA
timings so disabling DMA while programming chipset for PIO timings is a
necessity for them.

> > the whole idea of having a "current speed" is bogus here, we should have
> > a separate current DMA speed and current PIO speed. We should be able to
> > set the PIO timings without stopping DMA, toggling DMA is a separate
> > affair.
> 
> >  - For some reason, nowadays, hdparm -p /dev/hda will not autotune, but
> > will set PIO 0 (hdparm -p 255 /dev/hda will autotune). Might be a bug in
> > whatever hdparm version I have here.

Since -p 255 works fine it would indicate a hdparm issue.

> >  - Some userland scripts installed on debian as part of the pbbuttonsd
> > package are doing hdaprm -p /dev/device on all IDE devices at boot.
> 
> In the meantime, that patch applied on top of your latest series fixes
> the PIO setting in the driver to send the correct mode value in

Looks fine.

Could you please rebase it on top of the fixed "ide-pmac: PIO mode setup
fixes" patch, remove debugging printks and add description/Signed-off-by?

Also since the patch series has been tested please verify that your concerns
wrt patches #4, #8 and #10 are still valid.

> pmac_ide_set_pio_mode(). I still object to your patch serie at this
> point because hdparm -p N should not, imho, cause DMA to be disabled.

If this change indeed causes some serious problem which breaks userland on
ppc (that can't be workarounded otherwise) we may add a new ->host_flags
flag and special hack to ide-io.c::do_special(), something like:

...
		int keep_dma = drive->using_dma;
...
			ide_set_pio(drive, req_pio);
...
		if (hwif->host_flags & IDE_HFLAG_SET_PIO_MODE_KEEP_DMA) {
			if (keep_dma)
				hwif->ide_dma_on(drive);
		}
...

which should preserve the old behavior.

I will respin patch #11 with necessary changes if needed.

> I really believe that the kernel should keep track separately of PIO and
> DMA speeds.

Agreed.

Thanks,
Bart

> Index: linux-work/drivers/ide/ppc/pmac.c
> ===================================================================
> --- linux-work.orig/drivers/ide/ppc/pmac.c	2007-07-23 10:21:07.000000000 +1000
> +++ linux-work/drivers/ide/ppc/pmac.c	2007-07-23 11:58:50.000000000 +1000
> @@ -535,7 +535,7 @@ pmac_outbsync(ide_drive_t *drive, u8 val
>  static void
>  pmac_ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
>  {
> -	u32 *timings;
> +	u32 *timings, t;
>  	unsigned accessTicks, recTicks;
>  	unsigned accessTime, recTime;
>  	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
> @@ -546,6 +546,7 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
>  		
>  	/* which drive is it ? */
>  	timings = &pmif->timings[drive->select.b.unit & 0x01];
> +	t = *timings;
>  
>  	cycle_time = ide_pio_cycle_time(drive, pio);
>  
> @@ -553,14 +554,14 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
>  	case controller_sh_ata6: {
>  		/* 133Mhz cell */
>  		u32 tr = kauai_lookup_timing(shasta_pio_timings, cycle_time);
> -		*timings = ((*timings) & ~TR_133_PIOREG_PIO_MASK) | tr;
> +		t = (t & ~TR_133_PIOREG_PIO_MASK) | tr;
>  		break;
>  		}
>  	case controller_un_ata6:
>  	case controller_k2_ata6: {
>  		/* 100Mhz cell */
>  		u32 tr = kauai_lookup_timing(kauai_pio_timings, cycle_time);
> -		*timings = ((*timings) & ~TR_100_PIOREG_PIO_MASK) | tr;
> +		t = (t & ~TR_100_PIOREG_PIO_MASK) | tr;
>  		break;
>  		}
>  	case controller_kl_ata4:
> @@ -574,9 +575,9 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
>  		accessTicks = min(accessTicks, 0x1fU);
>  		recTicks = SYSCLK_TICKS_66(recTime);
>  		recTicks = min(recTicks, 0x1fU);
> -		*timings = ((*timings) & ~TR_66_PIO_MASK) |
> -				(accessTicks << TR_66_PIO_ACCESS_SHIFT) |
> -				(recTicks << TR_66_PIO_RECOVERY_SHIFT);
> +		t = (t & ~TR_66_PIO_MASK) |
> +			(accessTicks << TR_66_PIO_ACCESS_SHIFT) |
> +			(recTicks << TR_66_PIO_RECOVERY_SHIFT);
>  		break;
>  	default: {
>  		/* 33Mhz cell */
> @@ -596,11 +597,11 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
>  			recTicks--; /* guess, but it's only for PIO0, so... */
>  			ebit = 1;
>  		}
> -		*timings = ((*timings) & ~TR_33_PIO_MASK) |
> +		t = (t & ~TR_33_PIO_MASK) |
>  				(accessTicks << TR_33_PIO_ACCESS_SHIFT) |
>  				(recTicks << TR_33_PIO_RECOVERY_SHIFT);
>  		if (ebit)
> -			*timings |= TR_33_PIO_E;
> +			t |= TR_33_PIO_E;
>  		break;
>  		}
>  	}
> @@ -610,9 +611,10 @@ pmac_ide_set_pio_mode(ide_drive_t *drive
>  		drive->name, pio,  *timings);
>  #endif	
>  
> -	if (ide_config_drive_speed(drive, XFER_PIO + pio))
> +	if (ide_config_drive_speed(drive, XFER_PIO_0 + pio))
>  		return;
>  
> +	*timings = t;
>  	pmac_ide_do_update_timings(drive);
>  }
>  
> @@ -1150,6 +1152,8 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
>  	hwif->cbl = pmif->cable_80 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
>  	hwif->drives[0].unmask = 1;
>  	hwif->drives[1].unmask = 1;
> +	hwif->drives[0].autotune = IDE_TUNE_AUTO;
> +	hwif->drives[1].autotune = IDE_TUNE_AUTO;
>  	hwif->pio_mask = ATA_PIO4;
>  	hwif->set_pio_mode = pmac_ide_set_pio_mode;
>  	if (pmif->kind == controller_un_ata6
> @@ -1766,10 +1770,16 @@ pmac_ide_dma_test_irq (ide_drive_t *driv
>  
>  static void pmac_ide_dma_host_off(ide_drive_t *drive)
>  {
> +#ifdef IDE_PMAC_DEBUG
> +	printk(KERN_ERR "%s: dma_host_off()\n", drive->name);
> +#endif
>  }
>  
>  static void pmac_ide_dma_host_on(ide_drive_t *drive)
>  {
> +#ifdef IDE_PMAC_DEBUG
> +	printk(KERN_ERR "%s: dma_host_on()\n", drive->name);
> +#endif
>  }
>  
>  static void
