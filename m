From: Jens Axboe <axboe@suse.de>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 20:31:44 +0100
Message-ID: <20060321193143.GN4285@suse.de>
References: <441DCAC9.5090603@rtr.ca> <441DCF73.2080600@pobox.com> <441DD101.5050202@rtr.ca> <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com> <441F8478.50806@rtr.ca> <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca> <20060321184215.GJ4285@suse.de> <442051A0.1050200@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:60679 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964844AbWCUTeC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 14:34:02 -0500
Content-Disposition: inline
In-Reply-To: <442051A0.1050200@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Mar 21 2006, Mark Lord wrote:
> Jens Axboe wrote:
> ..
> >Seems to me that your reasoning is correct. It's a fact that the
> >original block mapped sg lists satisfies all requirements of the device
> >driver and/or hardware, otherwise would be a bug. The iommu may go nuts
> >of course, but logically that new sg list should be choppable into the
> >same requirements.
> 
> I just finished going through all of the arch implementations and,
> as near as I can tell, they only ever *merge* sg list items,
> and never create additional sg entries.
> 
> So low-level drivers (at present) can safely report their real limits,
> and then in their fill_sg() routines they can run around and split up
> any IOMMU merges that their hardware cannot tolerate.

Definitely, it would be highly illegal for the iommu code to do that.
And pretty odd, too :-)

> >It would be much nicer if the iommu actually had some more knowledge,
> >ideally the same requirements that the block layer is faced with. No
> >driver should have to check the mapped sg list.
> 
> Yup.  Absolutely.  So long as they continue to never *add* new sg entries
> (only doing merges instead), then I believe they just need to know the
> device's .dma_boundary parameter.  We could pass this to them as an extra
> parameters, or perhaps embed it into the sg_list data structure somehow.

You want max size as well, so boundary and max size should be enough.

> In the case of sata_mv on the Marvell 6081 (which I'm looking at this 
> week)
> it's hardware limit is actually 0xffffffff rather than 0xffff.
> 
> I wonder how well Linux drivers in general deal with that on a 64-bit 
> machine?

0xffffffff is the default boundary exactly because we assume (based on
experience and real hardware, aic7xxx springs to mind) that most
hardware cannot deal with a 4GB wrap.

-- 
Jens Axboe

