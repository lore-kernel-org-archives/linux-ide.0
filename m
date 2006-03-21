From: Jens Axboe <axboe@suse.de>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 20:35:38 +0100
Message-ID: <20060321193538.GO4285@suse.de>
References: <441DD300.9050702@rtr.ca> <441F544A.6080301@pobox.com> <441F8478.50806@rtr.ca> <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca> <20060321184215.GJ4285@suse.de> <442051A0.1050200@rtr.ca> <4420541E.3070303@pobox.com> <44205484.9000702@rtr.ca> <44205525.20306@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:49929 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964851AbWCUTfl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 14:35:41 -0500
Content-Disposition: inline
In-Reply-To: <44205525.20306@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, James Bottomley <James.Bottomley@steeleye.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, Mar 21 2006, Mark Lord wrote:
> Mark Lord wrote:
> >Jeff Garzik wrote:
> >>
> >>>In the case of sata_mv on the Marvell 6081 (which I'm looking at this 
> >>>week)
> >>>it's hardware limit is actually 0xffffffff rather than 0xffff.
> >>
> >>If the limit is not 0xffff, then there's no need for any of this 
> >>limitation junk.  No s/g entry splitting after pci_map_sg(), no 
> >>artificial sg_tablesize limitation, etc.
> >
> >Not even for a merged IOMMU segment that crosses the 4GB "boundary" ?
> 
> Clarification:  this is a 64-bit PCI(e/X) device, and the above query
> applies mainly to it's use in a 64-bit slot on a 64-bit kernel.
> 
> It's not clear to me whether this can be an issue on a 32-bit kernel
> on 36-bit hardware, though.

My explanation was for the block layer part of course, I'm hoping (did
not check) that the iommu has similar sane defaults.

But this still really wants a unification of the dma restrictions...

-- 
Jens Axboe

