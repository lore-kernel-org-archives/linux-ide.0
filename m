From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 15/15] libata: consider disabled devices in ata_dev_xfermask()
Date: Sun, 02 Apr 2006 10:09:28 +0900
Message-ID: <442F2448.8060608@gmail.com>
References: <11438230993538-git-send-email-htejun@gmail.com> <442EDBCA.7050600@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:47517 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932362AbWDBBJf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 20:09:35 -0500
Received: by zproxy.gmail.com with SMTP id o37so1362153nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 17:09:35 -0800 (PST)
In-Reply-To: <442EDBCA.7050600@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> ata_bus_probe() now marks failed devices properly and leaves
>> meaningful transfer mode masks.  This patch makes ata_dev_xfermask()
>> consider disable devices when determining PIO mode to avoid violating
>> device selection timing.
>>
>> While at it, move port-wide resttriction out of device iteration loop
>> and try to make the function look a bit prettier.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> ---
>>
>>  drivers/scsi/libata-core.c |   34 +++++++++++++++++++++++-----------
>>  1 files changed, 23 insertions(+), 11 deletions(-)
>>
>> 523b496b7614981773c2c14259bbca4a7ba3a3e8
>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>> index ac2ca31..0d72792 100644
>> --- a/drivers/scsi/libata-core.c
>> +++ b/drivers/scsi/libata-core.c
>> @@ -2902,23 +2902,34 @@ static void ata_dev_xfermask(struct ata_
>>      unsigned long xfer_mask;
>>      int i;
>>  
>> -    xfer_mask = ata_pack_xfermask(ap->pio_mask, ap->mwdma_mask,
>> -                      ap->udma_mask);
>> +    xfer_mask = ata_pack_xfermask(ap->pio_mask,
>> +                      ap->mwdma_mask, ap->udma_mask);
>> +
>> +    /* Apply cable rule here.  Don't apply it early because when
>> +     * we handle hot plug the cable type can itself change.
>> +     */
>> +    if (ap->cbl == ATA_CBL_PATA40)
>> +        xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
> 
> ACK, though I wonder if moving the above code to its current position 
> violates "early" described in the comment.
> 

I think not. AFAICS the 'early' in the comment points ata_dev_xfermask() 
function itself.

Alan?

-- 
tejun
