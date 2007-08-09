From: Andi Kleen <andi@firstfloor.org>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA open bugs)
Date: Fri, 10 Aug 2007 00:43:05 +0200
Message-ID: <20070809224305.GA1611@one.firstfloor.org>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com> <46BA9101.6080407@gmail.com> <20070809145336.6d728f9b@the-village.bc.nu> <20070809170540.GA30700@one.firstfloor.org> <20070809182101.710c3c5b@the-village.bc.nu> <20070809172304.GB30700@one.firstfloor.org> <20070809185310.682dffbc@the-village.bc.nu> <20070809192850.GA32280@one.firstfloor.org> <20070809233458.12d8447c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:38416 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbXHIWnH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 18:43:07 -0400
Content-Disposition: inline
In-Reply-To: <20070809233458.12d8447c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

On Thu, Aug 09, 2007 at 11:34:58PM +0100, Alan Cox wrote:
> > Where does the device come from? What device is it?
> 
> At the higher level someone passed us a device and some mappings and
> function methods and said "this is an IDE controller"

Ok you're stabbing in the dark. I guess more debugging is needed.

> > But at least on x86-64 the device is likely DMA capable. At least
> > PCMCIA usually is.  Near all devices are DMA capable, except perhaps
> 
> PCMCIA usally isn't.

Hmm?

> I don't want to know about arch internals. I don't want to know about
> platform specific DMA rules. I just want to be able to ask for DMA and
> get told yes or no. Oops is not a useful error return.

I'm not blaming libata here, just whoever gave that bogus device to it.

-Andi

