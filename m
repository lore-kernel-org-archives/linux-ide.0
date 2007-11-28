From: Mark Lord <liml@rtr.ca>
Subject: Re: Flexible SFF interrupt handling
Date: Wed, 28 Nov 2007 12:00:57 -0500
Message-ID: <474D9EC9.6030100@rtr.ca>
References: <474D70E0.4060709@garzik.org> <474D7C21.9000303@rtr.ca> <474D900B.8030408@garzik.org> <474D9BC8.1080104@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3625 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756704AbXK1RA7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Nov 2007 12:00:59 -0500
In-Reply-To: <474D9BC8.1080104@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Mark Lord wrote:
>>> Jeff Garzik wrote:
...
>>> The only question is, under which conditions do we return IRQ 
>>> "handled=1",
>>> and which times should we return 0 ?
>>>
>>> Definitely when a real IRQ wakes us up and we see (qc != NULL && 
>>> drive_ready),
>>> essentially exactly as we currently do it.
>>>
>>> But things might be trickier once polling is introduced, unless we 
>>> also mask
>>> the device interrupt before initiating the polling.
>>
>> Actually no, and that is a key benefit of this scheme:  if we ensure 
>> that the polling paths are resilient even in case where interrupts are 
>> being delivered -- as we must do anyway -- then we don't have to worry 
>> about interrupt masking, either on the interrupt controller or on the 
>> device[1].
>>
>> If we do get an interrupt, ack it ASAP.  That covers normal operation 
>> and screaming interrupts.
> ..
> 
> I was considering a shared IRQ environment, where the screamer
> might be a different device on the same IRQ..
...

To clarify:  If we are sharing an IRQ line with other device(s),
then it is not good to always return "handled=1" from our IRQ handler
in cases where the interrupt could not be confirmed to be ours.

Because if we did, then the babbling-IRQ detection ("too many spurious")
elsewhere in the kernel will be unable to function for this particular IRQ line.

If we really have no other good option, then fine --> sata_qstor does this.
And I suppose that's the intent --> only fall back to this kind of stuff
when we are dealing with hardware that is known to be unreliable w.r.t. IRQs.

Cheers
