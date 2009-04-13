From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: add CFA specific identify data words
Date: Mon, 13 Apr 2009 13:16:53 -0400
Message-ID: <49E37385.6070506@pobox.com>
References: <200903032029.29073.sshtylyov@ru.mvista.com> <49DC8EB3.4040404@ru.mvista.com> <49DCA588.7030403@pobox.com> <49E36CCE.6030304@ru.mvista.com> <49E36D97.4040606@pobox.com> <49E36F3F.6080907@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51146 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbZDMRRJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Apr 2009 13:17:09 -0400
In-Reply-To: <49E36F3F.6080907@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Jeff Garzik wrote:
> 
>>>>>> Declare and use constants for CFA specific identify data words 162 
>>>>>> and 163.
> 
>>>>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
>>>>>    Jeff, have you forgotten about this one too?
> 
>>>>>> Index: linux-2.6/drivers/ata/libata-core.c
>>>>>> ===================================================================
>>>>>> --- linux-2.6.orig/drivers/ata/libata-core.c
>>>>>> +++ linux-2.6/drivers/ata/libata-core.c
>>>>>> @@ -1650,8 +1650,8 @@ unsigned long ata_id_xfermask(const 
>>>>>> u16          /*
>>>>>>           *    Process compact flash extended modes
>>>>>>           */
>>>>>> -        int pio = id[163] & 0x7;
>>>>>> -        int dma = (id[163] >> 3) & 7;
>>>>>> +        int pio = (id[ATA_ID_CFA_MODES] >> 0) & 0x7;
>>>>>> +        int dma = (id[ATA_ID_CFA_MODES] >> 3) & 0x7;
>>>>>>  
>>>>>>          if (pio)
>>>>>>              pio_mask |= (1 << 5);
>>>>>> @@ -2408,7 +2408,8 @@ int ata_dev_configure(struct ata_device      
>>>>>> /* ATA-specific feature tests */
>>>>>>      if (dev->class == ATA_DEV_ATA) {
>>>>>>          if (ata_id_is_cfa(id)) {
>>>>>> -            if (id[162] & 1) /* CPRM may make this media unusable */
>>>>>> +            /* CPRM may make this media unusable */
>>>>>> +            if (id[ATA_ID_CFA_KEY_MGMT] & 1)
>>>>>>                  ata_dev_printk(dev, KERN_WARNING,
>>>>>>                             "supports DRM functions and may "
>>>>>>                             "not be fully accessable.\n");
> 
>>>> This you'll need to resend...
> 
>>>    I wonder why you're telling me this only now
> 
>> Because you asked "have you forgotten about this one?" on April 8th.
> 
>    I mean why didn't you tell me to resubmit when you split off the 
> ata.h part of the original patch? I was under impression that you would 
> queue this part too...

It got lost in the confusion, I suppose.  I figured you would resubmit 
when you posted the IDE version.

If you recall, you requested that this go via Bart's tree on March 3rd. 
  Then Bart did a big push without it.  So, to prevent delaying you 
further, I split off the ata.h patch and forwarded that upstream.

	Jeff



