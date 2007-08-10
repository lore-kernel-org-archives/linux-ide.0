From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA
	open bugs) II
Date: Fri, 10 Aug 2007 07:52:17 -0700
Message-ID: <1186757538.3335.3.camel@localhost.localdomain>
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
	 <p73sl6rencd.fsf@bingen.suse.de>
	 <20070810145430.17d72a76@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:34140 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1764563AbXHJOw3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 10:52:29 -0400
In-Reply-To: <20070810145430.17d72a76@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Fri, 2007-08-10 at 14:54 +0100, Alan Cox wrote:
> > > Ok so we do in fact need some kind of proper way to ask if a device is
> > > DMA capable ?
> > 
> > Right now it seems to be (dev->dma_mask != NULL) 
> 
> I'll follow that path for now then

Not in non platform code, please ... somewhere on the Janitor's list is
moving the dma_mask from the bus specific devices into the generic
device ... when that happens this quantity will become u64 and they
won't know what to do with the NULL check.

Even today, it's wrong for this to be NULL.  It's a bug somewhere in the
pcmcia layer.  What should happen is that there should be a u64 dma_mask
somewhere in struct pcmcia_device where this should be pointing.

James


