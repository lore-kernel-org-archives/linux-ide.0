From: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA
	open bugs)
Date: Thu, 09 Aug 2007 15:53:26 -0700
Message-ID: <1186700006.3426.8.camel@localhost.localdomain>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com>
	 <46BA9101.6080407@gmail.com> <20070809145336.6d728f9b@the-village.bc.nu>
	 <20070809170540.GA30700@one.firstfloor.org>
	 <20070809182101.710c3c5b@the-village.bc.nu>
	 <20070809172304.GB30700@one.firstfloor.org>
	 <20070809185310.682dffbc@the-village.bc.nu>
	 <1186690789.3426.4.camel@localhost.localdomain>
	 <20070809233708.11e6f3c4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:54625 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754178AbXHIWxa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 18:53:30 -0400
In-Reply-To: <20070809233708.11e6f3c4@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Thu, 2007-08-09 at 23:37 +0100, Alan Cox wrote:
> > You cannot allocate a dma_coherent buffer without passing in the correct
> > underlying device ... on parisc we'd explode trying to find the iommu to
> > map through (some of our hw has more than one).
> 
> We do pass the correct underlying device. Then dma_alloc_coherent oopses
> on x86_64 if you pass some valid devices (eg pcmcia). 

If the device you're passing has a NULL dma_mask pointer that means the
platform hasn't set it up correctly for dma ... and that's the
underlying problem (although it's not necessarily a libata problem): you
can't call dma_ operations on a device that hasn't been set up in the
platform for it.

James


