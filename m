From: Jens Axboe <axboe@suse.de>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 19:42:16 +0100
Message-ID: <20060321184215.GJ4285@suse.de>
References: <441DC397.9040504@rtr.ca> <441DC9CB.7030203@pobox.com> <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca> <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com> <441F8478.50806@rtr.ca> <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:18502 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1423237AbWCUSmV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 13:42:21 -0500
Content-Disposition: inline
In-Reply-To: <442006BC.8020100@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Mar 21 2006, Mark Lord wrote:
> Jeff Garzik wrote:
> >Mark Lord wrote:
> >>But (as I replied to myself earlier), I think it is a non issue,
> >>because the IOMMU merging cannot produce more SG entries than
> >>there were originally.  It may produce less, and the driver may then
> >>end up splitting them apart again, but it will never exceed what
> >>the block layer permitted in the first place.
> >
> >That says nothing about the boundaries upon which the IOMMU layer will 
> >or will not merge.  Without the fix, the problem case happens when (for 
> >example) the IOMMU output produces sg_tablesize segments, but some of 
> >those segments cross a 64k boundary and need to be split.
> 
> Yes, but the merging happens *after* the block layer has already
> guaranteed an sg list that respects what the driver told it.
> 
> So worst case, the IOMMU merges the entire sg list into a single
> multi-megabyte segment, and then the driver's fill_sg() function
> splits it all apart again while making up it's PRD list.
> 
> Even in that worst case, the number of segments for the PRD list
> will *always* be less than or equal to the size of the original
> block layer sg list.
> 
> So no need for hocus-pocus divide by 2.
> Good thing, too, because "divide by 2" would also fail
> if the above stuff were not true.
> 
> Think about it some more.
> 
> Jens, you know more about this stuff than most folks:
> What am I missing?

Seems to me that your reasoning is correct. It's a fact that the
original block mapped sg lists satisfies all requirements of the device
driver and/or hardware, otherwise would be a bug. The iommu may go nuts
of course, but logically that new sg list should be choppable into the
same requirements.

It would be much nicer if the iommu actually had some more knowledge,
ideally the same requirements that the block layer is faced with. No
driver should have to check the mapped sg list.

-- 
Jens Axboe

