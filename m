From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Tue, 26 Feb 2008 11:54:37 +1100
Message-ID: <1203987277.15052.68.camel@pasglop>
References: <47C3572D.1060904@rtr.ca>  <47C35A3B.8080604@pobox.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:51974 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbYBZAzz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 19:55:55 -0500
In-Reply-To: <47C35A3B.8080604@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>


On Mon, 2008-02-25 at 19:15 -0500, Jeff Garzik wrote:
> Mark Lord wrote:
> > Jeff,
> > 
> > We had a discussion here today about IOMMUs,
> > and they *never* split sg list entries -- they only ever *merge*.
> > 
> > And this happens only after the block layer has
> > already done merging while respecting q->seg_boundary_mask.
> > 
> > So worst case, the IOMMU may merge everything, and then in
> > libata we unmerge them again.  But the end result can never
> > exceed the max_sg_entries limit enforced by the block layer.
> 
> <shrug>  Early experience said otherwise.  The split in foo_fill_sg() 
> and resulting sg_tablesize reduction were both needed to successfully 
> transfer data, when Ben H originally did the work.
> 
> If Ben H and everyone on the arch side agrees with the above analysis, I 
> would be quite happy to remove all those "/ 2".

The split wasn't done by the iommu. The split was done by the IDE code
itself to handle the stupid 64k crossing thingy. If it's done
differently now, it might be possible to remove it, I haven't looked.

Cheers,
Ben.


