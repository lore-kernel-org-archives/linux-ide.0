From: Mark Lord <liml@rtr.ca>
Subject: Re: Flexible SFF interrupt handling
Date: Wed, 28 Nov 2007 09:33:05 -0500
Message-ID: <474D7C21.9000303@rtr.ca>
References: <474D70E0.4060709@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2558 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781AbXK1OdG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Nov 2007 09:33:06 -0500
In-Reply-To: <474D70E0.4060709@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> This has been bubbling on my brain for a while.  I blathered on about 
> this on IRC to Tejun, but figured I might as well post it here and get 
> it archived.
> 
> In general, I think we should adopt a flexible or "loose" model for 
> acking interrupts on SFF controllers.
> 
> (a) whenever we are in bus-idle (qc == NULL), and get an interrupt, go 
> ahead and read Status.
> 
> (b) if we are expecting an interrupt, and receive one, check Status (or 
> AltStatus if DMAing).
> 
> (c) if condition "(b)" indicates busy, initiate status polling every 
> 250ms until timeout occurs or BSY clears.
> 
> (d) if N seconds (4?) elapses without an interrupt, initiate polling. 
> keep a history of such "fail-over" events, and note each fail-over'd 
> command's eventual success via polling, success via interrupt, or 
> timeout.  Use that history to decide to switch to 100% polling mode 
> (i.e. reach conclusion that interrupt delivery is broken, via observation)
> 
> That should cover no-interrupts, lost interrupts, early interrupts, 
> screaming interrupts, insane devices, and of course normal operation.
> 
> The model could be summarized as "interrupt as a hint" operation.
..

The only question is, under which conditions do we return IRQ "handled=1",
and which times should we return 0 ?

Definitely when a real IRQ wakes us up and we see (qc != NULL && drive_ready),
essentially exactly as we currently do it.

But things might be trickier once polling is introduced, unless we also mask
the device interrupt before initiating the polling.

For example, we decide to begin polling according to rule (b) above,
and our poll routine happens to later find/service the IRQ before the
hardware IRQ handler runs.  Shortly after, the hardware IRQ handler does run,
but sees no active qc.  If it returns handled=1, it is lying.  If it returns
handled=0, we may eventually find our IRQ being disabled for "spurious" incidents.

Tricky, that.

-ml

