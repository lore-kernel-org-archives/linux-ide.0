From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: libata NCQ implementation questions
Date: Mon, 12 May 2008 14:22:07 +0200
Message-ID: <18472.13935.176531.126146@harpo.it.uu.se>
References: <18471.32504.953679.399689@harpo.it.uu.se>
	<da824cf30805112105x4444f38cxb31f5f0e5a105c5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:50201 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbYELMWl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 May 2008 08:22:41 -0400
In-Reply-To: <da824cf30805112105x4444f38cxb31f5f0e5a105c5e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, jgarzik@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org

Grant Grundler writes:
 > On Sun, May 11, 2008 at 4:19 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
 > > I've started working on NCQ support for sata_promise,
 > > and I have a few questions regarding NCQ and libata:
 > ...
 > > 5. Does dmam_alloc_coherent() give the same alignment guarantees
 > >   that pci_alloc_consistent() does? That is, both CPU and bus
 > >   addresses will be aligned to the smallest PAGE_SIZE order that
 > >   fits the requested size.
 > >
 > >   On x86, pci_alloc_consistent() is implemented directly on top of
 > >   dma_alloc_coherent(), which would imply that dma_alloc_coherent()
 > >   has at least as strong alignment guarantees as pci_alloc_consistent().
 > >   And since dmam_alloc_coherent() is documented to be exactly like
 > >   dma_alloc_coherent() except for being managed, similar alignment
 > >   guarantees for dmam_alloc_coherent() should be true. However, this
 > >   refers to one platform's implementation; I can't find any generic
 > >   documentation about alignment for dma_alloc_coherent().
 > 
 > There is no guarantee on alignment. :(

Thanks, I was afraid of that.

 > >   I've looked at pci_set_dma_mask(), but as far as I can tell, it
 > >   can only express size limits of addresses, it cannot express alignment
 > >   constraints.
 > 
 > Correct. The section on dma_pool_create() in Documentation/DMA-API.txt
 > does provide a means for the driver to express alignment requirements.
 > But I suspect this only solves part of your problem.

Maybe. I'll have a look.

 > >   The issue is that NCQ on Promise SATA is done by an FPDMA engine
 > >   that unfortunately has a rather annoying addressing limitation:
 > >   it requires that all NCQ packet and SG data for all active tags
 > >   on a port is located in a single physical memory region that does
 > >   not cross a 64KB physical memory boundary.
 > 
 > Could the driver map 64KB space and test if the DMA mapping is
 > properly aligned?
 > 
 > I'm not sure if it would have to fall back to a bounce-buffer like scheme
 > to copy the data to a "well aligned" buffer that has the right alignment.
 > That's obviously not desirable since it's a huge perf hit.

I don't think bounce buffers are meaningful for NCQ. Command
execution is delayed and completed in unpredictable order, so
I'd need a largish valid buffer anyway to make that work.

One workaround is to overallocate and do my own alignment.

Or one could just disable NCQ if the special allocation fails
and fall back to the current one-command-at-a-time scheme.

/Mikael
