From: Andi Kleen <andi@firstfloor.org>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA open bugs)
Date: Thu, 9 Aug 2007 19:05:40 +0200
Message-ID: <20070809170540.GA30700@one.firstfloor.org>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com> <46BA9101.6080407@gmail.com> <20070809145336.6d728f9b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:49963 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935590AbXHIRFm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 13:05:42 -0400
Content-Disposition: inline
In-Reply-To: <20070809145336.6d728f9b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Andi Kleen <andi@firstfloor.org>

On Thu, Aug 09, 2007 at 02:53:36PM +0100, Alan Cox wrote:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=8424 - patch review
> > This one is on Alan.
> 
> I think not - something horrible is happening in dma_alloc_coherent when
> called from dmam_* with a non PCI device
> 
> 
> Seems to be some kind of AMD64 specific DMA mapping bug ?

I think it's dev->dma_mask == NULL. Clearly you're passing a non DMA
able device to dma_alloc_coherent(). Which seems like a caller bug.

-Andi

