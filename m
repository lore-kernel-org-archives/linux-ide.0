From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [parisc-linux] [PATCH] asm-parisc/ide.h cleanup (there are no standard ports)
Date: Sat, 27 Mar 2004 16:49:26 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040327234926.GC24782@colo.lackof.org>
References: <200403241443.43206.bzolnier@elka.pw.edu.pl> <20040327222810.GB24782@colo.lackof.org> <200403280024.57672.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:12948 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261946AbUC0Xta (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Mar 2004 18:49:30 -0500
Content-Disposition: inline
In-Reply-To: <200403280024.57672.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: parisc-linux@parisc-linux.org, linux-ide@vger.kernel.org

On Sun, Mar 28, 2004 at 12:24:57AM +0100, Bartlomiej Zolnierkiewicz wrote:
> Well, I know but I have other cleanups incremental to this one. :-)

Ah ok - go for it.

> It is also NOP for #ifdef CONFIG_PCI (that is the reason for this patch BTW)
> since both ide_default_io_base() and ide_default_irq() are defined as '0'.

Ok - I didn't look any deeper.

> > Hypothetically someone could add an IDE card
> > to a parisc EISA bus (eg 725), not define PCI, and then run the IDE
> > in PIO mode since DMA is still kaputt behind our EISA IOMMU.
> 
> That would require (at least) passing "ide=base[,ctl,[irq]]" kernel parameter.

I was told offline my hypothetical example is in fact hypothetical.
parisc won't build with IDE unless PCI is defined. I haven't tried.

thanks,
grant
