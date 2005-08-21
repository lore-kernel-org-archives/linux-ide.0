From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH linux-2.6.13-rc3] Mod15Write quirk against v2.6.13
Date: Sun, 21 Aug 2005 16:11:37 -0400
Message-ID: <4308DFF9.4080107@pobox.com>
References: <1121894035.4885.15.camel@drevil.aslab.com> <20050728141242.GA10010@htj.dyndns.org> <4308D73A.9000600@pobox.com> <4308DC5E.9020500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:60105 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751110AbVHUVM3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:12:29 -0400
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LKBgNh006576
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 13:11:42 -0700
In-Reply-To: <4308DC5E.9020500@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michael Madore <Michael.Madore@aslab.com>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, Douglas Gilbert <dougg@torque.net>

Tejun Heo wrote:
> 
>  Hi, Jeff.
> 
> Jeff Garzik wrote:
> 
>> Tejun Heo wrote:
>>
>>>  sata_sil Mod15Write workaround was broken by the following commit by
>>> Albert Lee.
>>>
>>> Commit: 21b1ed74ee3667dcabcba92e486988ea9119a085
>>> [PATCH] libata: Prevent the interrupt handler from completing a 
>>> command twice
>>>
>>>  This commit clears ATA_QCFLAG_ACTIVE in ata_qc_complete() and doesn't
>>> handle IRQ if ATA_QCFLAG_ACTIVE is cleared on entry to interrupt
>>> routine.  As m15w workaround executes single command multiple times,
>>> the flag is cleared after the first chunk completion and the following
>>> interrupt gets ignored resulting in "nobody cared" interrupt error.
>>>
>>>  The following changes are made in m15w workaround to fix this.
>>>
>>>  * Moved clearing of ATA_QCFLAG_ACTIVE before invoking ->complete_fn,
>>>    so that ->complete_fn can mangle with the flag.  This doesn't affect
>>>    any users.
>>>  * Added setting ATA_QCFLAG_ACTIVE in m15w chunk completion function.
>>
>>
>>
>>> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
>>> --- a/drivers/scsi/libata-core.c
>>> +++ b/drivers/scsi/libata-core.c
>>> @@ -3087,8 +3087,8 @@ void ata_qc_complete(struct ata_queued_c
>>>          ata_sg_clean(qc);
>>>  
>>>      /* call completion callback */
>>> -    rc = qc->complete_fn(qc, drv_stat);
>>>      qc->flags &= ~ATA_QCFLAG_ACTIVE;
>>> +    rc = qc->complete_fn(qc, drv_stat);
>>>  
>>>      /* if callback indicates not to complete command (non-zero),
>>>       * return immediately
>>
>>
>>
>>
>> I'm leaning towards applying latest Albert's ATA_QCFLAG_ACTIVE fix, 
>> which does the same thing your patch did.
>>
>> For various complex tasks in the SCSI translation layer (SAT), we may 
>> wish to issue multiple ATA commands, before signalling completion.  As 
>> your mod15write patch is an example of this, it helps point out what 
>> parts of libata need work in order to accomplish this.
>>
>> Any comments before I apply Albert's patch?
>>
> 
>  I think the following patch I've posted deal with the same problem.
> 
> http://marc.theaimsgroup.com/?l=linux-ide&m=112454734102242&w=2


In the SCSI translation layer (SAT), some simulation may require issuing 
multiple ATA commands, before indicating a completion to the upper 
layers.  That capability is something I definitely want libata to 
support.  Your mod15write patch is an excellent example of this, even 
though I NAK'd it due to long term sata_sil maintenance burden.

That's why I think move ATA_QCFLAG_ACTIVE -anyway- may be a good idea.

	Jeff


