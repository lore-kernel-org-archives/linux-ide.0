From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/8] ide: add ide_set_irq() inline helper
Date: Fri, 11 Jul 2008 16:57:22 +0400
Message-ID: <487758B2.8060909@ru.mvista.com>
References: <200711290104.21376.bzolnier@gmail.com> <200807072000.26380.bzolnier@gmail.com> <48732EF5.6080302@ru.mvista.com> <200807112320.04264.bzolnier@gmail.com> <487727C6.7040008@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:7255 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750924AbYGKM5S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jul 2008 08:57:18 -0400
In-Reply-To: <487727C6.7040008@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikhail Cherkashin <mcherkashin@ru.mvista.com>

Hello, I wrote:

>>>>>> Index: b/drivers/ide/ide-iops.c
>>>>>> ===================================================================
>>>>>> --- a/drivers/ide/ide-iops.c
>>>>>> +++ b/drivers/ide/ide-iops.c
>>>>>> @@ -688,8 +688,7 @@ int ide_driveid_update(ide_drive_t *driv
>>>>>>      */
>>>>>>
>>>>>>     SELECT_MASK(drive, 1);
>>>>>> -    if (IDE_CONTROL_REG)
>>>>>> -        hwif->OUTB(drive->ctl,IDE_CONTROL_REG);
>>>>>> +    ide_set_irq(drive, 1);

>>>>>    If we're going to execute the command using polling, isn't it 
>>>>> logical to *disable* drive's interrupt instead of enabling it which 
>>>>> this code is currently doing?  This looks like it might work only 
>>>>> for the drivers having the maskproc() method (of which hpt366.c is 
>>>>> the only one that I've ever dealt with).

>>>> Yes, this needs fixing.

>>>     But should we honor drive->quirk_list here? What its different 
>>> values mean? I'm seeing either 1 or 2 is used to decide whether to 
>>> set nIEN or not...

>> I did some research on ->quirk_list in the past but I couldn't exactly
>> figure it out.  I also wasn't able to trace this code to its author
>> (not that I tried very hard)...

>> Anyway my current findings/theories are the following:

>> - we should make sure that all SELECT_MASK() users also call ide_set_irq()
>>   (then sgiioc4's ->maskproc can be removed since it is a copy of ->set_irq)

>   I've kind of made sure about that already, 

    After another look, I've indeed correctly described this as "kind of" --
since ide_set_irq() is called only before issuing a command, while
SELECT_MASK() is called both before (but it seems to be always skipped due to 
IDE_TFLAG_NO_SELECT_MASK being set for the commands executed in a normal way, 
i.e. using interrupts) and after that (the latter is done if we are using the 
polling mode). So, those maskproc() methods in hpt366 and sgiioc4 in fact 
inadvertently clear nIEN after the polled command execution -- not that it's 
wrong but why the hell? And those maskproc() methods duplicate nIEN setup 
before the command execution -- except in ide_config_drive_speed() where 
there's an obvious error...

> hence I've already created a patch doing that...

    As I have no idea why sgiioc4 needs to manipulate nIEN, I guess I'll just 
CC the SGI people on that patch...

>> Thanks,
>> Bart

MBR, Sergei

