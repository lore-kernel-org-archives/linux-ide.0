From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/15] libata: add 1s sleep between resets
Date: Sun, 02 Apr 2006 10:07:34 +0900
Message-ID: <442F23D6.6030703@gmail.com>
References: <1143823099305-git-send-email-htejun@gmail.com> <442EDB0C.4030103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:20626 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932361AbWDBBHm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 20:07:42 -0500
Received: by zproxy.gmail.com with SMTP id o37so1361838nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 17:07:42 -0800 (PST)
In-Reply-To: <442EDB0C.4030103@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Some devices react badly if resets are performed back-to-back.  Give
>> devices some time to breath.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> ---
>>
>>  drivers/scsi/libata-core.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> e7f505c001fd4cb43b8123387285a7694790b4ae
>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>> index 30ee203..bd9ca3b 100644
>> --- a/drivers/scsi/libata-core.c
>> +++ b/drivers/scsi/libata-core.c
>> @@ -2633,6 +2633,7 @@ int ata_drive_probe_reset(struct ata_por
>>          rc = ata_do_reset(ap, softreset, postreset, 0, classes);
>>          if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
>>              goto done;
>> +        ssleep(1);
>>      }
>>  
>>      if (!hardreset)
>> @@ -2649,6 +2650,7 @@ int ata_drive_probe_reset(struct ata_por
>>  
>>          if (ata_down_sata_spd_limit(ap, &ap->device[0]))
>>              goto done;
>> +        ssleep(1);
> 
> My gut says it should be at least 5 seconds...
> 

Okay. And I'll add a little message such that the user staring at the 
console doesn't get bored during that 5 secs.

-- 
tejun
