From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Tue, 26 Feb 2008 16:30:05 +1100
Message-ID: <1204003805.15052.112.camel@pasglop>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com>
	 <1203987277.15052.68.camel@pasglop> <47C36D64.6010001@rtr.ca>
	 <47C36EC3.4080708@rtr.ca> <1203994454.15052.83.camel@pasglop>
	 <47C397C4.2090309@rtr.ca>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36514 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbYBZFbG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Feb 2008 00:31:06 -0500
In-Reply-To: <47C397C4.2090309@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>


On Mon, 2008-02-25 at 23:38 -0500, Mark Lord wrote:
> Benjamin Herrenschmidt wrote:
> >> James B.  suggests that we stick a WARN_ON() into libata to let us
> >> know if that precondition is violated.  Sounds like an easy thing to do
> >> for a couple of -rc cycles someday.
> > 
> > If the block layer gives us a 32k block aligned on a 32k boundary
> > (aligned), we have no guarantee that the iommu will not turn that into
> > something unaligned crossing a 32k (and thus possibly a 64k) boundary.
> ..
> 
> Certainly, but never any worse than what the block layer gave originally.
> 
> The important note being:  IOMMU only ever *merges*, it never *splits*.

Yes, but it will also change the address and doesn't guarantee the
alignment.

> Which means that, by the time we split up any mis-merges again for 64K crossings,
> we can never have more SG segments than what the block layer originally
> fed to the IOMMU stuff.
>
> Or so the IOMMU and SCSI experts here at LSF'08 have assured me,
> even after my own skeptical questioning.

I suppose so. I don't remember all of the details, but iirc, it has to
do with crossing 64K boundaries. Some controllers can't handle it.

It's not only the _size_ of the segments, it's their alignment.

The iommu will not keep alignement beyond the page size (and even
then... on powerpc with a 64k base page size, you may still end up with
a 4k aligned result, but let's not go there now).

So that means that even if your block layer gives you nice aligned less
than 64k segments that don't cross 64k boundaries, and even if your
iommu isn't doing any merging at all, it may still give you back things
that do not respect that 64k alignment boundary, might cross them, and
thus might need to be split.

Now, it would make sense (if we don't have it already) to have a flag
provided by the host controller that tells us whether it suffers from
that limitation, and if not, we get avoid the whole thing.

Ben.


