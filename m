From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 11/15] ide: PCI BMDMA initialization fixes
Date: Wed, 03 Oct 2007 17:13:21 +0400
Message-ID: <47039571.20907@ru.mvista.com>
References: <200710012338.31404.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns2.mvista.com ([63.81.120.155]:32440 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753969AbXJCNNk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2007 09:13:40 -0400
In-Reply-To: <200710012338.31404.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Set hwif->dma_base only if allocation of extra ports succeeds.

> * Allocate hwif->dmatable_cpu before reserving I/O ports.

    Looks like a bit of teardown code was missed with that change...

> While at it:

> * Move setting of hwif->dma_{base,master} from ide_{mapped_mmio,iomio}_dma()
>   to ide_setup_dma().

> * Rename 'dma_base' argument to 'base' in ide_setup_dma().

    I'm not sure what that achieves...

> * Remove stale ide_setup_dma() comment.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> @@ -1006,18 +994,20 @@ static int ide_dma_iobase(ide_hwif_t *hw
>  	return ide_iomio_dma(hwif, base, ports);
>  }
>  
> -/*
> - * This can be called for a dynamically installed interface. Don't __init it
> - */
> -void ide_setup_dma (ide_hwif_t *hwif, unsigned long dma_base, unsigned int num_ports)
> +void ide_setup_dma(ide_hwif_t *hwif, unsigned long base, unsigned num_ports)
>  {
> -	if (ide_dma_iobase(hwif, dma_base, num_ports))
> +	if (ide_allocate_dma_engine(hwif))
>  		return;
>  
> -	if (ide_allocate_dma_engine(hwif)) {
> -		ide_release_dma(hwif);
> +	if (ide_dma_iobase(hwif, base, num_ports))

    Why no ide_release_dma_engine() call here?

MBR, Sergei
