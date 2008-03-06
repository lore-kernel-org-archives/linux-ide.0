From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Correct use of  ap->lock  versus  ap->host->lock ?
Date: Thu, 06 Mar 2008 12:41:20 -0500
Message-ID: <47D02CC0.6080609@pobox.com>
References: <47D01232.1000106@rtr.ca> <47D01D4B.8000506@pobox.com> <47D02642.8040907@rtr.ca> <47D028C5.9070509@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52132 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242AbYCFRl2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Mar 2008 12:41:28 -0500
In-Reply-To: <47D028C5.9070509@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
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
> ..
> 
> Okay.  Does the LLD even need to bother with this lock
> in the various pre/soft/hard reset routines ?
> 
> I don't think so, but sata_mv currently tries to lock there.

It depends on what needs to be locked, obviously...

(and no, that is not a sarcastic answer)

You need to perform your own LLD-specific locking analysis to see if it 
is safe to do, e.g. __mv_stop_dma() rather than mv_stop_dma().

All the msleep() calls in the reset routines should tell you that 
sleeping is OK, which means locking during EH is mostly accordingly to 
the needs of your driver.

EH makes sure various command submission machinery is shut down, thus 
creating the _possibility_ for lockless work, but your driver may need 
additional guarantees (and thus additional locking).

	Jeff



