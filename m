From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/4] libata: revalidate after transfer mode configuration
Date: Tue, 21 Feb 2006 00:19:01 +0900
Message-ID: <43F9DDE5.3080501@gmail.com>
References: <11399977652003-git-send-email-htejun@gmail.com> <43F99F43.3020909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:25059 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030282AbWBTPTD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 10:19:03 -0500
Received: by zproxy.gmail.com with SMTP id n1so988277nzf
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 07:19:03 -0800 (PST)
In-Reply-To: <43F99F43.3020909@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Revalidate device after transfer mode configuration.  This also makes
>> dev->id up-to-date.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> ---
>>
>>  drivers/scsi/libata-core.c |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> 4580280ce48d62d2d801cd427e6194f9ab56e84b
>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>> index 54ed8fd..c971c15 100644
>> --- a/drivers/scsi/libata-core.c
>> +++ b/drivers/scsi/libata-core.c
>> @@ -1620,6 +1620,12 @@ static void ata_dev_set_mode(struct ata_
>>      idx = ofs + dev->xfer_shift;
>>      WARN_ON(idx >= ARRAY_SIZE(xfer_mode_str));
>>  
>> +    if (ata_dev_revalidate(ap, dev, 0)) {
>> +        printk(KERN_ERR "ata%u: failed to revalidate after set "
>> +               "xfermode, disabled\n", ap->id);
>> +        ata_port_disable(ap);
>> +    }
> 
> 
> why disable the entire port on error?
> 

Because that's what ata_set_mode() and its descendants does currently. 
They disable port on failure. I didn't want to introduce new behavior 
with this patch. The port disable -> device disable conversion will be 
done in later patch series together with all other parts of 
ata_set_mode(). No?

-- 
tejun
