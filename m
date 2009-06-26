From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: porting IDE patches to PATA driver
Date: Fri, 26 Jun 2009 14:46:39 +0100
Message-ID: <20090626144639.4bc822b8@lxorguk.ukuu.org.uk>
References: <323951117.20090625100956@web.de>
	<20090625092324.2dd4de5a@lxorguk.ukuu.org.uk>
	<14164712.20090625103834@web.de>
	<20090625100542.525dba02@lxorguk.ukuu.org.uk>
	<951976828.20090625123021@web.de>
	<20090625122958.510c28ad@lxorguk.ukuu.org.uk>
	<96179821.20090626152440@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39614 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756083AbZFZNpE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jun 2009 09:45:04 -0400
In-Reply-To: <96179821.20090626152440@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrei Martynov <andrei.martynov@web.de>
Cc: linux-ide@vger.kernel.org

> libata functions. As you can see the new pata driver redefines set_piomode /
> set_dmamode to tune chipset and bmdma_start to flush CPU cache. It

The bmdma_start shouldn't be needed. Libata knows about using the cache
coherency dma interfaces and uses them.

The bmdma end is no standard and polls the status up to 100 times until
it gives a sensible looking answer. That may be needed but its hard to
guess from just horrible code if that was someone's random debug hacks or
a real chip erratum.

> works fine in UDMA mode on a newer chipset but I cannot get MW-DMA
> working on an older chipset.

I notice the 2.4.17 patches you are referencing don't enable MWDMA either
(#undef EBABLE_BMDMA) so does MWDMA actually work on the hardware ?

Alan
