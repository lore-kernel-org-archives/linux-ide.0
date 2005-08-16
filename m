From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Tue, 16 Aug 2005 11:54:46 +0200
Message-ID: <58cb370e05081602543e34b08b@mail.gmail.com>
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <1123836012.22460.16.camel@localhost.localdomain>
	 <200508151507.22776.bjorn.helgaas@hp.com>
	 <58cb370e050816023845b57a74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.199]:47880 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965176AbVHPJyv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 05:54:51 -0400
Received: by nproxy.gmail.com with SMTP id l37so262615nfc
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 02:54:46 -0700 (PDT)
In-Reply-To: <58cb370e050816023845b57a74@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org

On 8/16/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> Hi,
> 
> On 8/15/05, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > On Friday 12 August 2005 2:40 am, Alan Cox wrote:
> > > Assuming all IA-64 boxes are PCI or better then you actually want to
> > > edit include/asm-ia64/ide.h and edit ide_default_io_base where someone
> > > years ago cut and pasted x86-32 values so that case 2-5 are removed.
> > > Then you will just probe the compatibility mode PCI addresses for system
> > > IDE channels.
> >
> > Thanks for the pointer.  There shouldn't be anything arch-
> > specific required for ia64, so I think we can get rid of
> > just about everything in asm-ia64/ide.h, since everything
> > we care about will be discovered by PCI IDE.
> 
> Agreed but I have few comments:
> * is this change OK w.r.t. IA64_HP_SIM?
> * removing IDE_ARCH_OBSOLETE_INIT define has some implications,
>   * non-functional ide-cs driver (but there is no PCMCIA on IA64?)
>   * ordering change for ide-pnp interfaces in case of no IDE devices
>     on default IDE PCI ports, (but there aren't any ide-pnp devices on IA64?)
>   * non-functional HDIO_REGISTER_HWIF ioctl (ain't really working either)

sorry, should be HDIO_SCAN_HWIF

>   are these implication fine with IA64?

One more thing, if some IDE PCI devices are used on IA64 in compatibility mode
you need to fix the host driver to set hwif->irq since
ide_default_irq() is gone now
(I think especially about piix.c and #ifndef/#endif CONFIG_IA64 that
it contains).

> > Other comments or advice?
> 
> Please make IDE_GENERIC depend on !IA_64.

!IA64 of course

Bartlomiej
