From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [parisc-linux] [PATCH] asm-parisc/ide.h cleanup (there are no standard ports)
Date: Sun, 28 Mar 2004 00:24:57 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403280024.57672.bzolnier@elka.pw.edu.pl>
References: <200403241443.43206.bzolnier@elka.pw.edu.pl> <20040327222810.GB24782@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:4776 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262052AbUC0XP7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 27 Mar 2004 18:15:59 -0500
In-Reply-To: <20040327222810.GB24782@colo.lackof.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@parisc-linux.org>
Cc: parisc-linux@parisc-linux.org, linux-ide@vger.kernel.org

On Saturday 27 of March 2004 23:28, Grant Grundler wrote:
> On Wed, Mar 24, 2004 at 02:43:43PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> > Is this patch correct?
>
> It's not necessary.

Well, I know but I have other cleanups incremental to this one. :-)

> > Regards,
> > Bartlomiej
> >
> >  linux-2.6.5-rc2-bk3-root/include/asm-parisc/ide.h |   15 ++-------------
> >  1 files changed, 2 insertions(+), 13 deletions(-)
> >
> > diff -puN include/asm-parisc/ide.h~parisc_no_default_ide_ports
> > include/asm-parisc/ide.h ---
> > linux-2.6.5-rc2-bk3/include/asm-parisc/ide.h~parisc_no_default_ide_ports	
> >2004-03-24 14:39:06.293991064 +0100 +++
> > linux-2.6.5-rc2-bk3-root/include/asm-parisc/ide.h	2004-03-24
> > 14:39:33.400870192 +0100 @@ -41,19 +41,8 @@ static __inline__ void
> > ide_init_hwif_por
> >  	hw->io_ports[IDE_IRQ_OFFSET] = 0;
> >  }
> >
> > -static __inline__ void ide_init_default_hwifs(void)
> > -{
> > -#ifndef CONFIG_PCI
> > -	hw_regs_t hw;
> > -	int index;
> > -
> > -	for(index = 0; index < MAX_HWIFS; index++) {
> > -		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
> > -		hw.irq = ide_default_irq(ide_default_io_base(index));
> > -		ide_register_hw(&hw);
> > -	}
> > -#endif
> > -}
> > +/* There are no standard ports. */
> > +static inline void ide_init_default_hwifs(void)	{ ; }
>
> Note the "ifndef CONFIG_PCI" - we only support IDE behind PCI to date.
> ie this function already is "empty" for parisc since PCI must be enabled

It is also NOP for #ifdef CONFIG_PCI (that is the reason for this patch BTW)
since both ide_default_io_base() and ide_default_irq() are defined as '0'.

> when IDE is enabled. Hypothetically someone could add an IDE card
> to a parisc EISA bus (eg 725), not define PCI, and then run the IDE
> in PIO mode since DMA is still kaputt behind our EISA IOMMU.

That would require (at least) passing "ide=base[,ctl,[irq]]" kernel parameter.

Regards,
Bartlomiej

