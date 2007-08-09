From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA
 open bugs)
Date: Fri, 10 Aug 2007 00:17:13 +0100
Message-ID: <20070810001713.3e098338@the-village.bc.nu>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com>
	<46BA9101.6080407@gmail.com>
	<20070809145336.6d728f9b@the-village.bc.nu>
	<20070809170540.GA30700@one.firstfloor.org>
	<20070809182101.710c3c5b@the-village.bc.nu>
	<20070809172304.GB30700@one.firstfloor.org>
	<20070809185310.682dffbc@the-village.bc.nu>
	<1186690789.3426.4.camel@localhost.localdomain>
	<20070809233708.11e6f3c4@the-village.bc.nu>
	<1186700006.3426.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44702 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755364AbXHIXKA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 19:10:00 -0400
In-Reply-To: <1186700006.3426.8.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

> If the device you're passing has a NULL dma_mask pointer that means the
> platform hasn't set it up correctly for dma ... and that's the

Well it may not do DMA. 

> underlying problem (although it's not necessarily a libata problem): you
> can't call dma_ operations on a device that hasn't been set up in the
> platform for it.

Right.

Ok so what is the right way given a random *correctly* set up device that
may or may not be DMA capable to determine this. Its an arbitary device
pointer for an arbitary device class on an arbitary platform which may or
may not support DMA for this device class ?

Can I called dma_alloc_coherent and get a NULL back or do we need a
device_can_dma() check in each platform ?

Alan
