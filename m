From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Bugme-new] [Bug 14518] New: I/O appears to get stuck on
 certain rsync backup job and system clock halts then
Date: Sat, 31 Oct 2009 14:35:58 +0000
Message-ID: <20091031143558.1f86e049@lxorguk.ukuu.org.uk>
References: <bug-14518-10286@http.bugzilla.kernel.org/>
	<20091031001711.0d3a8238.akpm@linux-foundation.org>
	<20091031114804.75ca5835@lxorguk.ukuu.org.uk>
	<200910311322.10242.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47831 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757798AbZJaOeY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Oct 2009 10:34:24 -0400
In-Reply-To: <200910311322.10242.Martin@lichtvoll.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>

> > #2 the Cardbus Sil3512 controller somehow got stuck asserting an
> > interrupt that wasn't cleared.
> 
> What could be the reason for that one? Could it be that the PCMCIA card 
> had to many plug / unplug cycles. Contacts look fine tough.

I have no idea.
> 
> > Needs the Sil3512 person to look at it. Even with flaky cabling it
> >  should have either recovered cleanly or dropped the device.
> 
> Yes, thats my main concern. Why did it stuck the machine for so long?

It needs someone with 3512 hardware/knowledge to work on it. 

> Ok, if I can help with some test I try my best to take to time for it. I 
> will wait for further instructions / questions.

Dump the IRQ counter (cat /proc/interrupts) somewhere before each rsync
and if it locks up again then when you remove the card take a second
copy. If its a stuck IRQ then the one IRQ will show up stupendously large
numbers.
