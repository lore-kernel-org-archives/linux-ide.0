From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/5] sata_mv clean up mv_stop_edma usage
Date: Thu, 03 Apr 2008 09:47:27 +0900
Message-ID: <47F4291F.6030601@gmail.com>
References: <47F1736F.8020104@rtr.ca> <47F17510.7060902@rtr.ca> <47F2E88E.4000401@gmail.com> <47F3DF6D.8050803@rtr.ca> <47F3E1B4.90609@pobox.com> <47F3E2D3.5020409@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.177]:30256 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760831AbYDCAre (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2008 20:47:34 -0400
Received: by el-out-1112.google.com with SMTP id v27so1498572ele.17
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2008 17:47:33 -0700 (PDT)
In-Reply-To: <47F3E2D3.5020409@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Mark Lord wrote:
>>> Tejun Heo wrote:
>>>> Hello, Mark.
>>>>
>>>> Mark Lord wrote:
>>>>> -    /* now properly wait for the eDMA to stop */
>>>>> -    for (i = 1000; i > 0; i--) {
>>>>> -        reg = readl(port_mmio + EDMA_CMD_OFS);
>>>>> +    /* Wait for the chip to confirm eDMA is off. */
>>>>> +    for (i = 10000; i > 0; i--) {
>>>>> +        u32 reg = readl(port_mmio + EDMA_CMD_OFS);
>>>>>         if (!(reg & EDMA_EN))
>>>>> -            break;
>>>>> -
>>>>> -        udelay(100);
>>>>> -    }
>>>>> -
>>>>> -    if (reg & EDMA_EN) {
>>>>> -        ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
>>>>> -        err = -EIO;
>>>>> +            return 0;
>>>>> +        udelay(10);
>>>>
>>>> Unless the hardware calls for really short polling interval, I think 
>>>> it's generally better to limit polling with jiffies and using 
>>>> msleep() instead of delays.
>>> ..
>>>
>>> Oh, absolutely.  I was just leaving Jeff's (?) original udelay() in 
>>> there
>>> for now, to avoid another possible failure while testing the new stuff.
>>>
>>> But if we can *guarantee* that .qc_issue and .port_stop are
>>> always invoked only from thread context, then.. no problemo.
>>
>> qc_issue is inside spin_lock_irqsave()
> ..
> 
> Okay, let's leave it alone for now.
> Perhaps later it can be reworked again to find
> a way to busy wait without messing up other stuff.
> 
> Nearly all of the time it exits rapidly anyway.

Aikk... right, it's called from the issue path too.  In that case, 
udelay() is the only way to go.

Thanks.

-- 
tejun
