From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/6] ide-pmac: use custom hwif->sg_max_nents only if
	DMA support is enabled
Date: Wed, 28 Nov 2007 10:36:15 +1100
Message-ID: <1196206575.7157.65.camel@pasglop>
References: <200711280000.14973.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59541 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799AbXK0Xg0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Nov 2007 18:36:26 -0500
In-Reply-To: <200711280000.14973.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org


On Wed, 2007-11-28 at 00:00 +0100, Bartlomiej Zolnierkiewicz wrote:
> Move setting hwif->sg_max_nents from pmac_ide_setup_device()
> to pmac_ide_setup_dma().
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Ack.

> ---
>  drivers/ide/ppc/pmac.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: b/drivers/ide/ppc/pmac.c
> ===================================================================
> --- a/drivers/ide/ppc/pmac.c
> +++ b/drivers/ide/ppc/pmac.c
> @@ -1133,8 +1133,6 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
>  		hwif->noprobe = 0;
>  #endif /* CONFIG_PMAC_MEDIABAY */
>  
> -	hwif->sg_max_nents = MAX_DCMDS;
> -
>  #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
>  	/* has a DBDMA controller channel */
>  	if (pmif->dma_regs)
> @@ -1751,6 +1749,8 @@ pmac_ide_setup_dma(pmac_ide_hwif_t *pmif
>  		return;
>  	}
>  
> +	hwif->sg_max_nents = MAX_DCMDS;
> +
>  	hwif->dma_host_set = &pmac_ide_dma_host_set;
>  	hwif->dma_setup = &pmac_ide_dma_setup;
>  	hwif->dma_exec_cmd = &pmac_ide_dma_exec_cmd;

