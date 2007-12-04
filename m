From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/6] ide: add ide_busy_sleep() helper
Date: Tue, 4 Dec 2007 15:01:22 +0100
Message-ID: <200712041501.22872.bzolnier@gmail.com>
References: <200712032252.53249.bzolnier@gmail.com> <475548F1.6040308@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:48756 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbXLDNzX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 08:55:23 -0500
Received: by ug-out-1314.google.com with SMTP id z38so77825ugc
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 05:55:22 -0800 (PST)
In-Reply-To: <475548F1.6040308@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Tuesday 04 December 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Add ide_busy_sleep() helper and use it in do_probe(),
> > enable_nest() and probe_hwif().
> 
> > As a nice side-effect this fixes a minor bug in enable_nest()
> > (the code was reading status register without any delay).
> 
>     Huh?
> 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > Index: b/drivers/ide/ide-probe.c
> > ===================================================================
> > --- a/drivers/ide/ide-probe.c
> > +++ b/drivers/ide/ide-probe.c
> [...]
> > @@ -489,20 +499,16 @@ static int do_probe (ide_drive_t *drive,
> >  static void enable_nest (ide_drive_t *drive)
> >  {
> >  	ide_hwif_t *hwif = HWIF(drive);
> > -	unsigned long timeout;
> >  
> >  	printk("%s: enabling %s -- ", hwif->name, drive->id->model);
> >  	SELECT_DRIVE(drive);
> >  	msleep(50);
> >  	hwif->OUTB(EXABYTE_ENABLE_NEST, IDE_COMMAND_REG);
> > -	timeout = jiffies + WAIT_WORSTCASE;
> > -	do {
> > -		if (time_after(jiffies, timeout)) {
> > -			printk("failed (timeout)\n");
> > -			return;
> > -		}
> > -		msleep(50);
> 
>     Here's a delay, isn't it?

s/enable_nest/do_probe/

Thanks for pointing this out, I fixed patch description locally.

> > -	} while ((hwif->INB(IDE_STATUS_REG)) & BUSY_STAT);
> > +
> > +	if (ide_busy_sleep(hwif)) {
> > +		printk(KERN_CONT "failed (timeout)\n");
> > +		return;
> > +	}
> >  
> >  	msleep(50);
