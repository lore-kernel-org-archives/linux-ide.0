From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/8] ide: add ide_set_irq() inline helper
Date: Mon, 07 Jul 2008 19:47:39 +0400
Message-ID: <48723A9B.6030309@ru.mvista.com>
References: <200711290104.21376.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:54770 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752677AbYGGPri (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Jul 2008 11:47:38 -0400
In-Reply-To: <200711290104.21376.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikhail Cherkashin <mcherkashin@ru.mvista.com>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

    We're getting "ide0: unexpected interrupt, status=0x58, count=1" with 
palm_bk3710 driver when running hdparm with option -X. That interrupt has 
beenidentidied to occur while ide_driveid_update() waits for non-BSY status 
polling the alt. status reg.  After looking at the code there, I couldn't help 
wondering why I never saw that before with any other controller since the code 
looked like it was bound to produce the unexpected interrupts -- unless I'm 
missing something?..

> Index: b/drivers/ide/ide-iops.c
> ===================================================================
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
> @@ -688,8 +688,7 @@ int ide_driveid_update(ide_drive_t *driv
>  	 */
>  
>  	SELECT_MASK(drive, 1);
> -	if (IDE_CONTROL_REG)
> -		hwif->OUTB(drive->ctl,IDE_CONTROL_REG);
> +	ide_set_irq(drive, 1);

    If we're going to execute the command using polling, isn't it logical to 
*disable* drive's interrupt instead of enabling it which this code is 
currently doing?  This looks like it might work only for the drivers having 
the maskproc() method (of which hpt366.c is the only one that I've ever dealt 
with).

>  	msleep(50);

    Not sure why this substantial delay is needed at all...

>  	hwif->OUTB(WIN_IDENTIFY, IDE_COMMAND_REG);
>  	timeout = jiffies + WAIT_WORSTCASE;

    Here's the code that follows:

>         do {

    The unexpected interrupt happens in this loop -- no wonder, we have no 
hwgroup->handler installed.

>                 if (time_after(jiffies, timeout)) {
>                         SELECT_MASK(drive, 0);
>                         return 0;       /* drive timed-out */
>                 }
>                                                                                 
>                 msleep(50);     /* give drive a breather */

    Isn't that too much for "a breather"? :-)

>                 stat = ide_read_altstatus(drive);
>         } while (stat & BUSY_STAT);
>                                                                                 
>         msleep(50);     /* wait for IRQ and DRQ_STAT */

    Again, isn't that too much?

>         stat = ide_read_status(drive);

    This should clear the interrupt pending state on drive...

>         if (!OK_STAT(stat, DRQ_STAT, BAD_R_STAT)) {
>                 SELECT_MASK(drive, 0);
>                 printk("%s: CHECK for good STATUS\n", drive->name);
>                 return 0;
>         }
>         local_irq_save(flags);
>         SELECT_MASK(drive, 0);
>         id = kmalloc(SECTOR_WORDS*4, GFP_ATOMIC);
>         if (!id) {
>                 local_irq_restore(flags);
>                 return 0;
>         }
>         hwif->input_data(drive, NULL, id, SECTOR_SIZE);
>         (void)ide_read_status(drive);   /* clear drive IRQ */

    Too late, it's been surely cleared already.

>         local_irq_enable();
>         local_irq_restore(flags);

    What's interesting, ide_config_drive_speed() code looks sane in this respect:

> @@ -769,13 +768,12 @@ int ide_config_drive_speed(ide_drive_t *
>  	SELECT_DRIVE(drive);
>  	SELECT_MASK(drive, 0);
>  	udelay(1);
> -	if (IDE_CONTROL_REG)
> -		hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
> +	ide_set_irq(drive, 0);

    This correctly sets nIEN... The code als calls disable_irq_nosync() which 
might be an overkill

>  	hwif->OUTB(speed, IDE_NSECTOR_REG);
>  	hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
>  	hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
> -	if ((IDE_CONTROL_REG) && (drive->quirk_list == 2))
> -		hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
> +	if (drive->quirk_list == 2)
> +		ide_set_irq(drive, 1);

    I'm just not sure why set nIEN on the quirky drives at all...

>  	error = __ide_wait_stat(drive, drive->ready_stat,
>  				BUSY_STAT|DRQ_STAT|ERR_STAT,

    Here's the code of ide_set_irq() for the reference:

> Index: b/include/linux/ide.h
> ===================================================================
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -1302,4 +1302,9 @@ static inline ide_drive_t *ide_get_paire
>  	return &hwif->drives[(drive->dn ^ 1) & 1];
>  }
>  
> +static inline void ide_set_irq(ide_drive_t *drive, int on)
> +{
> +	drive->hwif->OUTB(drive->ctl | (on ? 0 : 2), IDE_CONTROL_REG);
> +}
> +
>  #endif /* _IDE_H */

MBR, Sergei
