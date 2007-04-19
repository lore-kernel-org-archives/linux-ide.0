From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 14/15] ide: rework the code for selecting the best DMA
 transfer mode
Date: Thu, 19 Apr 2007 23:46:55 +0400
Message-ID: <4627C72F.3070300@ru.mvista.com>
References: <20070203135301.2546.54884.sendpatchset@localhost.localdomain> <20070203135323.2546.29438.sendpatchset@localhost.localdomain> <4627C386.9020407@ru.mvista.com> <4627C5D1.5010602@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:36438 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1766976AbXDSTqA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Apr 2007 15:46:00 -0400
In-Reply-To: <4627C5D1.5010602@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:
>> Bartlomiej Zolnierkiewicz wrote:

>>> [PATCH] ide: rework the code for selecting the best DMA transfer mode 

>>> Depends on the "ide: fix UDMA/MWDMA/SWDMA masks" patch.

>>   I'm now trying to rewrite hpt366.c to benefit more from these 
>> patches...
>> and alas, this very patch seems to be breaking filtering (at least) in 
>> this driver. :-]

>>> Index: b/drivers/ide/ide-dma.c
>>> ===================================================================
>>> --- a/drivers/ide/ide-dma.c
>>> +++ b/drivers/ide/ide-dma.c
>>> @@ -705,6 +705,80 @@ int ide_use_dma(ide_drive_t *drive)
>>>  
>>>  EXPORT_SYMBOL_GPL(ide_use_dma);
>>>  
>>> +static const u8 xfer_mode_bases[] = {
>>> +    XFER_UDMA_0,
>>> +    XFER_MW_DMA_0,
>>> +    XFER_SW_DMA_0,
>>> +};
>>> +
>>> +static unsigned int ide_get_mode_mask(ide_drive_t *drive, u8 base)
>>> +{
>>> +    struct hd_driveid *id = drive->id;
>>> +    ide_hwif_t *hwif = drive->hwif;
>>> +    unsigned int mask = 0;
>>> +
>>> +    switch(base) {
>>> +    case XFER_UDMA_0:
>>> +        if ((id->field_valid & 4) == 0)
>>> +            break;
>>> +
>>> +        mask = id->dma_ultra & hwif->ultra_mask;
>>> +
>>> +        if (hwif->udma_filter)
>>> +            mask &= hwif->udma_filter(drive);
>>> +
>>> +        if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
>>> +            mask &= 0x07;
> 
> 
>>   Note the subtle difference between the old and new behavior: the old 
>> driver code was applying UltraDMA filter *after*
>> the cable type limit, and the new code does it *before*.

>   Was there any particular reason to change that order?

   Ah, I see. Cable-reduced mask can't be passed back to driver's filter. This needs changing.

MBR, Sergei
