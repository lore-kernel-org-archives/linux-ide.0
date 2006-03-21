From: Jens Axboe <axboe@suse.de>
Subject: Re: libata+SGIO:  is .dma_boundary respected?
Date: Tue, 21 Mar 2006 20:42:15 +0100
Message-ID: <20060321194215.GP4285@suse.de>
References: <441F8478.50806@rtr.ca> <441F99AC.4000200@pobox.com> <442006BC.8020100@rtr.ca> <20060321184215.GJ4285@suse.de> <442051A0.1050200@rtr.ca> <4420541E.3070303@pobox.com> <44205484.9000702@rtr.ca> <44205525.20306@rtr.ca> <20060321193538.GO4285@suse.de> <44205642.7070302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:54545 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751170AbWCUTnK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Mar 2006 14:43:10 -0500
Content-Disposition: inline
In-Reply-To: <44205642.7070302@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, James Bottomley <James.Bottomley@steeleye.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tue, Mar 21 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> >My explanation was for the block layer part of course, I'm hoping (did
> >not check) that the iommu has similar sane defaults.
> 
> Part of the problem is that the iommu doesn't know as much as the block 
> layer.

Right, this is what needs fixing.

> >But this still really wants a unification of the dma restrictions...
> 
> Strongly agreed.  ISTR JamesB had some concrete thoughts in that 
> direction, but they never made it beyond an IRC channel and/or a few 
> emails.

The pci dev already holds the dma address, we could add dma boundary and
dma segment size as well?

-- 
Jens Axboe

