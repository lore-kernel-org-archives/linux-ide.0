From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Tue, 26 Feb 2008 08:09:47 -0800
Message-ID: <1204042187.3254.70.camel@localhost.localdomain>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com>
	 <1203987277.15052.68.camel@pasglop> <47C36D64.6010001@rtr.ca>
	 <47C36EC3.4080708@rtr.ca> <1203994454.15052.83.camel@pasglop>
	 <47C397C4.2090309@rtr.ca> <1204003805.15052.112.camel@pasglop>
	 <47C3A71B.2070705@rtr.ca>  <1204004844.15052.123.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:37624 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750758AbYBZQJx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 11:09:53 -0500
In-Reply-To: <1204004844.15052.123.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>


On Tue, 2008-02-26 at 16:47 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2008-02-26 at 00:43 -0500, Mark Lord wrote:
> > > I suppose so. I don't remember all of the details, but iirc, it has to
> > > do with crossing 64K boundaries. Some controllers can't handle it.
> > > 
> > > It's not only the _size_ of the segments, it's their alignment.
> > > 
> > > The iommu will not keep alignement beyond the page size (and even
> > > then... on powerpc with a 64k base page size, you may still end up with
> > > a 4k aligned result, but let's not go there now).
> > ..
> > 
> > That's just not possible, unless the IOMMU *splits* segments.
> > And the IOMMU experts here say that it never does that.
> 
> It is totally possible, and I know as wrote part of the powerpc iommu
> code :-)
> 
> The iommu code makes no guarantee vs. preserving the alignment of a
> segment, at least not below PAGE_SIZE.

It's supposed to, precisely to forestall this case.  The alignment
guarantees of the parisc iommu code are sg length aligned up to a fixed
maximum (128k on 32 bit and 256k on 64 bit because of the way the
allocator works).   However, tomo's code is fixing this, so it shouldn't
be a problem much longer.

James


