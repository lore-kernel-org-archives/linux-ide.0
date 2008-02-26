From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Tue, 26 Feb 2008 13:54:14 +1100
Message-ID: <1203994454.15052.83.camel@pasglop>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com>
	 <1203987277.15052.68.camel@pasglop> <47C36D64.6010001@rtr.ca>
	 <47C36EC3.4080708@rtr.ca>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40709 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbYBZDBD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 22:01:03 -0500
In-Reply-To: <47C36EC3.4080708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>


> James B.  suggests that we stick a WARN_ON() into libata to let us
> know if that precondition is violated.  Sounds like an easy thing to do
> for a couple of -rc cycles someday.

If the block layer gives us a 32k block aligned on a 32k boundary
(aligned), we have no guarantee that the iommu will not turn that into
something unaligned crossing a 32k (and thus possibly a 64k) boundary.

On powerpc, the iommu operates on 4k pages and only provides that level
of alignment to dma_map_sg() (dma_alloc_coherent are naturally aligned,
but not map_sg, that would put way too much pressure on the allocator on
machines that have pinhole-sized iommu space).

Cheers,
Ben.


