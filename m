From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_mv Improve naming of main_irq cause/mask identifiers
Date: Tue, 29 Apr 2008 02:18:36 -0400
Message-ID: <4816BDBC.3000804@pobox.com>
References: <4811F7A8.6080004@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51622 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754729AbYD2GSw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 02:18:52 -0400
In-Reply-To: <4811F7A8.6080004@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
> ..
>> applied patches 1-8...
> ..
>>> -    irq_stat = readl(hpriv->main_cause_reg_addr);
>>> -    irq_mask = readl(hpriv->main_mask_reg_addr);
> ..
>>> +    main_cause = readl(hpriv->main_cause_reg_addr);
>>> +    main_mask  = readl(hpriv->main_mask_reg_addr);
> ..
>>  ...but I am sad to see this.  irq_stat and irq_mask naming make the 
>> driver more accessible to outsiders, because the purpose of the 
>> registers is immediately apparent even without having the docs at hand 
>> -- which is the case for everybody in the world except me and you :)
>>
>> I applied the patch anyway because you are defacto maintainer of sata_mv.
>>
>> However, I _request_ a reconsideration of some of these renames when 
>> viewed in that light.  It's your prerogative as maintainer to ignore 
>> or honor that request as you see fit...  We all have to balance making 
>> our own job easier with making the driver accessible to outsiders, 
>> particularly those without NDA'd docs.
> ..
> 
> Here ya go:
> 
> -------------------- SNIP ----------------------------------
> 
> Tidy up naming of things associated with the PCI / SOC chip
> "main irq cause/mask" registers, as inspired by Jeff.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

applied


