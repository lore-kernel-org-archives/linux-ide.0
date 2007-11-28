From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Flexible SFF interrupt handling
Date: Wed, 28 Nov 2007 11:09:38 -0500
Message-ID: <474D92C2.1080804@garzik.org>
References: <474D70E0.4060709@garzik.org> <20071128142947.17221a33@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44044 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069AbXK1QJk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Nov 2007 11:09:40 -0500
In-Reply-To: <20071128142947.17221a33@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> In general, I think we should adopt a flexible or "loose" model for 
>> acking interrupts on SFF controllers.
> 
> Agreed - especially as the IRQ is often essentially the drive output not
> under any kind of sane control of ours.

Good point (I had not thought of looking at it that way).


>> (a) whenever we are in bus-idle (qc == NULL), and get an interrupt, go 
>> ahead and read Status.
> 
> Please call into the driver. Quite a few PATA drivers have multiple IRQ
> sources, and SATA many. 

Done :)  This should simply be a new behavior coded into the existing 
interrupt handlers.

Thus you can choose per-driver whether to do this or not.


>> (b) if we are expecting an interrupt, and receive one, check Status (or 
>> AltStatus if DMAing).
> 
> Providing we are not mid data transfer (which is why we need to get into
> enable/disable_irq for some controllers). Right now its a problem that
> can't occur but on some controllers reading status mid PIO xfer causes
> joyous things like silent corruption.

True..


>> (c) if condition "(b)" indicates busy, initiate status polling every 
>> 250ms until timeout occurs or BSY clears.
> 
> Yep.
> 
>> (d) if N seconds (4?) elapses without an interrupt, initiate polling. 
>> keep a history of such "fail-over" events, and note each fail-over'd 
>> command's eventual success via polling, success via interrupt, or 
>> timeout.  Use that history to decide to switch to 100% polling mode 
>> (i.e. reach conclusion that interrupt delivery is broken, via observation)
> 
> N = 8 sounds good to me (7 being the normal maximum command timeout)
> 
>> That should cover no-interrupts, lost interrupts, early interrupts, 
>> screaming interrupts, insane devices, and of course normal operation.
> 
> Should we also consider resetting the device as one of the strategies (at
> least once off)
> 
> Might also want to think at that point about the case of 
> 
> 	command
> 	....
> 	timeout
> 
> where old IDE checks with the controller to spot lost IRQ cases where a
> command finished and stuff vanished. Old IDE doesn't do much with it but
> we could use that as a good hint that we want to switch to polling mode
> and tell the user their computer sucks.

That's basically where I wanted to go with "(d)".  Being able to both 
handle interrupts _and_ fall back to polling makes it easy to notice 
when interrupts are getting lost.  If more than a couple rescues of this 
nature occur, do as you describe.

	Jeff


