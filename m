From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] ide: add support for CFA specified transfer modes
Date: Mon, 09 Mar 2009 00:07:09 +0300
Message-ID: <49B4337D.2030806@ru.mvista.com>
References: <200903032034.49372.sshtylyov@ru.mvista.com> <200903071723.26150.bzolnier@gmail.com> <49B2A5C1.8090409@ru.mvista.com> <200903081738.01959.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5573 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753421AbZCHVHQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Mar 2009 17:07:16 -0400
In-Reply-To: <200903081738.01959.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, stf_xl@wp.pl

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>> Add support for the CompactFlash specific PIO modes 5/6 and MWDMA modes 3/4.
>>>>         
>>> Thanks for picking this up.
>>>       
>>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>>>         
>>>> ---
>>>> This patch is against the current pata-2.6 series. Since there were no PIO5
>>>> capable hard drives produced and you also need 66 MHz input clock to actually
>>>> get the difference WRT the setup timing programmed, I decided to simply replace
>>>> the old non-standard PIO mode 5 timings with CFA specified ones.
>>>> Phew, hopefully I haven't overlooked anything -- quite a lot had to be changed.
>>>>         
>>> It looks fine overall, few comments below.
>>>       

[...]

>>>> @@ -90,6 +93,10 @@ u16 ide_pio_cycle_time(ide_drive_t *driv
>>>> 		/* conservative "downgrade" for all pre-ATA2 drives */
>>>> 		if (pio < 3 && cycle < t->cycle)
>>>> 			cycle = 0; /* use standard timing */
>>>> +
>>>> +		/* IORDY must be ignored for CF specific PIO modes */
>>>> +		if (pio > 4 && ata_id_is_cfa(id))
>>>> +			cycle = 0; /* use standard timing */
>>>>         
>>> This comment seems out of place for the code dealing with cycle timing.
>>>       
>>> When it comes to IORDY I recalled that some host drivers already support
>>> "harddisk" PIO5 so they may need to be updated to not force IORDY setting
>>> (seems like at least sl82c105.c is affected).
>>>       
>>     I thought I have taken care of this with the generic code... the need for 
>> the driver-level CF specific changes looks iffy as not all these drivers ever 
>>     
>
> Theoretically all drivers can drive CF devices using IDE-CF adapters so we
>   

   I keep forgetting about this crap^W nice pieces of hardware... :-/

> shouldn't be making any such assumptions.  There are also some interesting
> hardware designs, i.e. Vortex 86SX SoC which uses ITE 8211 chipset for IDE
>   

   Do we support it? Ah, I'm seeing. But I'm not seeig any IORDY related 
logic in it821x.c...

> (embedded x86 devices using this SoC are often equipped with CF slot).
>   
>> drive CF. I need to think about it... won't be the part of this patch in any case.
>>     
>
> The problem is that <linux/ata.h> lacks ata_id_needs_iordy(id, pio) so
> drivers are using ata_id_has_iordy() which doesn't know about CF specific
>   

   Still not all are using even this -- e.g. piix.c doesn't. Oh 
horror... well, Russian has the saying, something like "the initiative 
should be punished"... :-)

> needs, i.e. sl82c105.c does:
>
>         if (pio > 2 || ata_id_has_iordy(drive->id))
>                 iordy = 0x40;
>   

   Yes, that's clear...

> and since the driver declares PIO5 support once this patch gets applied
> PIO5 will be used also for CF devices.
>   

   Hm, indeed -- looks like I *did* miss some things. :-/

> Thanks,
> Bart
>   

MBR, Sergei


