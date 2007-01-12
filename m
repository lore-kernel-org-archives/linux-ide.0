From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 19/19] ide: use PIO/MMIO operations directly where
 possible
Date: Fri, 12 Jan 2007 10:06:41 +0000
Message-ID: <20070112100641.02858876@localhost.localdomain>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	<20070112042807.28794.8251.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41343 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161053AbXALJzU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 04:55:20 -0500
In-Reply-To: <20070112042807.28794.8251.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 05:28:07 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> [PATCH] ide: use PIO/MMIO operations directly where possible
> 
> This results in smaller/faster/simpler code and allows future optimizations.
> Also remove no longer needed ide[_mm]_{inl,outl}() and ide_hwif_t.{INL,OUTL}.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> --- a.orig/drivers/ide/ide-dma.c
> +++ a/drivers/ide/ide-dma.c
> @@ -565,7 +565,10 @@ int ide_dma_setup(ide_drive_t *drive)
>  	}
>  
>  	/* PRD table */
> -	hwif->OUTL(hwif->dmatable_dma, hwif->dma_prdtable);
> +	if (hwif->mmio == 2)
> +		writel(hwif->dmatable_dma, (void __iomem *)hwif->dma_prdtable);
> +	else
> +		outl(hwif->dmatable_dma, hwif->dma_prdtable);


This should simply be if (hwif->mmio)

mmio = 1 is still used by some amiga and other oddments and indicates
mmio in old form. I don't think this causes a bug as they don't use the
DMA layer, but its a bug waiting to happen if the mmio==1 case doesn't
get handled correctly or BUG()

Alan
