From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA
 open bugs)
Date: Thu, 9 Aug 2007 18:21:01 +0100
Message-ID: <20070809182101.710c3c5b@the-village.bc.nu>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com>
	<46BA9101.6080407@gmail.com>
	<20070809145336.6d728f9b@the-village.bc.nu>
	<20070809170540.GA30700@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49598 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1765745AbXHIRSp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 13:18:45 -0400
In-Reply-To: <20070809170540.GA30700@one.firstfloor.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Andi Kleen <andi@firstfloor.org>

> > Seems to be some kind of AMD64 specific DMA mapping bug ?
> 
> I think it's dev->dma_mask == NULL. Clearly you're passing a non DMA
> able device to dma_alloc_coherent(). Which seems like a caller bug.

Ok - other archs seem to just return NULL in this case. If its your view
that dma_alloc_coherent(dev) should explode not return NULL then we can
wrap dma_alloc_coherent but I'm not sure the caller library has any
business knowing whether a specific class of device is DMA capable on a
specific platform ?

Alan
