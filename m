From: Andi Kleen <andi@firstfloor.org>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA open bugs)
Date: Thu, 9 Aug 2007 21:28:50 +0200
Message-ID: <20070809192850.GA32280@one.firstfloor.org>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com> <46BA9101.6080407@gmail.com> <20070809145336.6d728f9b@the-village.bc.nu> <20070809170540.GA30700@one.firstfloor.org> <20070809182101.710c3c5b@the-village.bc.nu> <20070809172304.GB30700@one.firstfloor.org> <20070809185310.682dffbc@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:41291 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbXHIT2w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 15:28:52 -0400
Content-Disposition: inline
In-Reply-To: <20070809185310.682dffbc@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Thu, Aug 09, 2007 at 06:53:10PM +0100, Alan Cox wrote:
> > Or perhaps you got the wrong device here? For ISA devices we 
> > traditionally used NULL. Or if you set up your own ISA devices
> > (which I can't see a reason for but there might be one I'm missing) 
> > at least give them a dma mask. Then it should probably work on x86-64.
> 
> The libata code currently (and this seems to work for all but x86-64)
> does the following if it is setting up a potentially DMA capable device

Where does the device come from? What device is it?
Is that known already?

> Thus I think dma_alloc_coherent() for an ISA, PCMCIA or other class
> (platform particularly) shouldn't explode on AMD64 but simply return
> NULL. Its a sane request to make when you don't in your library know what
> dev is.

But at least on x86-64 the device is likely DMA capable. At least
PCMCIA usually is.  Near all devices are DMA capable, except perhaps
SMBus and some real oddballs. So the device should not have a NULL dma_mask
in the first place. Or it is the wrong device. e.g. we have platform
devices for things like timers etc. which are really not DMA capable
because it doesn't make much sense to DMA your timer; but there
should be really no reason to use such a device in a libata driver. 

If it's some kind of PCMCIA device like implied by pata_pcmcia
then it's likely DMA capable.

So if I return NULL then either a really DMA capable device will
not work. Or you got a real oddball device that you shouldn't have gotten
in the first place. 

Perhaps the PCMCIA code sets up some of its devices wrong? 

-Andi

