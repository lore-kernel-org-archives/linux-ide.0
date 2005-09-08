From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.13] ide: ide-dma.c should always check hwif->cds before hwif->cds->foo
Date: Thu, 8 Sep 2005 17:47:38 +0200
Message-ID: <58cb370e05090808472f5e12e4@mail.gmail.com>
References: <20050908151529.GL3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.207]:63535 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932704AbVIHPrl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Sep 2005 11:47:41 -0400
Received: by nproxy.gmail.com with SMTP id x37so614774nfc
        for <linux-ide@vger.kernel.org>; Thu, 08 Sep 2005 08:47:40 -0700 (PDT)
In-Reply-To: <20050908151529.GL3966@smtp.west.cox.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE Mailing List <linux-ide@vger.kernel.org>

Hi,

On 9/8/05, Tom Rini <trini@kernel.crashing.org> wrote:
> In some cases (such as the mips Toshiba TX4939 w/ onboard IDE, not PCI
> IDE), hwif->cds can be NULL, so test that prior to testing
> hwif->cds->foo

Both ide_iomio_dma() and ide_mapped_mmio_dma() are only called from
ide_dma_iobase().  ide_setup_dma() is the only user of ide_dma_iobase()
and it is supposed to be used only by IDE PCI drivers.

What is the reason for this change?

Bartlomiej

> Signed-off-by: Hiroshi DOYU <hdoyu@mvista.com>
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> Index: linux-2.6/drivers/ide/ide-dma.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/ide-dma.c
> +++ linux-2.6/drivers/ide/ide-dma.c
> @@ -846,7 +846,7 @@ static int ide_mapped_mmio_dma(ide_hwif_
>         printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
> 
>         hwif->dma_base = base;
> -       if (hwif->cds->extra && hwif->channel == 0)
> +       if (hwif->cds && hwif->cds->extra && hwif->channel == 0)
>                 hwif->dma_extra = hwif->cds->extra;
> 
>         if(hwif->mate)
> @@ -865,7 +865,7 @@ static int ide_iomio_dma(ide_hwif_t *hwi
>                 return 1;
>         }
>         hwif->dma_base = base;
> -       if ((hwif->cds->extra) && (hwif->channel == 0)) {
> +       if (hwif->cds && hwif->cds->extra && (hwif->channel == 0)) {
>                 request_region(base+16, hwif->cds->extra, hwif->cds->name);
>                 hwif->dma_extra = hwif->cds->extra;
>         }
> 
> --
> Tom Rini
> http://gate.crashing.org/~trini/
