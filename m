From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Mon, 27 Mar 2006 14:07:54 +0200
Message-ID: <58cb370e0603270407v3329fa74n8148638a331b8419@mail.gmail.com>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net>
	 <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com>
	 <4427C467.5030300@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:16042 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750945AbWC0MHz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Mar 2006 07:07:55 -0500
Received: by pproxy.gmail.com with SMTP id w49so1258945pyg
        for <linux-ide@vger.kernel.org>; Mon, 27 Mar 2006 04:07:55 -0800 (PST)
In-Reply-To: <4427C467.5030300@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: alan@lxorguk.ukuu.org.uk, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Hi,

On 3/27/06, Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Bartlomiej Zolnierkiewicz wrote:
>
> >>The patch titled
>
> >>     Fix IDE DMA resource managment
>
> >>has been added to the -mm tree.  Its filename is
>
> >>     fix-ide-dma-resource-managment.patch
>
> >>See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> >>out what to do about this
>
> >>From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
>
> >>Resolve several IDE DMA resource management issues:
>
> >>- release DMA engine for memory mapped DMA as well
>
> > NAK - this won't work, see siimage.c how these resources were
> > really reserved in the first place [ request_mem_region() ]
>
>     Oops, looks like I missed that missing ide_setup_dma() call in that driver...
>     Is there any point at all in handling mmio == 2 case in ide-dma.c then?
> The only function that should handle this seems ide_release_dma() but in case
> of MMIO there's _no_ provision for the proper driver cleanup (assuming it
> allocates everything it needs by itself)... and, if the driver allocates the
> engine of the different size that PDC_BYTES * PRD_ENTRIES (the case with
> sgiioc3.c), the engine release doesn't look consitent...
>
> > hwif->mmio == 2 means that host driver is responsible
> > for reserving/releasing resources (this is _preferred_ way
> > of handling resources)
>
>     Hm, didn't know that...

not the best documentation but this should give some hints:

from <linux/ide.h>:
	int		mmio;		/* hosts iomio (0) or custom (2) select */

> > please fix siimage.c and core code instead
> > (please see libata-core.c and ata_host_stop() etc.)
>
> >>- release the same number of DMA I/O ports that was requested by a driver
>
> > NAK, it should be always 8 - the only driver which does something different
> > is trm290.c and now looking at it, it seems broken since early 2.5.x
>
>     Why then the argument to ide_setup_dma() is needed at all?

It is not needed and can be removed... :-)

> > please fix trm290.c to use ->mmio == 2 instead
>
>     It's a _really_ old chipset (pre SFF-8038i) and has _no_ memory mapped
> regs AFAIK...

->mmio == 2 means _only_ that host driver is responsible
for reserving/releasing resources - it doesn't mean that host driver
is using MMIO (a bit confusing but this is what the current code does)

> >>- release the channel's secondary DMA I/O ports for real
>
> > NAK, looking and the code - secondary DMA base is only used
> > by siimage.c and sgiioc4.c (both use ->mmio == 2, for siimage ->dma_base2
> > is unused, for sgiioc4 it is used for some weird DMA transfer ending stuff)
>
>     Yes, I have sgioc4.c patch that deals with this (almost) ready...

:-)

> > so all of ->dma_base2 handling code in ide-dma.c is just a dead code
> > and should be removed
>
>     OK...
>
> >>- claim extra DMA I/O ports regardless of what IDE channels are present/enabled
> >
> > NAK, this change makes extra DMA I/O ports being reserved twice
>
>     No. Please review the patch carefully. This was tested OK on both channels
> and secondary only channel.

OK, you are right here.

> >>- merge the duplicate code into ide_dma_iobase()
>
> > NAK, some of this code is irrelevant for MMIO (ie. ->dma_extra)
>
>     But it was duplicated anyway...

Yes but it should be removed for MMIO case completely.

Thanks,
Bartlomiej
