From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Wed, 22 Mar 2006 08:54:39 +1100
Message-ID: <1142978079.12137.40.camel@localhost.localdomain>
References: <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca>
	 <20060321184215.GJ4285@suse.de> <442051A0.1050200@rtr.ca>
	 <4420541E.3070303@pobox.com> <44205484.9000702@rtr.ca>
	 <44205525.20306@rtr.ca> <20060321193538.GO4285@suse.de>
	 <44205642.7070302@pobox.com>
	 <1142970206.3428.12.camel@mulgrave.il.steeleye.com>
	 <20060321194649.GR4285@suse.de>
	 <1142973844.3428.22.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:26778 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751790AbWCUVy7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 16:54:59 -0500
In-Reply-To: <1142973844.3428.22.camel@mulgrave.il.steeleye.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, 2006-03-21 at 14:44 -0600, James Bottomley wrote:
> On Tue, 2006-03-21 at 20:46 +0100, Jens Axboe wrote:
> > Do <insert random device here> really never have segment or boundary
> > restrictions outside of IDE? Seems to me that supporting that would be
> > the conservative and sane thing to do.
> 
> Well the only machines that actually turn on virtual merging are sparc
> and parisc.  They have a small list of "certified" devices for them,
> none of which seems to have aribtrary segment boundary restrictions
> (although most of them have the standard 4GB one).
> 
> When I brought this up the last time it degenerated into a slanging
> match over the value of virtual merging (which no-one can seem to
> provide a definitive answer to).

Well, on ppc, what I do is I advertise no virtual merging to the block
layer but I do merge as much as I can still in the iommu code. That's
what I call "best try" merging. Though that also means that to be
totally correct with devices having boundary restrictions, I would have
to know that at the iommu level which I don't (and which is, I think, we
we hacked something at the ata level back then to work around it).

The problem with my approach is that since the driver can't know in
advance wether the iommu will be able to merge or not, it can't request
larger requests from the block layer unless it has the ability to do
partial completion and partial failure, that sort of thing... at least
that's what I remember from that 2 yrs old discussion we had :)

There is interest in virtual merging tho. My measurements back then on
the dual G5 were that it did compensate for the cost of the iommu on the
bus and actually did a bit better (I _think_ the workload was kernbench
but I can't remember for sure). Newer G5s have a better iommu thus
virtual merging may be even more of a benefit. By having the ability to
maybe get larger requests from the block layer would be good too. The
problem is that if I turn virtual merging on, with the current
implementation, then I _have_ to merge. The iommu isn't allowed to not
be able to merge because the block layer will have provided something
that maxes out the device sglist capabilities assuming complete merge...

In fact, the best would be to move the merge logic so that it's enslaved
to the driver & iommu code, but that would require a different interface
I suppose... Something like 

 1 - driver "opens" an sglist with the iommu
 2 - driver request a segment from the block layer, sends it down the
the iommu
 3 - iommu can merge -> go back to 2 until no more coming from the block
layer
 4 - iommu can't merge -> if driver can cope with more sglist entries,
add one and go to 2
 5 - driver limit reached, "close" the sglist (proceed to actual hw
mapping at this point maybe) and submit request to the hardware

I agree though that the loop between 2 and 3 can have interesting
"issues" if N drivers are hitting the iommu layer at the same time
unless we invent creative ways of either locking or scattering
allocation starting points at stage 1

Ben.

 

