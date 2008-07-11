From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Dubious IRQ masking in ide_config_drive_speed()
Date: Fri, 11 Jul 2008 21:39:30 +0200
Message-ID: <200807112139.31353.bzolnier@gmail.com>
References: <200711290104.21376.bzolnier@gmail.com> <48723A9B.6030309@ru.mvista.com> <4875FC63.7040309@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:5047 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbYGJTnh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jul 2008 15:43:37 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1183957yxm.1
        for <linux-ide@vger.kernel.org>; Thu, 10 Jul 2008 12:43:36 -0700 (PDT)
In-Reply-To: <4875FC63.7040309@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Mikhail Cherkashin <mcherkashin@ru.mvista.com>

On Thursday 10 July 2008, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >> Index: b/drivers/ide/ide-iops.c
> >> ===================================================================
> >> --- a/drivers/ide/ide-iops.c
> >> +++ b/drivers/ide/ide-iops.c
> [...]
> 
> >    What's interesting, ide_config_drive_speed() code looks sane in this 
> > respect:
> 
>     ... except one thing:
> 
> >> @@ -769,13 +768,12 @@ int ide_config_drive_speed(ide_drive_t *
> >>      SELECT_DRIVE(drive);
> >>      SELECT_MASK(drive, 0);
> 
>     We've called disable_irq_nosync() before that, so it's not clear why we're 
> calling the driver's maskproc() method with 0 -- which unmasks interrupt in 
> the IDE chip.

It seems to be an obvious bug (0 instead of 1) but it is hidden on almost
all host drivers since they don't implement ->maskproc method (only icside,
hpt366 and sgiioc4 do).

[ disable_irq_nosync() is used due to other reasons than ->maskproc.

  The former is a band-aid for racing against IRQ handler, the latter
  is needed by icside to setup routing of IRQs and by hpt366 to handle
  ->quirk_list devices. ]

> >>      udelay(1);
> >> -    if (IDE_CONTROL_REG)
> >> -        hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
> >> +    ide_set_irq(drive, 0);
> >>      hwif->OUTB(speed, IDE_NSECTOR_REG);
> >>      hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
> >>      hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
> >> -    if ((IDE_CONTROL_REG) && (drive->quirk_list == 2))
> >> -        hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
> >> +    if (drive->quirk_list == 2)
> >> +        ide_set_irq(drive, 1);
> >>      error = __ide_wait_stat(drive, drive->ready_stat,
> >>                  BUSY_STAT|DRQ_STAT|ERR_STAT,
> 
>     Another SELECT_MASK(drive, 0) call follows which just doesn't make any 
> sense since the interrupt has been already unmasked by the first call.

This one makes sense here if we assume that the previous one was buggy.

Thanks,
Bart
