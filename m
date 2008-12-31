From: Mark Lord <liml@rtr.ca>
Subject: Re: PIO with SSDs: needs a long DRQ-after-command timeout for WRITEs
Date: Wed, 31 Dec 2008 15:30:17 -0500
Message-ID: <495BD659.6000604@rtr.ca>
References: <495A27E3.50801@rtr.ca> <20081230135902.560267dc@lxorguk.ukuu.org.uk> <495B9DDD.2020109@rtr.ca> <200812311938.08916.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:58637 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846AbYLaU2s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Dec 2008 15:28:48 -0500
In-Reply-To: <200812311938.08916.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 31 December 2008, Mark Lord wrote:
>> Alan Cox wrote:
>>>> So.. how long does libata and current IDE allow for initial DRQ assertion?
>>>> It should probably be at least 500msec or more now.
>>> I think we need to rewrite the PIO code paths to use disable/enable_irq
>>> masking first before getting into adding long delays on PIO paths.
>> ..
>>
>> Yeah, that would be a good thing to do.
> 
> Unless shared IRQs come into the picture -- in such case disabling IRQ
> for 0.5sec doesn't sound too sexy...
> 
>> But in the meanwhile, a longer timeout there doesn't affect
>> any currently working systems -- they'll still wait only as long
>> as they currently do.  And a longer timeout *will* enable these
>> SSDs to work where they otherwise would not.
>>
>> But perhaps the timeout is already long enough?
>> I don't know where the current timeout is hiding in libata.  :)
> 
> When it comes to IDE the timeout is defined by WAIT_DRQ in <linux/ide.h>
> and is currently set to 100ms.  There should be no problem with increasing
> it if it would help to get some devices to work (please just send a patch).
..

That's probably enough.  50msec wasn't, so we just bumped to a few seconds
in the custom kernel and sent them on their way happy.

But if it pops up again here (timeout waiting for initial DRQ),
then we all know what to do about it, I suppose.
Most people will never notice a problem, because most systems
aren't stuck in the PIO-only dark ages now.  :)

Cheers
