From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/8] sata_mv more cosmetics
Date: Fri, 25 Apr 2008 13:35:44 -0400
Message-ID: <48121670.7020000@rtr.ca>
References: <480A3D2E.4040503@rtr.ca> <480A3D5E.8090206@rtr.ca>	 <481168E7.50402@pobox.com> <4811E0B7.2060508@rtr.ca> <da824cf30804250940o4f0e0396k1696348f8d86cb77@mail.gmail.com> <48120D82.7060009@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3503 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754875AbYDYRfp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 13:35:45 -0400
In-Reply-To: <48120D82.7060009@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Grant Grundler <grundler@google.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Grant Grundler wrote:
>> I think you can associate any names you want with whatever the
>> non-public documentation is calling the registers by adding a comment
>> in the header files where the bit masks and register offsets are defined.
>> Or vice versa. Which ever way works for you.
>>
>> I prefer to use the non-public register names in the code only because it
>> will be easier for Marvell engineers to participate in _maintaining_
>> this driver. I think getting involved with open source developement
>> is a good career developement experience. And the device drivers for
>> "obsolete" HW allows them to take more risks/make mistakes
>> without getting into serious trouble with the company.
> 
> 
> The trouble, though, comes with following that logic in every driver, 
> making the collective body less accessible to anyone not _intimately_ 
> tied into the hardware _and_ possessing NDA'd docs.
> 
> Further, it is obvious with _most_ drivers in Linux that engineers at 
> the hardware vendor do _not_ participate in maintaining drivers for 
> their older hardware, so I also wish to be careful and avoid punishing 
> the majority to help a minority.
> 
> I put a significant value in having more-readable code like
> 
>     status = mr32(IRQ_STAT);    /* read IRQ status from PPB */
> 
> rather than
> 
>     status = READ_REG(ICR5PPB);    /* read IRQ status from PPB */
> 
> because the casual reader is more likely to understand the first 
> example, even though it deviates from the string of line noise some 
> engineer writing Verilog at 4:00am decided was a good register name.
..

There's a patch out for this now -- just waiting for you to pick it up.
It uses "main_irq_cause/mask" now instead of merely "main_cause/mask".

This ought to be understandable at a glance to anyone,
even those of us with chipset docs.  :)

Cheers
