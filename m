From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Correct use of  ap->lock  versus  ap->host->lock ?
Date: Thu, 06 Mar 2008 12:57:20 -0500
Message-ID: <47D03080.8070405@pobox.com>
References: <47D01232.1000106@rtr.ca> <47D01D4B.8000506@pobox.com> <47D02642.8040907@rtr.ca> <47D029BF.8040000@pobox.com> <47D02BB2.9000609@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45718 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbYCFR5Y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Mar 2008 12:57:24 -0500
In-Reply-To: <47D02BB2.9000609@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> There are definitely other fish to fry elsewhere,
> but don't discount the effect of "a couple register writes",
> which are frequently done with readbacks to flush them,
> at a cost equivalent to several thousand CPU cycles per readback.

Those numbers are for slower PIO, not MMIO as found on new SATA 
controllers...


> This prevents new command issue from overlapping interrupt handling
> for any ports of the same host.  Again, not a biggie today,
> but tomorrow perhaps..
> 
> And still probably not worth the fuss on any hardware that has
> registers shared across multiple ports (eg. Marvell controllers).


Remember, I come from the land of networking, where we already see over 
500k packets per second.  None of this is new stuff.

In networking you lock both TX submission (analogy: scsi queuecommand) 
and TX completion (analogy: completion via irq handler), and we don't 
see any such problems on multi-port controllers.

It is not worth the fuss on new SATA controllers, which look just like 
NIC hardware has looked for a decade -- DMA rings, with a single MMIO 
write (or write+read) to indicate software has new packets for hardware. 
  Even at exponentially higher FIS rates, locking doesn't become an issue.

And its not worth the fuss for older controllers, because they're, well, 
old and SMP locking performance is not a pressing issue there.  :)


Off the top of my head, here are two issues much more pressing than 
host-versus-port libata locking:


* batch submission.  The block and scsi layers pass commands to us 
one-at-a-time, which is awful for any modern hardware.  For each command 
in the request queue:  lock+queuecommand+unlock.  It is better for both 
locking and hardware (DMA ring) submission to add a batch of commands to 
the queue, and then kick the hardware.


* figuring out an interrupt mitigation scheme that is useful in the real 
world.  Right now, even a 16-port SATA card will not give you a lot of 
interrupts.  At some point, it does become useful to turn on interrupt 
mitigation.

That point is dynamic, and must be measured as such:  it depends on 
overall system load (not just load on a single SATA chip).  Networking's 
NAPI takes this into account, though over time we've seen the best 
results by combining hardware interrupt mitigation with software 
interrupt mitigation.


Regards,

	Jeff



