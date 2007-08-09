From: Andi Kleen <andi@firstfloor.org>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA open bugs)
Date: Thu, 9 Aug 2007 19:23:04 +0200
Message-ID: <20070809172304.GB30700@one.firstfloor.org>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com> <46BA9101.6080407@gmail.com> <20070809145336.6d728f9b@the-village.bc.nu> <20070809170540.GA30700@one.firstfloor.org> <20070809182101.710c3c5b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:35014 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765639AbXHIRXG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 13:23:06 -0400
Content-Disposition: inline
In-Reply-To: <20070809182101.710c3c5b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Thu, Aug 09, 2007 at 06:21:01PM +0100, Alan Cox wrote:
> > > Seems to be some kind of AMD64 specific DMA mapping bug ?
> > 
> > I think it's dev->dma_mask == NULL. Clearly you're passing a non DMA
> > able device to dma_alloc_coherent(). Which seems like a caller bug.
> 
> Ok - other archs seem to just return NULL in this case. If its your view

Ok then the initialization would fail.

I could do that, but clearly there must be some other bug
in the process that tries to do DMA on such random devices
in the first place.

> that dma_alloc_coherent(dev) should explode not return NULL then we can
> wrap dma_alloc_coherent but I'm not sure the caller library has any
> business knowing whether a specific class of device is DMA capable on a
> specific platform ?

Someone must ask that caller library to DMA to/from that device
in the first place. Whoever it is it is wrong. 

Or perhaps you got the wrong device here? For ISA devices we 
traditionally used NULL. Or if you set up your own ISA devices
(which I can't see a reason for but there might be one I'm missing) 
at least give them a dma mask. Then it should probably work on x86-64.

-Andi

