From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Dubious IRQ masking in ide_config_drive_speed()
Date: Fri, 11 Jul 2008 01:21:49 +0400
Message-ID: <48767D6D.6000009@ru.mvista.com>
References: <200711290104.21376.bzolnier@gmail.com> <48723A9B.6030309@ru.mvista.com> <4875FC63.7040309@ru.mvista.com> <200807112139.31353.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:57423 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751653AbYGJVVz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jul 2008 17:21:55 -0400
In-Reply-To: <200807112139.31353.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikhail Cherkashin <mcherkashin@ru.mvista.com>

Hello.

Bartlomiej Zolnierkiewicz wrote:
>>>> Index: b/drivers/ide/ide-iops.c
>>>> ===================================================================
>>>> --- a/drivers/ide/ide-iops.c
>>>> +++ b/drivers/ide/ide-iops.c
>>>>         
>> [...]
>>
>>     
>>>    What's interesting, ide_config_drive_speed() code looks sane in this 
>>> respect:
>>>       
>>     ... except one thing:
>>
>>     
>>>> @@ -769,13 +768,12 @@ int ide_config_drive_speed(ide_drive_t *
>>>>      SELECT_DRIVE(drive);
>>>>      SELECT_MASK(drive, 0);
>>>>         
>>     We've called disable_irq_nosync() before that, so it's not clear why we're 
>> calling the driver's maskproc() method with 0 -- which unmasks interrupt in 
>> the IDE chip.
>>     
>
> It seems to be an obvious bug (0 instead of 1) but it is hidden on almost
> all host drivers since they don't implement ->maskproc method (only icside,
> hpt366 and sgiioc4 do).
>   

   Speaking of which, the hpt366 and sgiioc4 drivers try to manipulate 
iIEN there which is none oif their business I think -- IDE core does 
that already.
The patches are cooking. ;-)

> [ disable_irq_nosync() is used due to other reasons than ->maskproc.
>
>   The former is a band-aid for racing against IRQ handler, the latter
>   

   Hm, but aren't we setting nIEN? Or could that cause a spuriuos interrupt?

>   is needed by icside to setup routing of IRQs

   Hm, that's what I asn't able to figure out gazing at it...

>  and by hpt366 to handle
>   ->quirk_list devices. ]
>   

   BTW, I was counting on your feedback concerning driver->quirk_list 
handling.
   Do you think the current patch for ide_driveid_update() is acceptable?

>>>>      udelay(1);
>>>> -    if (IDE_CONTROL_REG)
>>>> -        hwif->OUTB(drive->ctl | 2, IDE_CONTROL_REG);
>>>> +    ide_set_irq(drive, 0);
>>>>      hwif->OUTB(speed, IDE_NSECTOR_REG);
>>>>      hwif->OUTB(SETFEATURES_XFER, IDE_FEATURE_REG);
>>>>      hwif->OUTBSYNC(drive, WIN_SETFEATURES, IDE_COMMAND_REG);
>>>> -    if ((IDE_CONTROL_REG) && (drive->quirk_list == 2))
>>>> -        hwif->OUTB(drive->ctl, IDE_CONTROL_REG);
>>>> +    if (drive->quirk_list == 2)
>>>> +        ide_set_irq(drive, 1);
>>>>      error = __ide_wait_stat(drive, drive->ready_stat,
>>>>                  BUSY_STAT|DRQ_STAT|ERR_STAT,
>>>>         
>>     Another SELECT_MASK(drive, 0) call follows which just doesn't make any 
>> sense since the interrupt has been already unmasked by the first call.
>>     
>
> This one makes sense here if we assume that the previous one was buggy.
>   

   Of cousre. :-)

> Thanks,
> Bart
>   

MBR, Sergei


