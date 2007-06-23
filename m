From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 5/6] ide: add ata_dev_has_iordy() helper
Date: Sat, 23 Jun 2007 23:36:50 +0400
Message-ID: <467D7652.7070105@ru.mvista.com>
References: <200706232005.10968.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:15417 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755546AbXFWTfI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 15:35:08 -0400
In-Reply-To: <200706232005.10968.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

    This one is actually arguable...

> * Add ata_dev_has_iordy() helper.

    I thought IDE subsys make use of only 'ide_' prefixes. :-)

> * Use it in sl82c105 host driver so it always gets the correct info
>   (use_iordy was incorrectly set for "pio" != 255 cases).

    Hm, why incorrectly? ATA specs say PIO3/4 *must* use IORDY flow control, 
IIRC... :-/
    Maybe you meant the mode is being later adjusted by max_mode thereshold -- 
well, that's a common issue in ide_get_best_pio_mode().

> * Remove no longer needed ide_pio_data_t.use_iordy field.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/ide-lib.c
> ===================================================================
> --- a/drivers/ide/ide-lib.c
> +++ b/drivers/ide/ide-lib.c
> @@ -267,18 +267,15 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
>  {
>  	int pio_mode;
>  	int cycle_time = 0;
> -	int use_iordy = 0;
>  	struct hd_driveid* id = drive->id;
>  	int overridden  = 0;
>  
>  	if (mode_wanted != 255) {
>  		pio_mode = mode_wanted;
> -		use_iordy = (pio_mode > 2);
>  	} else if (!drive->id) {
>  		pio_mode = 0;
>  	} else if ((pio_mode = ide_scan_pio_blacklist(id->model)) != -1) {
>  		printk(KERN_INFO "%s: is on PIO blacklist\n", drive->name);
> -		use_iordy = (pio_mode > 2);
>  	} else {
>  		pio_mode = id->tPIO;
>  		if (pio_mode > 2) {	/* 2 is maximum allowed tPIO value */
> @@ -287,7 +284,6 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
>  		}
>  		if (id->field_valid & 2) {	  /* drive implements ATA2? */
>  			if (id->capability & 8) { /* drive supports use_iordy? */

    The comment above needs fixing too -- kill reference to use_iordy.

> -				use_iordy = 1;
>  				cycle_time = id->eide_pio_iordy;
>  				if (id->eide_pio_modes & 7) {
>  					overridden = 0;
> @@ -325,7 +321,6 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
>  	if (d) {
>  		d->pio_mode = pio_mode;
>  		d->cycle_time = cycle_time ? cycle_time : ide_pio_timings[pio_mode].cycle_time;
> -		d->use_iordy = use_iordy;
>  	}
>  	return pio_mode;
>  }
> Index: b/drivers/ide/pci/sl82c105.c
> ===================================================================
> --- a/drivers/ide/pci/sl82c105.c
> +++ b/drivers/ide/pci/sl82c105.c
> @@ -52,9 +52,10 @@
>   * Convert a PIO mode and cycle time to the required on/off times
>   * for the interface.  This has protection against runaway timings.
>   */
> -static unsigned int get_pio_timings(ide_pio_data_t *p)
> +static unsigned int get_pio_timings(ide_drive_t *drive, ide_pio_data_t *p)
>  {
>  	unsigned int cmd_on, cmd_off;
> +	u8 iordy = 0;
>  
>  	cmd_on  = (ide_pio_timings[p->pio_mode].active_time + 29) / 30;
>  	cmd_off = (p->cycle_time - 30 * cmd_on + 29) / 30;
> @@ -65,7 +66,10 @@ static unsigned int get_pio_timings(ide_
>  	if (cmd_off == 0)
>  		cmd_off = 1;
>  
> -	return (cmd_on - 1) << 8 | (cmd_off - 1) | (p->use_iordy ? 0x40 : 0x00);
> +	if (p->pio_mode > 2 || ata_dev_has_iordy(drive->id))
> +		iordy = 0x40;

    This logic, although mimicking the old one from ide_get_best_pio_mode(), 
is not quite correct. As have been noted before, when you set a PIO mode using 
Set Transfer Mode subcode of the Set Features command, you're always selecting 
the flow control mode, i.e. using IORDY. So, the last condition in this if 
stmt should probably be the first, if not the sole one...

> +	return (cmd_on - 1) << 8 | (cmd_off - 1) | iordy;
>  }
>  
>  /*
> @@ -82,7 +86,7 @@ static u8 sl82c105_tune_pio(ide_drive_t 
>  
>  	pio = ide_get_best_pio_mode(drive, pio, 5, &p);
>  
> -	drv_ctrl = get_pio_timings(&p);
> +	drv_ctrl = get_pio_timings(drive, &p);
>  
>  	/*
>  	 * Store the PIO timings so that we can restore them
> Index: b/include/linux/ide.h
> ===================================================================
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -1363,6 +1363,11 @@ extern void ide_toggle_bounce(ide_drive_
>  extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
>  int ide_use_fast_pio(ide_drive_t *);
>  
> +static inline int ata_dev_has_iordy(struct hd_driveid *id)
> +{
> +	return ((id->field_valid & 2) && (id->capability & 8)) ? 1 : 0;
> +}
> +
>  u8 ide_dump_status(ide_drive_t *, const char *, u8);
>  
>  typedef struct ide_pio_timings_s {
> @@ -1374,7 +1379,6 @@ typedef struct ide_pio_timings_s {
>  
>  typedef struct ide_pio_data_s {
>  	u8 pio_mode;
> -	u8 use_iordy;
>  	unsigned int cycle_time;
>  } ide_pio_data_t;
>  

MBR, Sergei
