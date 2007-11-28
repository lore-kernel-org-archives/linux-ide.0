From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Flexible SFF interrupt handling
Date: Wed, 28 Nov 2007 14:29:47 +0000
Message-ID: <20071128142947.17221a33@the-village.bc.nu>
References: <474D70E0.4060709@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:39757 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755870AbXK1OdI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Nov 2007 09:33:08 -0500
In-Reply-To: <474D70E0.4060709@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

> In general, I think we should adopt a flexible or "loose" model for 
> acking interrupts on SFF controllers.

Agreed - especially as the IRQ is often essentially the drive output not
under any kind of sane control of ours.

> (a) whenever we are in bus-idle (qc == NULL), and get an interrupt, go 
> ahead and read Status.

Please call into the driver. Quite a few PATA drivers have multiple IRQ
sources, and SATA many. 

> (b) if we are expecting an interrupt, and receive one, check Status (or 
> AltStatus if DMAing).

Providing we are not mid data transfer (which is why we need to get into
enable/disable_irq for some controllers). Right now its a problem that
can't occur but on some controllers reading status mid PIO xfer causes
joyous things like silent corruption.

> (c) if condition "(b)" indicates busy, initiate status polling every 
> 250ms until timeout occurs or BSY clears.

Yep.

> (d) if N seconds (4?) elapses without an interrupt, initiate polling. 
> keep a history of such "fail-over" events, and note each fail-over'd 
> command's eventual success via polling, success via interrupt, or 
> timeout.  Use that history to decide to switch to 100% polling mode 
> (i.e. reach conclusion that interrupt delivery is broken, via observation)

N = 8 sounds good to me (7 being the normal maximum command timeout)

> That should cover no-interrupts, lost interrupts, early interrupts, 
> screaming interrupts, insane devices, and of course normal operation.

Should we also consider resetting the device as one of the strategies (at
least once off)

Might also want to think at that point about the case of 

	command
	....
	timeout

where old IDE checks with the controller to spot lost IRQ cases where a
command finished and stuff vanished. Old IDE doesn't do much with it but
we could use that as a good hint that we want to switch to polling mode
and tell the user their computer sucks.

Alan


