From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/8] sata_mv more cosmetics
Date: Fri, 25 Apr 2008 09:46:31 -0400
Message-ID: <4811E0B7.2060508@rtr.ca>
References: <480A3D2E.4040503@rtr.ca> <480A3D5E.8090206@rtr.ca> <481168E7.50402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2677 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756104AbYDYNqi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Apr 2008 09:46:38 -0400
In-Reply-To: <481168E7.50402@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
..
>> -    irq_stat = readl(hpriv->main_cause_reg_addr);
>> -    irq_mask = readl(hpriv->main_mask_reg_addr);
..
>> +    main_cause = readl(hpriv->main_cause_reg_addr);
>> +    main_mask  = readl(hpriv->main_mask_reg_addr);
..
>  ...but I am sad to see this.  irq_stat and irq_mask naming make the 
> driver more accessible to outsiders, because the purpose of the 
> registers is immediately apparent even without having the docs at hand 
> -- which is the case for everybody in the world except me and you :)
> 
> I applied the patch anyway because you are defacto maintainer of sata_mv.
> 
> However, I _request_ a reconsideration of some of these renames when 
> viewed in that light.  It's your prerogative as maintainer to ignore or 
> honor that request as you see fit...  We all have to balance making our 
> own job easier with making the driver accessible to outsiders, 
> particularly those without NDA'd docs.
..

Thanks, Jeff.
I agree, too, in principle if not in deed at the moment.

But there are just *so many* irq cause / mask registers in these chips,
(one for PCI, one for the host function, and one per-port for EDMA,
plus the SATA SError + mask, ..), that even I was getting confused
while working on the code.

So, for now, they've been renamed back to something closer to
what is used in the (NDA only) documentation.

I did consider main_irq_{cause,mask} as an even better set of names there,
but in the end went for the shortened versions to avoid hitting the
pedantic 80-character line "limits" too often.

Perhaps after we finish the major hacking around the interrupt/EH code
(yes, more to come..) we can try and fix up those names again.

I'll put it on the next TODO list update.

Cheers
