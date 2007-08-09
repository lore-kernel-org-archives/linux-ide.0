From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA
 open bugs)
Date: Thu, 9 Aug 2007 18:53:10 +0100
Message-ID: <20070809185310.682dffbc@the-village.bc.nu>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com>
	<46BA9101.6080407@gmail.com>
	<20070809145336.6d728f9b@the-village.bc.nu>
	<20070809170540.GA30700@one.firstfloor.org>
	<20070809182101.710c3c5b@the-village.bc.nu>
	<20070809172304.GB30700@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50917 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752520AbXHIRrM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 13:47:12 -0400
In-Reply-To: <20070809172304.GB30700@one.firstfloor.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

> Someone must ask that caller library to DMA to/from that device
> in the first place. Whoever it is it is wrong. 

No I disagree.

> Or perhaps you got the wrong device here? For ISA devices we 
> traditionally used NULL. Or if you set up your own ISA devices
> (which I can't see a reason for but there might be one I'm missing) 
> at least give them a dma mask. Then it should probably work on x86-64.

The libata code currently (and this seems to work for all but x86-64)
does the following if it is setting up a potentially DMA capable device

	- Allocate a dma_coherent buffer
	- If it is refused then turn off DMA and use PIO

It has no idea whether a pcmcia, isa, platform or even PCI device happens
to be DMA capable, and there are platforms with PCI but very limited DMA
for example in the embedded space. In fact it has no idea this level
whether it is working a PCI, ISA, PCMCIA, SBUS or some other bus device.
It's supposed to be generic code.

Obviously doing anything other than dma_alloc_coherent if the allocation
fails is stupid but trying to allocate dma memory to find out if the
device can be used with DMA on a given platform is quite logical and
sensible in some cases.

Thus I think dma_alloc_coherent() for an ISA, PCMCIA or other class
(platform particularly) shouldn't explode on AMD64 but simply return
NULL. Its a sane request to make when you don't in your library know what
dev is.

Alan
