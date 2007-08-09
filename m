From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AMD64 dma_alloc_coherent crashes on non PCI device (was SATA
 open bugs)
Date: Thu, 9 Aug 2007 23:34:58 +0100
Message-ID: <20070809233458.12d8447c@the-village.bc.nu>
References: <32209efe0708081531o4215bac5teac2113c3518c743@mail.gmail.com>
	<46BA9101.6080407@gmail.com>
	<20070809145336.6d728f9b@the-village.bc.nu>
	<20070809170540.GA30700@one.firstfloor.org>
	<20070809182101.710c3c5b@the-village.bc.nu>
	<20070809172304.GB30700@one.firstfloor.org>
	<20070809185310.682dffbc@the-village.bc.nu>
	<20070809192850.GA32280@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60669 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750736AbXHIWe6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 18:34:58 -0400
In-Reply-To: <20070809192850.GA32280@one.firstfloor.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <htejun@gmail.com>, Natalie Protasevich <protasnb@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

> Where does the device come from? What device is it?

At the higher level someone passed us a device and some mappings and
function methods and said "this is an IDE controller"

> Is that known already?

The core code has no idea or interest in where it came from.

> But at least on x86-64 the device is likely DMA capable. At least
> PCMCIA usually is.  Near all devices are DMA capable, except perhaps

PCMCIA usally isn't.

> So if I return NULL then either a really DMA capable device will
> not work. Or you got a real oddball device that you shouldn't have gotten
> in the first place. 

What about other platforms ? I don't want libata to have

#ifdef CONFIG_X86_64
	/* this platform is different)
	if (hack-around-in-dev-struct())
		return NULL;
#endif


All I want is

	This is a device, the caller has said it may be DMA capable
	dma_alloc_coherent
		NULL. ok in this situation it isn't

I don't want to know about arch internals. I don't want to know about
platform specific DMA rules. I just want to be able to ask for DMA and
get told yes or no. Oops is not a useful error return.
