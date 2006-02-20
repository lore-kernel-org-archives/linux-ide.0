From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/4] libata: revalidate after transfer mode configuration
Date: Mon, 20 Feb 2006 17:00:33 -0500
Message-ID: <43FA3C01.30902@pobox.com>
References: <11399977652003-git-send-email-htejun@gmail.com> <43F99F43.3020909@pobox.com> <43F9DDE5.3080501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:19948 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932630AbWBTWAl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 17:00:41 -0500
In-Reply-To: <43F9DDE5.3080501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>> Tejun Heo wrote:
>>
>>> Revalidate device after transfer mode configuration.  This also makes
>>> dev->id up-to-date.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>>
>>> ---
>>>
>>>  drivers/scsi/libata-core.c |    6 ++++++
>>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>>
>>> 4580280ce48d62d2d801cd427e6194f9ab56e84b
>>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>>> index 54ed8fd..c971c15 100644
>>> --- a/drivers/scsi/libata-core.c
>>> +++ b/drivers/scsi/libata-core.c
>>> @@ -1620,6 +1620,12 @@ static void ata_dev_set_mode(struct ata_
>>>      idx = ofs + dev->xfer_shift;
>>>      WARN_ON(idx >= ARRAY_SIZE(xfer_mode_str));
>>>  
>>> +    if (ata_dev_revalidate(ap, dev, 0)) {
>>> +        printk(KERN_ERR "ata%u: failed to revalidate after set "
>>> +               "xfermode, disabled\n", ap->id);
>>> +        ata_port_disable(ap);
>>> +    }
>>
>>
>>
>> why disable the entire port on error?
>>
> 
> Because that's what ata_set_mode() and its descendants does currently. 
> They disable port on failure. I didn't want to introduce new behavior 
> with this patch. The port disable -> device disable conversion will be 
> done in later patch series together with all other parts of 
> ata_set_mode(). No?

OK


