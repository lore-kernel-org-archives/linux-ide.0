From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement spurious irq handling
 for SFF and apply it to piix
Date: Fri, 15 Jan 2010 12:39:35 +0900
Message-ID: <4B4FE377.5090302@kernel.org>
References: <4B4ECCCD.1040902@kernel.org> <4B4ECD81.8020205@kernel.org> <4B4F113B.30400@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46751 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753077Ab0AODeF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Jan 2010 22:34:05 -0500
In-Reply-To: <4B4F113B.30400@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>

Hello,

On 01/14/2010 09:42 PM, Sergei Shtylyov wrote:
>> +static bool piix_irq_check(struct ata_port *ap)
>> +{
>> +    if (unlikely(!ap->ioaddr.bmdma_addr))
>> +        return false;
>> +
>> +    return ap->ops->bmdma_status(ap) & ATA_DMA_INTR;
>> +}
>> +
>>   
> 
>   I'm not at all sure that old, pre-ICH controllers set this bit also
> for the PIO mode commands, not only for DMA. And if you didn't make such
> assumption, I don't see why this can't be generic and placed into
> libata-sff.c instead...

Because different controllers have different mechanisms for detecting
pending IRQ?  Also, I think the current round is a bit dangerous in
that it might end up accessing registers while the driver is doing
polling PIO.  Having spurious IRQ clearing support would definitely be
helpful for such conditions but it might also lead to silent data
corruption which is worse.  I'll update the patch series so that the
mechanism only kicks in only when the controller is believed to be
completely idle.

Thanks.

-- 
tejun
