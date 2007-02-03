From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] (2.6.20-rc7) cmd64x: fix PIO mode setup (take 2)
Date: Sat, 03 Feb 2007 23:25:35 +0100
Message-ID: <45C50BDF.6070702@gmail.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:21715 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbXBCWUl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 17:20:41 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1040472uga
        for <linux-ide@vger.kernel.org>; Sat, 03 Feb 2007 14:20:40 -0800 (PST)
In-Reply-To: <200702040004.24918.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

Sergei Shtylyov wrote:
> [Finally forgot to stamp MV's copyright on the driver, so here's take #2...]
> 
> The driver's tuneproc() method fails to set the drive's own speed -- fix this
> by renaming the function to cmd64x_tune_pio(), making it return the mode set,
> and "wrapping" the new tuneproc() method around it; while at it, also get rid
> of the non-working prefetch control code, remove redundant PIO5 mode limitation,
> and make cmdprintk() give more sensible mode info.  Also, get rid of the broken
> config_chipset_for_pio() which always tried to set PIO4 instead auto-tuning PIO.
> Note that removing a call from config_chipset_for_dma() breaks "rudimentary"
> MWDMA2 support which can only work because of the timing registers being pre-
> setup for PIO4 since the code in the speedproc() method which sets up the chip
> for SW/MW DMA is completely bogus (!) and I'm going to remove it for the time
> being in the next patch.
> Oh, and add the missing PIO5 support to the speedproc() method while at it. :-)

Generally looks fine, some comments below.

> Warning: compile tested only -- getting to the real hardware isn't that easy...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
>  drivers/ide/pci/cmd64x.c |   95 ++++++++++++++++-------------------------------
>  1 files changed, 34 insertions(+), 61 deletions(-)
> 
> Index: linux-2.6/drivers/ide/pci/cmd64x.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/pci/cmd64x.c
> +++ linux-2.6/drivers/ide/pci/cmd64x.c
> @@ -1,6 +1,6 @@
>  /* $Id: cmd64x.c,v 1.21 2000/01/30 23:23:16
>   *
> - * linux/drivers/ide/pci/cmd64x.c		Version 1.30	Sept 10, 2002
> + * linux/drivers/ide/pci/cmd64x.c		Version 1.41	Feb 3, 2007
>   *
>   * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
>   *           Note, this driver is not used at all on other systems because
> @@ -12,6 +12,7 @@
>   * Copyright (C) 1998		David S. Miller (davem@redhat.com)
>   *
>   * Copyright (C) 1999-2002	Andre Hedrick <andre@linux-ide.org>
> + * Copyright (C) 2007		MontaVista Software, Inc. <source@mvista.com>
>   */
>  
>  #include <linux/module.h>
> @@ -262,43 +263,25 @@ static void program_drive_counts (ide_dr
>  }
>  
>  /*
> - * Attempts to set the interface PIO mode.
> - * The preferred method of selecting PIO modes (e.g. mode 4) is 
> - * "echo 'piomode:4' > /proc/ide/hdx/settings".  Special cases are
> - * 8: prefetch off, 9: prefetch on, 255: auto-select best mode.
> - * Called with 255 at boot time.
> + * This routine selects drive's best PIO mode, calculates setup/active/recovery
> + * counts, and writes them into the chipset registers.
>   */
> -
> -static void cmd64x_tuneproc (ide_drive_t *drive, u8 mode_wanted)
> +static u8 cmd64x_tune_pio (ide_drive_t *drive, u8 mode_wanted)
>  {
>  	int setup_time, active_time, recovery_time;
>  	int clock_time, pio_mode, cycle_time;
>  	u8 recovery_count2, cycle_count;
>  	int setup_count, active_count, recovery_count;
>  	int bus_speed = system_bus_clock();
> -	/*byte b;*/
>  	ide_pio_data_t  d;
>  
> -	switch (mode_wanted) {
> -		case 8: /* set prefetch off */
> -		case 9: /* set prefetch on */
> -			mode_wanted &= 1;
> -			/*set_prefetch_mode(index, mode_wanted);*/
> -			cmdprintk("%s: %sabled cmd640 prefetch\n",
> -				drive->name, mode_wanted ? "en" : "dis");
> -			return;
> -	}
> -
> -	mode_wanted = ide_get_best_pio_mode (drive, mode_wanted, 5, &d);
> -	pio_mode = d.pio_mode;
> +	pio_mode = ide_get_best_pio_mode(drive, mode_wanted, 5, &d);
>  	cycle_time = d.cycle_time;

After this change if an unaware user passes "8" or "9" to enable/disable
prefetch (user doesn't know that it has never worked) it will result
in PIO5 being programmed.

I don't think that this is a real world issue but for paranoia reasons
please add pio == 8/9 check to cmd64x_tune_drive(), something like:

	/*
	 * letf-over from prefetch setting (pio == 8/9),
	 * needed to prevent PIO5 from being programmed
	 */
	if (pio == 8 || pio == 9)
		return;

This will vanish when core code will do filtering of user space
PIO mode change requests...

[ ... ]
> +/*
> + * Attempts to set drive's PIO mode.
> + * The preferred method of selecting PIO modes (e.g. mode 4) is
> + * "echo 'piomode:4' > /proc/ide/hdx/settings".
> + * Special case is 255: auto-select best mode (used at boot time).
> + */

The preferred method is to let the driver do the tuning and if for some
reason somebody wants to change the PIO mode, the ioctl interface is
preferred over the deprecated "/proc/ide/hdx/settings".

Therefore please remove this comment while at it.

> +static void cmd64x_tune_drive (ide_drive_t *drive, u8 pio)
> +{
> +	pio = cmd64x_tune_pio(drive, pio);
> +	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
>  }
>  
>  static u8 cmd64x_ratemask (ide_drive_t *drive)
> @@ -387,22 +375,6 @@ static u8 cmd64x_ratemask (ide_drive_t *
>  	return mode;
>  }
>  
> -static void config_cmd64x_chipset_for_pio (ide_drive_t *drive, u8 set_speed)
> -{
> -	u8 speed	= 0x00;
> -	u8 set_pio	= ide_get_best_pio_mode(drive, 4, 5, NULL);
> -
> -	cmd64x_tuneproc(drive, set_pio);
> -	speed = XFER_PIO_0 + set_pio;
> -	if (set_speed)
> -		(void) ide_config_drive_speed(drive, speed);
> -}
> -
> -static void config_chipset_for_pio (ide_drive_t *drive, u8 set_speed)
> -{
> -	config_cmd64x_chipset_for_pio(drive, set_speed);
> -}

[ ... ]

> @@ -461,8 +436,6 @@ static int config_chipset_for_dma (ide_d
>  {
>  	u8 speed	= ide_dma_speed(drive, cmd64x_ratemask(drive));
>  
> -	config_chipset_for_pio(drive, !speed);
> -

While this was always incorrectly setting PIO4, the PIO4 is "the usual" case
and for this driver we need to program PIO explicitly even when using DMA.
The core code doesn't program PIO mode unless told to (->autotune flag == 1)
so after the above change PIO mode won't be programmed et all.

I think that we now need to set ->autotune unconditionally in init_hwif_cmd64x().

Thanks,
Bart

