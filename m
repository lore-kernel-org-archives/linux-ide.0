From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/8] ide: add ide_set_irq() inline helper
Date: Mon, 7 Jul 2008 20:00:26 +0200
Message-ID: <200807072000.26380.bzolnier@gmail.com>
References: <200711290104.21376.bzolnier@gmail.com> <48723A9B.6030309@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:21027 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872AbYGGSLK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2008 14:11:10 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1034422ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2008 11:11:00 -0700 (PDT)
In-Reply-To: <48723A9B.6030309@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Mikhail Cherkashin <mcherkashin@ru.mvista.com>


Hi,

On Monday 07 July 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hmm, this patch already went in on Jan 26
(commit 81ca691981da718727281238b435dcf1528d2fda).

>     We're getting "ide0: unexpected interrupt, status=0x58, count=1" with 
> palm_bk3710 driver when running hdparm with option -X. That interrupt has 
> beenidentidied to occur while ide_driveid_update() waits for non-BSY status 
> polling the alt. status reg.  After looking at the code there, I couldn't help 
> wondering why I never saw that before with any other controller since the code 
> looked like it was bound to produce the unexpected interrupts -- unless I'm 
> missing something?..

You are right, I've also noticed this old bug while working on the patch
but I didn't have time to deal with it yet (it was kind of low-prio since
it doesn't affect IDE PCI controllers and has been there for a long time).

[ BTW I would _strongly_ prefer to discuss the old bugs under new threads
  instead of replying to unrelated patches which just happen to be touching
  the buggy code (like my patch which didn't cause any funtionality changes
  and was just a preparation for adding struct ide_tp_ops). ]

> > Index: b/drivers/ide/ide-iops.c
> > ===================================================================
> > --- a/drivers/ide/ide-iops.c
> > +++ b/drivers/ide/ide-iops.c
> > @@ -688,8 +688,7 @@ int ide_driveid_update(ide_drive_t *driv
> >  	 */
> >  
> >  	SELECT_MASK(drive, 1);
> > -	if (IDE_CONTROL_REG)
> > -		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);
> > +	ide_set_irq(drive, 1);
> 
>     If we're going to execute the command using polling, isn't it logical to 
> *disable* drive's interrupt instead of enabling it which this code is 
> currently doing?  This looks like it might work only for the drivers having 
> the maskproc() method (of which hpt366.c is the only one that I've ever dealt 
> with).

Yes, this needs fixing.

> >  	msleep(50);
> 
>     Not sure why this substantial delay is needed at all...

Probably not neeed - this code was historically based on ide-probe.c
so I guess it came from there.

> >  	hwif->OUTB(WIN_IDENTIFY, IDE_COMMAND_REG);
> >  	timeout = jiffies + WAIT_WORSTCASE;
> 
>     Here's the code that follows:
> 
> >         do {
> 
>     The unexpected interrupt happens in this loop -- no wonder, we have no 
> hwgroup->handler installed.
> 
> >                 if (time_after(jiffies, timeout)) {
> >                         SELECT_MASK(drive, 0);
> >                         return 0;       /* drive timed-out */
> >                 }
> >                                                                                 
> >                 msleep(50);     /* give drive a breather */
> 
>     Isn't that too much for "a breather"? :-)

ditto

> >                 stat = ide_read_altstatus(drive);
> >         } while (stat & BUSY_STAT);
> >                                                                                 
> >         msleep(50);     /* wait for IRQ and DRQ_STAT */
> 
>     Again, isn't that too much?

ditto

> >         stat = ide_read_status(drive);
> 
>     This should clear the interrupt pending state on drive...
> 
> >         if (!OK_STAT(stat, DRQ_STAT, BAD_R_STAT)) {
> >                 SELECT_MASK(drive, 0);
> >                 printk("%s: CHECK for good STATUS\n", drive->name);
> >                 return 0;
> >         }
> >         local_irq_save(flags);
> >         SELECT_MASK(drive, 0);
> >         id = kmalloc(SECTOR_WORDS*4, GFP_ATOMIC);
> >         if (!id) {
> >                 local_irq_restore(flags);
> >                 return 0;
> >         }
> >         hwif->input_data(drive, NULL, id, SECTOR_SIZE);
> >         (void)ide_read_status(drive);   /* clear drive IRQ */
> 
>     Too late, it's been surely cleared already.

Agreed.

> >         local_irq_enable();
> >         local_irq_restore(flags);
> 
>     What's interesting, ide_config_drive_speed() code looks sane in this respect:
> 
> > @@ -769,13 +768,12 @@ int ide_config_drive_speed(ide_drive_t *
> >  	SELECT_DRIVE(drive);
> >  	SELECT_MASK(drive, 0);
> >  	udelay(1);
> > -	if (IDE_CONTROL_REG)
> > -		hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
> > +	ide_set_irq(drive, 0);
> 
>     This correctly sets nIEN... The code als calls disable_irq_nosync() which 
> might be an overkill
> 
> >  	hwif->OUTB(speed, IDE_NSECTOR_REG);
> >  	hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
> >  	hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
> > -	if ((IDE_CONTROL_REG) && (drive->quirk_list == 2))
> > -		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
> > +	if (drive->quirk_list == 2)
> > +		ide_set_irq(drive, 1);
> 
>     I'm just not sure why set nIEN on the quirky drives at all...

Agreed (however deserves a separate patch just in case we're wrong).

Since you have both the affected hardware and needed expertise
I assume that you'll take care fixing ide_driveid_update()?

Thanks,
Bart
