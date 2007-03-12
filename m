From: "Paul Rolland" <rol@as2917.net>
Subject: RE: [git patches] libata fixes
Date: Mon, 12 Mar 2007 08:56:27 +0100
Message-ID: <001701c7647b$f36b77d0$4b00a8c0@donald>
References: <Pine.LNX.4.64.0703111750010.9690@woody.linux-foundation.org>
Reply-To: <rol@as2917.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tag.witbe.net ([81.88.96.48]:52657 "EHLO tag.witbe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965287AbXCLH45 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Mar 2007 03:56:57 -0400
In-Reply-To: <Pine.LNX.4.64.0703111750010.9690@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
Cc: 'Tejun Heo' <htejun@gmail.com>, 'Jeff Garzik' <jeff@garzik.org>, 'Alan Cox' <alan@redhat.com>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Hello,

> Ok, so that's just a message irritation, not actually bothersome 
> otherwise?

It is somewhat painful, because delays involved are quite long, and
it is not possible to explain the machine to "ignore" the port, and
skip to the next one... 
 
> > The second problem is a Jmicron363 controler that is 
> failing to detect
> > the DVD-RW that is connected, unless I use the irqpoll 
> option as Tejun has
> > suggested.
> 
> .. and this one has never worked without irqpoll?

Exactly.
 
> So it's the irq16 one that is the Jmicron controller and just isn't 
> getting any interrupts?

It's IRQ 16 that is reported as affected to the Jmicron from the dmesg
output, yes.
 
> Since all the other interrupts work (and MSI worked for other 
> controllers), I don't think it's interrupt-routing related. 
> Especially as MSI shouldn't even care about things like that.
>
> And since it all works when "irqpoll" is used, that implies that the 
> *only* thing that is broken is literally irq delivery.

Surely, also if you add the using pci=nomsi doesn't change anything.
 
> Gaah. Can you get a log through serial console or netconsole 
> to see what changed?

I'll try to do that.... 

Regards,
Paul

