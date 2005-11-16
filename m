From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/5] sil24:  make error_intr less verbose
Date: Wed, 16 Nov 2005 22:27:14 +0900
Message-ID: <437B33B2.2010804@gmail.com>
References: <20051116080935.GE22807@htj.dyndns.org> <437B285C.8020809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:11606 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030327AbVKPN1V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 08:27:21 -0500
Received: by zproxy.gmail.com with SMTP id 14so1857304nzn
        for <linux-ide@vger.kernel.org>; Wed, 16 Nov 2005 05:27:20 -0800 (PST)
In-Reply-To: <437B285C.8020809@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> sil24_error_intr is too verbose.  Shut it up.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> Index: work/drivers/scsi/sata_sil24.c
>> ===================================================================
>> --- work.orig/drivers/scsi/sata_sil24.c    2005-11-16 
>> 17:05:19.000000000 +0900
>> +++ work/drivers/scsi/sata_sil24.c    2005-11-16 17:08:05.000000000 +0900
>> @@ -678,9 +678,9 @@ static void sil24_error_intr(struct ata_
>>      if (serror)
>>          writel(serror, port + PORT_SERROR);
>>  
>> -    printk(KERN_ERR DRV_NAME " ata%u: error interrupt on port%d\n"
>> -           "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
>> -           ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, 
>> sstatus, serror);
>> +    DPRINTK("ata%u: error interrupt on port%d\n"
>> +        "  stat=0x%x irq=0x%x cmd_err=%d sstatus=0x%x serror=0x%x\n",
>> +        ap->id, ap->port_no, slot_stat, irq_stat, cmd_err, sstatus, 
>> serror);
> 
> 
> Mild NAK.
> 
> I am grappling with this on AHCI too :)  This is because ATA_ERR is much 
> more common on ATAPI, yes?

Yeap.

> 
> My preferred change would be
> 
>     if ((class != ATA_DEV_ATAPI) ||
>         (sil24_cmd_err > PORT_CERR_SDB))
>         printk()
> 
> so that truly uncommon errors are always printed, but users logs are not 
> spammed.
> 
> Another option is to do
> 
>     if (ata_ratelimit())
>         printk()
> 

I'll go for the first one.  ATAPI devices can spit a lot of harmless 
errors and I think it's best if users don't see any of those.

-- 
tejun
