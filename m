From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Mon, 27 Mar 2006 14:21:59 +0200
Message-ID: <58cb370e0603270421s4e15b897nc415b8af76a447cf@mail.gmail.com>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net>
	 <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com>
	 <4427C467.5030300@ru.mvista.com> <4427CE99.6000004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:14534 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750948AbWC0MWA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Mar 2006 07:22:00 -0500
Received: by pproxy.gmail.com with SMTP id w49so1264000pyg
        for <linux-ide@vger.kernel.org>; Mon, 27 Mar 2006 04:22:00 -0800 (PST)
In-Reply-To: <4427CE99.6000004@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: alan@lxorguk.ukuu.org.uk, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

On 3/27/06, Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Sergei Shtylylov wrote:
>
> > Bartlomiej Zolnierkiewicz wrote:
>
> [skipped]
>
> >>> Resolve several IDE DMA resource management issues:
>
> >>> - release DMA engine for memory mapped DMA as well
>
> >> NAK - this won't work, see siimage.c how these resources were
> >> really reserved in the first place [ request_mem_region() ]
>
>     NB: it's reserved this way only when available -- this driver can work
> with both I/O and memory mapped regs...
>
> >    Oops, looks like I missed that missing ide_setup_dma() call in that
> > driver...
>
>     No, I've just forgotten that it's called implicitly from setup-pci.c since
> init_dma() "method" in not defined in that driver. So, looks like you're wrong
> here -- it should work currently BUT the DMA engine is not released since
> (mmio == 2) check and return precedes call to ide_release_dma_engine() in
> ide_release_dma().

please take a look at siimage.c:init_iops_siimage():

	if (pci_get_drvdata(dev) == NULL)
		return;
	init_mmio_iops_siimage(hwif);

and siimage.c:init_mmio_iops_siimage():

	hwif->mmio			= 2;

so ->mmio == 2 IFF MMIO is used

* for ->mmio == 0 current code seem to release resources properly
* for ->mmio == 2 you need to release the region that was reserved
  originally (for siimage it is one big fat mem region) and not standard
  DMA I/O regions, therefore this change is wrong

>     And as I said, there's no provision to release any driver-specific
> resources on a call to ide_release_dma()...

That's why asked you to take look at libata-core.c:ata_host_stop()
etc. and to add any needed core code... :-)

> [skipped]
>
> >> hwif->mmio == 2 means that host driver is responsible
> >> for reserving/releasing resources (this is _preferred_ way
> >> of handling resources)
>
> >    Hm, didn't know that...
>
>     ... and this was hard to guess from the current code. ;-)
>
> >> please fix trm290.c to use ->mmio == 2 instead
>
> >    It's a _really_ old chipset (pre SFF-8038i) and has _no_ memory
> > mapped regs AFAIK...
>
>     The only thing that can be done is not to call ide_setup_dma() from it...

Exactly and make trm290.c to handle resources itself...

> >>> - release the channel's secondary DMA I/O ports for real
>
> >> NAK, looking and the code - secondary DMA base is only used
> >> by siimage.c and sgiioc4.c (both use ->mmio == 2, for siimage ->dma_base2
> >> is unused, for sgiioc4 it is used for some weird DMA transfer ending
> >> stuff)
>
> >    Yes, I have sgioc4.c patch that deals with this (almost) ready...
>
>     ... and for siimage, this seems a no-brainer. :-)

Yes, you may want to fix it... :-)

Thanks,
Bartlomiej
