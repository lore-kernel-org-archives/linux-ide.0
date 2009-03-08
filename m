From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] ide: add support for CFA specified transfer modes
 (take 2)
Date: Mon, 09 Mar 2009 00:05:46 +0300
Message-ID: <49B4332A.8080206@ru.mvista.com>
References: <200903072009.47157.sshtylyov@ru.mvista.com> <49B2E351.3080803@ru.mvista.com> <200903081743.49038.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5556 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754761AbZCHVFy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Mar 2009 17:05:54 -0400
In-Reply-To: <200903081743.49038.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, stf_xl@wp.pl

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>> Add support for the CompactFlash specific PIO modes 5/6 and MWDMA modes 3/4.
>>>
>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>>>
>>> ---
>>> Did two changes after Bart's review:
>>> - fixed wrong mask in ide_config_drive_speed();
>>> - clarified comment in ide_pio_cycle_time().
>>>
>>> This patch is against the current pata-2.6 series. Since there were no PIO5
>>> capable hard drives produced and you also need 66 MHz input clock to actually
>>> get the difference WRT the setup timing programmed, I decided to simply replace
>>> the old non-standard PIO mode 5 timings with CFA specified ones.
>>> Phew, hopefully I haven't overlooked anything -- quite a lot had to be changed.
>>>
>>> Stanislaw, please give it a try -- I don't have any CF hardware now.
>>>   
>>>       
>> [...]
>>     
>>> Index: linux-2.6/drivers/ide/ide-iops.c
>>> ===================================================================
>>> --- linux-2.6.orig/drivers/ide/ide-iops.c
>>> +++ linux-2.6/drivers/ide/ide-iops.c
>>> @@ -389,6 +389,8 @@ int ide_config_drive_speed(ide_drive_t *
>>>  	id[ATA_ID_UDMA_MODES]  &= ~0xFF00;
>>>  	id[ATA_ID_MWDMA_MODES] &= ~0x0F00;
>>>  	id[ATA_ID_SWDMA_MODES] &= ~0x0F00;
>>> +	if (ata_id_is_cfa(id))
>>> +		id[ATA_ID_CFA_MODES] &= ~0x0FC0;
>>>   
>>>       
>>    Oops, won't this fragment clear the current DMA mode when setting PIO 
>> mode (and so vice versa for CF)?
>>     
>
> Indeed, however since we never check selected modes later (except
> ide_id_dma_bug() but its intent is to check for buggy devices)
> there is no much point in all these id hacks and this seems to be
> the perfect opportunity to just remove them.
>   

  Doesn't this serve for e.g. presenting the current identify data via 
procfs? I've been already considering fixing this...

> Thanks,
> Bart
>   

MBR, Sergei


