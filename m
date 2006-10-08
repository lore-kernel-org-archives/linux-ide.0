From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: make user scan wait for scan to complete
Date: Sun, 08 Oct 2006 13:17:32 +0900
Message-ID: <45287BDC.8030002@gmail.com>
References: <20060930090717.GO25800@htj.dyndns.org> <4524EB00.9040309@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:48729 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751130AbWJHMqT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Oct 2006 08:46:19 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1658581nfb
        for <linux-ide@vger.kernel.org>; Sun, 08 Oct 2006 05:46:18 -0700 (PDT)
In-Reply-To: <4524EB00.9040309@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, fajunchen@gmail.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Make user scan wait for scan to complete.  This way user can wait for
>> warm plug request to complete and is prevented from causing EH event
>> storm by repetitively issuing scan request while EH is in progress.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> Cc: Fajun Chen <fajunchen@gmail.com>
>>
>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>> index 3986ec8..e1fe832 100644
>> --- a/drivers/ata/libata-scsi.c
>> +++ b/drivers/ata/libata-scsi.c
>> @@ -3138,10 +3138,12 @@ static int ata_scsi_user_scan(struct Scs
>>              rc = -EINVAL;
>>      }
>>  
>> -    if (rc == 0)
>> +    if (rc == 0) {
>>          ata_port_schedule_eh(ap);
>> -
>> -    spin_unlock_irqrestore(ap->lock, flags);
>> +        spin_unlock_irqrestore(ap->lock, flags);
>> +        ata_port_wait_eh(ap);
>> +    } else
>> +        spin_unlock_irqrestore(ap->lock, flags);
> 
> Given that we are now 2.6.19-rc1, would you say this applies to 
> #upstream-fixes or #upstream?
> 
> I'm OK with it either way.

I don't think this patch is urgent.  Let's queue it in #upstream.

-- 
tejun

