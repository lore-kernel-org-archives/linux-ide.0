From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: add ide_pio_cycle_time() helper (take 2)
Date: Mon, 2 Jul 2007 20:48:26 +0200
Message-ID: <200707022048.26488.bzolnier@gmail.com>
References: <200707010045.24252.bzolnier@gmail.com> <46893CCB.3050901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:3945 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbXGBSbs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 14:31:48 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1314070ugf
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 11:31:47 -0700 (PDT)
In-Reply-To: <46893CCB.3050901@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Monday 02 July 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Add ide_pio_cycle_time() helper.
> 
>     The side effect is that cycle time "clamping" for the pre ATA-2 drives is 
> now done for the explicitly specified modes too.

Yep.

> > * Use it in ali14xx/ht6560b/qd65xx/cmd64{0,x}/sl82c105 and pmac host drivers
> >   (previously cycle time given by the device was only used for "pio" == 255).
> 
> > * Remove no longer needed ide_pio_data_t.cycle_time field.
> 
> > v2:
> > * Fix "ata_" prefix (Noticed by Jeff).
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

added

> > Index: b/drivers/ide/ide-lib.c
> > ===================================================================
> > --- a/drivers/ide/ide-lib.c
> > +++ b/drivers/ide/ide-lib.c
> > @@ -249,6 +249,29 @@ static int ide_scan_pio_blacklist (char 
> >  	return -1;
> >  }
> >  
> > +unsigned int ide_pio_cycle_time(ide_drive_t *drive, u8 pio)
> > +{
> > +	struct hd_driveid *id = drive->id;
> > +	int cycle_time = 0;
> > +
> > +	if (id->field_valid & 2) {
> > +		if (id->capability & 8)
> > +			cycle_time = id->eide_pio_iordy;
> > +		else
> > +			cycle_time = id->eide_pio;
> > +	}
> > +
> > +	/* conservative "downgrade" for all pre-ATA2 drives */
> > +	if (pio < 3) {
> > +		if (cycle_time && cycle_time < ide_pio_timings[pio].cycle_time)
> 
>     Could be collapsed into single if() w/o braces...
> 
> > +			cycle_time = 0; /* use standard timing */
> > +	}
> > +
> > +	return cycle_time ? cycle_time : ide_pio_timings[pio].cycle_time;
> > +}
> > +
> > +EXPORT_SYMBOL_GPL(ide_pio_cycle_time);
> > +
> >  /**
> >   *	ide_get_best_pio_mode	-	get PIO mode from drive
> >   *	@drive: drive to consider
> [...]
> > Index: b/drivers/ide/pci/sl82c105.c
> > ===================================================================
> > --- a/drivers/ide/pci/sl82c105.c
> > +++ b/drivers/ide/pci/sl82c105.c
> > @@ -52,13 +52,13 @@
> >   * Convert a PIO mode and cycle time to the required on/off times
> >   * for the interface.  This has protection against runaway timings.
> >   */
> > -static unsigned int get_pio_timings(ide_drive_t *drive, ide_pio_data_t *p)
> > +static unsigned int get_pio_timings(ide_drive_t *drive, u8 pio)
> >  {
> >  	unsigned int cmd_on, cmd_off;
> >  	u8 iordy = 0;
> >  
> > -	cmd_on  = (ide_pio_timings[p->pio_mode].active_time + 29) / 30;
> > -	cmd_off = (p->cycle_time - 30 * cmd_on + 29) / 30;
> > +	cmd_on  = (ide_pio_timings[pio].active_time + 29) / 30;
> > +	cmd_off = (ide_pio_cycle_time(drive, pio) - 30 * cmd_on + 29) / 30;
> >  
> >  	if (cmd_on == 0)
> >  		cmd_on = 1;
> > @@ -66,7 +66,7 @@ static unsigned int get_pio_timings(ide_
> >  	if (cmd_off == 0)
> >  		cmd_off = 1;
> >  
> > -	if (p->pio_mode > 2 || ide_dev_has_iordy(drive->id))
> > +	if (pio > 2 || ide_dev_has_iordy(drive->id))
> >  		iordy = 0x40;
> >  
> >  	return (cmd_on - 1) << 8 | (cmd_off - 1) | iordy;
> > @@ -79,14 +79,13 @@ static u8 sl82c105_tune_pio(ide_drive_t 
> >  {
> >  	struct pci_dev *dev	= HWIF(drive)->pci_dev;
> >  	int reg			= 0x44 + drive->dn * 4;
> > -	ide_pio_data_t p;
> >  	u16 drv_ctrl;
> >  
> >  	DBG(("sl82c105_tune_pio(drive:%s, pio:%u)\n", drive->name, pio));
> >  
> > -	pio = ide_get_best_pio_mode(drive, pio, 5, &p);
> > +	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
> >  
> > -	drv_ctrl = get_pio_timings(drive, &p);
> > +	drv_ctrl = get_pio_timings(drive, pio);
> >  
> >  	/*
> >  	 * Store the PIO timings so that we can restore them
> > @@ -105,7 +104,8 @@ static u8 sl82c105_tune_pio(ide_drive_t 
> >  	}
> >  
> >  	printk(KERN_DEBUG "%s: selected %s (%dns) (%04X)\n", drive->name,
> > -	       ide_xfer_verbose(pio + XFER_PIO_0), p.cycle_time, drv_ctrl);
> > +			  ide_xfer_verbose(pio + XFER_PIO_0),
> > +			  ide_pio_cycle_time(drive, pio), drv_ctrl);
> 
>     Erm, why not calculate cycle time once and pass it to get_pio_timings()?

Good idea, care to send a patch?

> > Index: b/include/linux/ide.h
> > ===================================================================
> > --- a/include/linux/ide.h
> > +++ b/include/linux/ide.h
> > @@ -1379,9 +1379,9 @@ typedef struct ide_pio_timings_s {
> >  
> >  typedef struct ide_pio_data_s {
> >  	u8 pio_mode;
> > -	unsigned int cycle_time;
> >  } ide_pio_data_t;
> 
>     Might as well have killed the whole structure with this patch...

I didn't want to mixup fixup/cleanup changes...

Bart
