From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Tue, 26 Feb 2008 13:56:41 -0800
Message-ID: <1204063001.3254.96.camel@localhost.localdomain>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com>
	 <1203987277.15052.68.camel@pasglop> <47C36D64.6010001@rtr.ca>
	 <47C36EC3.4080708@rtr.ca> <1203994454.15052.83.camel@pasglop>
	 <47C397C4.2090309@rtr.ca> <1204003805.15052.112.camel@pasglop>
	 <47C3A71B.2070705@rtr.ca> <1204004844.15052.123.camel@pasglop>
	 <47C43D7F.3010005@rtr.ca>  <47C4439E.2000606@rtr.ca>
	 <1204062649.15052.164.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:55844 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762312AbYBZV4s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Feb 2008 16:56:48 -0500
In-Reply-To: <1204062649.15052.164.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

On Wed, 2008-02-27 at 08:50 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2008-02-26 at 11:51 -0500, Mark Lord wrote:
> > > That's interesting.  Can you point us to the exact file::lines where
> > > this happens?  It would be good to ensure that this gets fixed.
> > > 
> > > I'm copying Fujita Tomonori on this thread now -- he's the dude
> > who's
> > > trying to sort out the IOMMU mess.
> > ..
> > 
> > Mmm.. looks like ppc is already fixed in mainline,
> > commit 740c3ce66700640a6e6136ff679b067e92125794
> 
> No, I only fixed alignent up to PAGE_SIZE, not above.
> 
> Our iommu can use smaller than PAGE_SIZE allocations when PAGE_SIZE is
> 64k (it can use 4k), and that helps a lot with networking to avoid
> filling up pSeries small iommu's too fast. Unfortunately, that meant we
> used to not even get PAGE_SIZE alignment for some cases. The workaround
> fixes that but does not provide natural size alignment.
> 
> If we were to provide size based alignment of sg requests, fragmentation
> would become so bad we would basically end up failing a large amount of
> iommu allocations on servers.

Ben, he just quoted the wrong patch ... that was the segment length
limit patch.  The boundary alignment patch is this one:

fb3475e9b6bfa666107512fbd6006c26014f04b8

And it does alter the ppc iommu to respect the dma_boundary, so all of
the mechanics for removing the ppc special casing in libata/ide is
upstream.

James


