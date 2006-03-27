From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: + fix-ide-dma-resource-managment.patch added to -mm tree
Date: Mon, 27 Mar 2006 14:58:29 +0200
Message-ID: <58cb370e0603270458h33247da4j9d453b1b14133911@mail.gmail.com>
References: <200603212323.k2LNNSnJ006228@shell0.pdx.osdl.net>
	 <58cb370e0603261309p126fdc64j1140bbf437ffe06e@mail.gmail.com>
	 <4427C467.5030300@ru.mvista.com> <4427CE99.6000004@ru.mvista.com>
	 <58cb370e0603270421s4e15b897nc415b8af76a447cf@mail.gmail.com>
	 <4427DD08.5030506@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:46621 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751000AbWC0M6a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Mar 2006 07:58:30 -0500
Received: by pproxy.gmail.com with SMTP id w49so1278974pyg
        for <linux-ide@vger.kernel.org>; Mon, 27 Mar 2006 04:58:29 -0800 (PST)
In-Reply-To: <4427DD08.5030506@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

On 3/27/06, Sergei Shtylylov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Bartlomiej Zolnierkiewicz wrote:
>
> >>>>>Resolve several IDE DMA resource management issues:
>
> >>>>>- release DMA engine for memory mapped DMA as well
>
> >>>>NAK - this won't work, see siimage.c how these resources were
> >>>>really reserved in the first place [ request_mem_region() ]
>
> >>    NB: it's reserved this way only when available -- this driver can work
> >>with both I/O and memory mapped regs...
>
> >>>   Oops, looks like I missed that missing ide_setup_dma() call in that
> >>>driver...
>
> >>    No, I've just forgotten that it's called implicitly from setup-pci.c since
> >>init_dma() "method" in not defined in that driver. So, looks like you're wrong
> >>here -- it should work currently BUT the DMA engine is not released since
> >>(mmio == 2) check and return precedes call to ide_release_dma_engine() in
> >>ide_release_dma().
>
> > please take a look at siimage.c:init_iops_siimage():
> >
> >       if (pci_get_drvdata(dev) == NULL)
> >               return;
>
>     So what? It just leaves the default I/O mapped iops intact and the driver
> init. continues...

->mmio stays 0 and the driver continues in the standard I/O mode...

> >       init_mmio_iops_siimage(hwif);
>
> > and siimage.c:init_mmio_iops_siimage():
>
> >       hwif->mmio                      = 2;
>
> > so ->mmio == 2 IFF MMIO is used
>
>     Yes, but ide_setup_dma() is called in _both_ cases with the current IDE
> core. And therefore, ide_release_dma() should've undone what ide_setup_dma()

and it does it for ->mmio == 0 case

> did... As I understand now, both the current behavior and what I'm proposing
> are wrong.

yes (->mmio == 2 case)

> > * for ->mmio == 0 current code seem to release resources properly
> > * for ->mmio == 2 you need to release the region that was reserved
> >   originally (for siimage it is one big fat mem region) and not standard
> >   DMA I/O regions, therefore this change is wrong
>
>     Yeah, I saw that prefectly clear before posting the 1st patch but really
> didn't have time for such a drastic change as adding the cleanup hook to a lot
> of drivers (and not much hope to get it accepted :-)

You don't have to add it to every host driver, just to drivers that need it...
It will be accepted if it is correct, currently proposed change isn't...

Bartlomiej
