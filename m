From: Mark Lord <liml@rtr.ca>
Subject: Re: Correct use of  ap->lock  versus  ap->host->lock ?
Date: Thu, 06 Mar 2008 12:36:50 -0500
Message-ID: <47D02BB2.9000609@rtr.ca>
References: <47D01232.1000106@rtr.ca> <47D01D4B.8000506@pobox.com> <47D02642.8040907@rtr.ca> <47D029BF.8040000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4829 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbYCFRgw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Mar 2008 12:36:52 -0500
In-Reply-To: <47D029BF.8040000@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Jeff Garzik wrote:
>>> Mark Lord wrote:
>>>> Jeff / Tejun / Alan,
>>>>
>>>> I'm trying to sort out the spinlocks in sata_mv.
>>>>
>>>> In some places, the existing code uses ap->lock.
>>>> But in others, notably the interrupt handling, it uses ap->host->lock.
>>>>
>>>> This looks buggy to me, and I'm wondering how to make it bulletproof.
>>>
>>> Look closely, there is only one lock.  ata_port does not have a 
>>> spinlock, just a pointer...
>> ..
>>
>> Ahh.. in ata_port_alloc().  Thanks.
>>
>> Mmmm... so this reduces potential parallelism in libata,
>> meaning we could probably achieve better SMP performance
>> if the ap->locks were unique for each port.
>>
>> But at the expense of very tricky and difficult coding
>> around shared host resources.
>>
>> Not worth it today for spinning media, but this could be
>> a big limitation for solid-state media in the near future.
> 
> Its questionable whether it is worth it even for RAM-based ATA devices 
> like gigabyte i-Ram.
> 
> The only thing being locked is software state involved in submission and 
> completion (either host-wide or port-wide) and a couple register writes, 
> which is a very tiny piece of the whole puzzle.
>
> You have a long, long list of bottlenecks before you ever get there...
..

There are definitely other fish to fry elsewhere,
but don't discount the effect of "a couple register writes",
which are frequently done with readbacks to flush them,
at a cost equivalent to several thousand CPU cycles per readback.

This prevents new command issue from overlapping interrupt handling
for any ports of the same host.  Again, not a biggie today,
but tomorrow perhaps..

And still probably not worth the fuss on any hardware that has
registers shared across multiple ports (eg. Marvell controllers).

Cheers
