From: Andi Kleen <andi@firstfloor.org>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA open bugs) II
Date: 10 Aug 2007 11:43:46 +0200
Message-ID: <p73sl6rencd.fsf@bingen.suse.de>
References: <46BA9101.6080407@gmail.com>
	<20070809145336.6d728f9b@the-village.bc.nu>
	<20070809170540.GA30700@one.firstfloor.org>
	<20070809182101.710c3c5b@the-village.bc.nu>
	<20070809172304.GB30700@one.firstfloor.org>
	<20070809185310.682dffbc@the-village.bc.nu>
	<20070809192850.GA32280@one.firstfloor.org>
	<20070809233458.12d8447c@the-village.bc.nu>
	<20070809224305.GA1611@one.firstfloor.org>
	<20070810001443.610185e1@the-village.bc.nu>
	<20070809231141.GB1845@one.firstfloor.org>
	<20070810002453.384a9b4c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:55249 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933809AbXHJItb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Aug 2007 04:49:31 -0400
In-Reply-To: <20070810002453.384a9b4c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > BTW unless I'm misreading the i386 code it'll not fail here, but
> > allocate memory. Surely that will cause failures later if you
> > rely on it failing? If you don't rely on it then changing x86-64
> > will also not help you.
> 
> Eww that'll do strange things.
> 

In theory I could change i386 too to return NULL in this case (dma_mask == NULL).
But I wonder how how many existing PCMCIA drivers I would break this way? 

Probably needs more testing at least.

My current patch is in 
ftp://ftp.firstfloor.org/pub/ak/x86_64/late-merge/patches/dma-alloc-mask

> Ok so we do in fact need some kind of proper way to ask if a device is
> DMA capable ?

Right now it seems to be (dev->dma_mask != NULL) 

-Andi

