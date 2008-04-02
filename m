From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/5] sata_mv clean up mv_stop_edma usage
Date: Wed, 02 Apr 2008 15:47:31 -0400
Message-ID: <47F3E2D3.5020409@rtr.ca>
References: <47F1736F.8020104@rtr.ca> <47F17510.7060902@rtr.ca> <47F2E88E.4000401@gmail.com> <47F3DF6D.8050803@rtr.ca> <47F3E1B4.90609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1102 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757231AbYDBTrc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Apr 2008 15:47:32 -0400
In-Reply-To: <47F3E1B4.90609@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>> Hello, Mark.
>>>
>>> Mark Lord wrote:
>>>> -    /* now properly wait for the eDMA to stop */
>>>> -    for (i = 1000; i > 0; i--) {
>>>> -        reg = readl(port_mmio + EDMA_CMD_OFS);
>>>> +    /* Wait for the chip to confirm eDMA is off. */
>>>> +    for (i = 10000; i > 0; i--) {
>>>> +        u32 reg = readl(port_mmio + EDMA_CMD_OFS);
>>>>         if (!(reg & EDMA_EN))
>>>> -            break;
>>>> -
>>>> -        udelay(100);
>>>> -    }
>>>> -
>>>> -    if (reg & EDMA_EN) {
>>>> -        ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
>>>> -        err = -EIO;
>>>> +            return 0;
>>>> +        udelay(10);
>>>
>>> Unless the hardware calls for really short polling interval, I think 
>>> it's generally better to limit polling with jiffies and using 
>>> msleep() instead of delays.
>> ..
>>
>> Oh, absolutely.  I was just leaving Jeff's (?) original udelay() in there
>> for now, to avoid another possible failure while testing the new stuff.
>>
>> But if we can *guarantee* that .qc_issue and .port_stop are
>> always invoked only from thread context, then.. no problemo.
> 
> qc_issue is inside spin_lock_irqsave()
..

Okay, let's leave it alone for now.
Perhaps later it can be reworked again to find
a way to busy wait without messing up other stuff.

Nearly all of the time it exits rapidly anyway.

Cheers

