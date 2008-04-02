From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 2/5] sata_mv clean up mv_stop_edma usage
Date: Wed, 02 Apr 2008 15:33:01 -0400
Message-ID: <47F3DF6D.8050803@rtr.ca>
References: <47F1736F.8020104@rtr.ca> <47F17510.7060902@rtr.ca> <47F2E88E.4000401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3143 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757701AbYDBTdE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Apr 2008 15:33:04 -0400
In-Reply-To: <47F2E88E.4000401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Tejun Heo wrote:
> Hello, Mark.
> 
> Mark Lord wrote:
>> -    /* now properly wait for the eDMA to stop */
>> -    for (i = 1000; i > 0; i--) {
>> -        reg = readl(port_mmio + EDMA_CMD_OFS);
>> +    /* Wait for the chip to confirm eDMA is off. */
>> +    for (i = 10000; i > 0; i--) {
>> +        u32 reg = readl(port_mmio + EDMA_CMD_OFS);
>>         if (!(reg & EDMA_EN))
>> -            break;
>> -
>> -        udelay(100);
>> -    }
>> -
>> -    if (reg & EDMA_EN) {
>> -        ata_port_printk(ap, KERN_ERR, "Unable to stop eDMA\n");
>> -        err = -EIO;
>> +            return 0;
>> +        udelay(10);
> 
> Unless the hardware calls for really short polling interval, I think 
> it's generally better to limit polling with jiffies and using msleep() 
> instead of delays.
..

Oh, absolutely.  I was just leaving Jeff's (?) original udelay() in there
for now, to avoid another possible failure while testing the new stuff.

But if we can *guarantee* that .qc_issue and .port_stop are
always invoked only from thread context, then.. no problemo.

> Also, mv_stop_edma() skips actual operation if EDMA_EN isn't set, which 
> I think is the correct way to do it in hot paths but I think it's better 
> to stop the edma engine unconditionally prior to reset as that's where 
> we try to bring the controller back into senses.
..

Harmless change.  FITNR.

Thanks
