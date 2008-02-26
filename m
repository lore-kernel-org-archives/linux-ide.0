From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Tue, 26 Feb 2008 16:47:24 +1100
Message-ID: <1204004844.15052.123.camel@pasglop>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com>
	 <1203987277.15052.68.camel@pasglop> <47C36D64.6010001@rtr.ca>
	 <47C36EC3.4080708@rtr.ca> <1203994454.15052.83.camel@pasglop>
	 <47C397C4.2090309@rtr.ca> <1204003805.15052.112.camel@pasglop>
	 <47C3A71B.2070705@rtr.ca>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45088 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbYBZFsT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Feb 2008 00:48:19 -0500
In-Reply-To: <47C3A71B.2070705@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>


On Tue, 2008-02-26 at 00:43 -0500, Mark Lord wrote:
> > I suppose so. I don't remember all of the details, but iirc, it has to
> > do with crossing 64K boundaries. Some controllers can't handle it.
> > 
> > It's not only the _size_ of the segments, it's their alignment.
> > 
> > The iommu will not keep alignement beyond the page size (and even
> > then... on powerpc with a 64k base page size, you may still end up with
> > a 4k aligned result, but let's not go there now).
> ..
> 
> That's just not possible, unless the IOMMU *splits* segments.
> And the IOMMU experts here say that it never does that.

It is totally possible, and I know as wrote part of the powerpc iommu
code :-)

The iommu code makes no guarantee vs. preserving the alignment of a
segment, at least not below PAGE_SIZE.

Thus if you pass to dma_map_sg() a 64K aligned 64K segment, you may well
get back a 4K aligned 64K segment.

Enforcing natural alignment in the iommu code only happens for
dma_alloc_coherent (it uses order-N allocations anyway), it doesn't
happen for map_sg. If we were to do that, we would make it very likely
for iommu allocations to fail on machine with small DMA windows.

Ben.
 


