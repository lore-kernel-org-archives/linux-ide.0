From: Mark Lord <liml@rtr.ca>
Subject: Re: Port Multiplier drives not always all found on cold plug
Date: Fri, 16 May 2008 13:27:59 -0400
Message-ID: <482DC41F.9080901@rtr.ca>
References: <482DB79F.2030204@rtr.ca> <482DBA62.4020209@rtr.ca> <482DBC5C.3020904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4780 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbYEPR2A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 May 2008 13:28:00 -0400
In-Reply-To: <482DBC5C.3020904@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Mark Lord wrote:
>> Mark Lord wrote:
>>> Tejun,
>>>
>>> Since enabling PMP support in sata_mv, there have been some recent
>>> reports of not all drives being found on a PM.
> ..
>> Mmmm.. one strange thing from the logs.
>> sata_mv reports "unexpected device interrupt" in a few places,
>> and then triggers EH to recover from it.
>> This could be what is causing the PMP enumerations to partially fail.
>>
>> I wonder why we're getting interrupts when supposedly idle/polling ?
>> Did something in libata miss reading ata_status to clear an IRQ ?
> ..
> 
> Here, I've hacked my local copy of sata_mv to NOT trigger EH
> when it gets an unexpected device interrupt.  This is how the driver
> has been for years, until recently.
> 
> With this change, all drives on the PM are found (no surprise).
> 
> So I guess the questions are:
> 
> 1. Where are these unexpected interrupts coming from?
> 
> The implication is that a command is being issued without NIEN=1,
> *or* the ata_status is not being read (to clear the pending IRQ)
> before we clear NIEN for a subsequent command.
..

Mmm.. libata looks totally clean there, verified with some printk's
placed in strategic locations.

Perhaps all commands to the PM itself (pmp=15) result in interrupts
on receipt of the response?  The PM spec certainly implies this,
and doesn't mention NIEN at all.

I suppose that could be the source of them -- tracing in the driver
suggests that they all happen during/after issue of a PMP read command.

> 2. What to do about them in the driver?
..

I think by default, I'll just revert to having the driver ignore them,
the same as is done in the default methods in libata-core.c.

So far they do seem harmless in my testing here.

??
