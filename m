From: Jeff Garzik <jeff@garzik.org>
Subject: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Tue, 25 Sep 2007 22:09:02 -0400
Message-ID: <46F9BF3E.5050708@garzik.org>
References: <1190521193410-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43269 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567AbXIZCJG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 22:09:06 -0400
In-Reply-To: <1190521193410-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Here's one thing that jumps out at me, reviewing the PMP patchset:

PMP reads and writes require polling, which is not something we should 
impose upon the design.  Conversations with a port multiplier are 
fundamentally packetized, and modern controllers treat these just like 
the bazillion other types of packets they must deal with:   just another 
entry on a DMA ring, with an interrupt to signal completion/reception.

For situations like this, libata EH needs to the use normal, natural 
delivery method: initiate an action, and wait asynchronously for completion.

Certainly the flow of control might be synchronous inside libata EH; 
that requirement is normal and usable with an issue+wait setup.

More and more I am convinced this "mission creep", the slow expansion of 
polling even into modern controllers, is going in the wrong direction.

Consider the mvsas driver (Marvell 6440 SAS/SATA), whose rough draft I 
posted yesterday:  in order to support SAS wide ports -- multiple phys 
aggregated at runtime into a single "SAS port" -- and remote SATA device 
attachment behind expanders then PMPs, their hardware design became
	- single command queue, for all ports/phys
	- single response queue, for all ports/phys
	- events from all ports, SAS and SATA, aggregate
	  onto those queues
	- a single MSI interrupt signals "go look for new work on
	  DMA ring"

There, even the concept of "port" is fluid, and the libata EH model of 
freezing and thawing a port (with the desired irq-off result) just 
doesn't fit the hardware.

The model under SAS+SATA is even closer to that of a network driver: 
you just have a very dumb driver, that sends and receives frames, as 
signalled via interrupt.

As such, polling is simply an outmoded concept.  It does not make sense 
on new hardware, and forcing design decisions down that path only lead 
to a cascade of similar design decisions -- pmp_read polling being just 
one example of such a result.

Just like the Linux kernel MM platform API presents 3 levels of page 
table entries, even when the hardware may only have 2, libata high level 
API _must_ be implemented as 100% asynchronous event driven API.

If the default implementation chooses to use polling -- i.e. all SFF 
controllers -- that's fine.  But in the new SAS/SATA world its clear 
that we have far too many polling-related assumptions as it is.

Polling just flat out doesn't make sense on modern SAS/SATA -- and even 
a couple modern SATA controllers.  On such controllers, we are notified 
immediately via interrupt even in the event of errors.

	Jeff




