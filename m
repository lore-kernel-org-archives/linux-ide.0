From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Flexible SFF interrupt handling
Date: Wed, 28 Nov 2007 10:58:03 -0500
Message-ID: <474D900B.8030408@garzik.org>
References: <474D70E0.4060709@garzik.org> <474D7C21.9000303@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40224 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757196AbXK1P6G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Nov 2007 10:58:06 -0500
In-Reply-To: <474D7C21.9000303@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>> This has been bubbling on my brain for a while.  I blathered on about 
>> this on IRC to Tejun, but figured I might as well post it here and get 
>> it archived.
>>
>> In general, I think we should adopt a flexible or "loose" model for 
>> acking interrupts on SFF controllers.
>>
>> (a) whenever we are in bus-idle (qc == NULL), and get an interrupt, go 
>> ahead and read Status.
>>
>> (b) if we are expecting an interrupt, and receive one, check Status 
>> (or AltStatus if DMAing).
>>
>> (c) if condition "(b)" indicates busy, initiate status polling every 
>> 250ms until timeout occurs or BSY clears.
>>
>> (d) if N seconds (4?) elapses without an interrupt, initiate polling. 
>> keep a history of such "fail-over" events, and note each fail-over'd 
>> command's eventual success via polling, success via interrupt, or 
>> timeout.  Use that history to decide to switch to 100% polling mode 
>> (i.e. reach conclusion that interrupt delivery is broken, via 
>> observation)
>>
>> That should cover no-interrupts, lost interrupts, early interrupts, 
>> screaming interrupts, insane devices, and of course normal operation.
>>
>> The model could be summarized as "interrupt as a hint" operation.
> ..
> 
> The only question is, under which conditions do we return IRQ "handled=1",
> and which times should we return 0 ?
> 
> Definitely when a real IRQ wakes us up and we see (qc != NULL && 
> drive_ready),
> essentially exactly as we currently do it.
> 
> But things might be trickier once polling is introduced, unless we also 
> mask
> the device interrupt before initiating the polling.

Actually no, and that is a key benefit of this scheme:  if we ensure 
that the polling paths are resilient even in case where interrupts are 
being delivered -- as we must do anyway -- then we don't have to worry 
about interrupt masking, either on the interrupt controller or on the 
device[1].

If we do get an interrupt, ack it ASAP.  That covers normal operation 
and screaming interrupts.
If we don't get an interrupt, we will notice after a spell and poll 
Status to ensure progress occurs.

Note that this polling is a different sort of polling than running an 
entire ATA command via a kernel thread.  In this case, we're talking 
about periodic Status (or AltStatus or LLD-specific-register status) 
polling only.

A lot of fiddling with irq masking is getting around ugliness that I am 
instead trying to eliminate altogether.  A truly robust system follows 
the spec WRT nIEN and other interrupt masking.....  but then prepares 
for the case where hw decides to send an interrupt anyway.

On SFF controllers, we should consider interrupts to be unreliable 
messages delivered on a best effort basis by hardware.  If we get them, 
great, ack and act.  If we lack them, make sure progress occurs.

Regards,

	Jeff


[1] well, there -are- exceptions, such as when we are bitbanging the ATA 
Data register
