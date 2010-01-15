From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement spurious irq handling
 for SFF and apply it to piix
Date: Fri, 15 Jan 2010 13:23:29 +0300
Message-ID: <4B504221.6060107@ru.mvista.com>
References: <4B4ECCCD.1040902@kernel.org> <4B4ECD81.8020205@kernel.org> <4B4F113B.30400@ru.mvista.com> <4B4FE377.5090302@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:7759 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751231Ab0AOKX4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jan 2010 05:23:56 -0500
In-Reply-To: <4B4FE377.5090302@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>

Hello.

Tejun Heo wrote:

>>> +static bool piix_irq_check(struct ata_port *ap)
>>> +{
>>> +    if (unlikely(!ap->ioaddr.bmdma_addr))
>>> +        return false;
>>> +
>>> +    return ap->ops->bmdma_status(ap) & ATA_DMA_INTR;
>>> +}
>>> +
>>>   
>>>       
>>   I'm not at all sure that old, pre-ICH controllers set this bit also
>> for the PIO mode commands, not only for DMA. And if you didn't make such
>> assumption, I don't see why this can't be generic and placed into
>> libata-sff.c instead...
>>     
>
> Because different controllers have different mechanisms for detecting
> pending IRQ?

   All SFF-8038i (BMIDE) controllers have the same mechanism. They may 
have some additional interrupt bits though, reflecting the interrupt 
status in both PIO and DMA mode though.

WBR, Sergei


