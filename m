From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [parisc-linux] [PATCH] asm-parisc/ide.h cleanup (there are no standard ports)
Date: Sat, 27 Mar 2004 15:28:10 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040327222810.GB24782@colo.lackof.org>
References: <200403241443.43206.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:14483 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261966AbUC0W2M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Mar 2004 17:28:12 -0500
Content-Disposition: inline
In-Reply-To: <200403241443.43206.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: parisc-linux@parisc-linux.org, linux-ide@vger.kernel.org

On Wed, Mar 24, 2004 at 02:43:43PM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> Is this patch correct?

It's not necessary.

> Regards,
> Bartlomiej
> 
>  linux-2.6.5-rc2-bk3-root/include/asm-parisc/ide.h |   15 ++-------------
>  1 files changed, 2 insertions(+), 13 deletions(-)
> 
> diff -puN include/asm-parisc/ide.h~parisc_no_default_ide_ports include/asm-parisc/ide.h
> --- linux-2.6.5-rc2-bk3/include/asm-parisc/ide.h~parisc_no_default_ide_ports	2004-03-24 14:39:06.293991064 +0100
> +++ linux-2.6.5-rc2-bk3-root/include/asm-parisc/ide.h	2004-03-24 14:39:33.400870192 +0100
> @@ -41,19 +41,8 @@ static __inline__ void ide_init_hwif_por
>  	hw->io_ports[IDE_IRQ_OFFSET] = 0;
>  }
>  
> -static __inline__ void ide_init_default_hwifs(void)
> -{
> -#ifndef CONFIG_PCI
> -	hw_regs_t hw;
> -	int index;
> -
> -	for(index = 0; index < MAX_HWIFS; index++) {
> -		ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, NULL);
> -		hw.irq = ide_default_irq(ide_default_io_base(index));
> -		ide_register_hw(&hw);
> -	}
> -#endif
> -}
> +/* There are no standard ports. */
> +static inline void ide_init_default_hwifs(void)	{ ; }

Note the "ifndef CONFIG_PCI" - we only support IDE behind PCI to date.
ie this function already is "empty" for parisc since PCI must be enabled
when IDE is enabled. Hypothetically someone could add an IDE card
to a parisc EISA bus (eg 725), not define PCI, and then run the IDE
in PIO mode since DMA is still kaputt behind our EISA IOMMU.


thanks,
grant

