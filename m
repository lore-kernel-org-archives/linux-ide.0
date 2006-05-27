From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: merge irq-pio
Date: Sat, 27 May 2006 09:53:05 +0900
Message-ID: <4477A2F1.9010404@gmail.com>
References: <11473544042174-git-send-email-htejun@gmail.com> <4472DE75.6010507@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.193]:15965 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750734AbWE0JbY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 May 2006 05:31:24 -0400
Received: by nz-out-0102.google.com with SMTP id s18so218965nze
        for <linux-ide@vger.kernel.org>; Sat, 27 May 2006 02:31:24 -0700 (PDT)
In-Reply-To: <4472DE75.6010507@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Tejun Heo wrote:
>> Merge irq-pio.
>>
> 
> <snip>
> 
>> diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
>> index 5b7fea5..56105a1 100644
>> --- a/drivers/scsi/sata_mv.c
>> +++ b/drivers/scsi/sata_mv.c
>> @@ -87,7 +87,7 @@ enum {
>>  	MV_FLAG_IRQ_COALESCE	= (1 << 29),  /* IRQ coalescing capability */
>>  	MV_COMMON_FLAGS		= (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>>  				   ATA_FLAG_SATA_RESET | ATA_FLAG_MMIO |
>> -				   ATA_FLAG_NO_ATAPI),
>> +				   ATA_FLAG_PIO_POLLING),
>>  	MV_6XXX_FLAGS		= MV_FLAG_IRQ_COALESCE,
>>  
>>  	CRQB_FLAG_READ		= (1 << 0),
> 
> The ATA_FLAG_NO_ATAPI flag is lost by automatic merge.

Ah... right.

Thanks for catching it.

-- 
tejun

