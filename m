From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata .sg_tablesize: why always dividing by 2 ?
Date: Mon, 25 Feb 2008 19:15:55 -0500
Message-ID: <47C35A3B.8080604@pobox.com>
References: <47C3572D.1060904@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53711 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756734AbYBZAQH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 19:16:07 -0500
In-Reply-To: <47C3572D.1060904@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Mark Lord wrote:
> Jeff,
> 
> We had a discussion here today about IOMMUs,
> and they *never* split sg list entries -- they only ever *merge*.
> 
> And this happens only after the block layer has
> already done merging while respecting q->seg_boundary_mask.
> 
> So worst case, the IOMMU may merge everything, and then in
> libata we unmerge them again.  But the end result can never
> exceed the max_sg_entries limit enforced by the block layer.

<shrug>  Early experience said otherwise.  The split in foo_fill_sg() 
and resulting sg_tablesize reduction were both needed to successfully 
transfer data, when Ben H originally did the work.

If Ben H and everyone on the arch side agrees with the above analysis, I 
would be quite happy to remove all those "/ 2".


> This can cost a lot of memory, as using NCQ effectively multiplies
> everything by 32..

I recommend dialing down the hyperbole a bit :)

"a lot" in this case is...  maybe another page or two per table, if 
that.  Compared with everything else in the system going on, with 
16-byte S/G entries, S/G table size is really the least of our worries.


If you were truly concerned about memory usage in sata_mv, a more 
effective route is simply reducing MV_MAX_SG_CT to a number closer to 
the average s/g table size -- which is far, far lower than 256 
(currently MV_MAX_SG_CT), or even 128 (MV_MAX_SG_CT/2).

Or moving to a scheme where you allocate (for example) S/G tables with 
32 entries... then allocate on the fly for the rare case where the S/G 
table must be larger.

Memory usage is simply not an effective argument in this case.  Safety 
and correctness are far more paramount.

	Jeff


