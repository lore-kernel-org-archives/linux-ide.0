From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/18] ide-pmac: skip conservative PIO "downgrade"
Date: Mon, 05 Nov 2007 10:35:43 +1100
Message-ID: <1194219343.6511.19.camel@pasglop>
References: <200711050017.04599.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:42212 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbXKDXgE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Nov 2007 18:36:04 -0500
In-Reply-To: <200711050017.04599.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>


On Mon, 2007-11-05 at 00:17 +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> We can skip conservative PIO "downgrade" (PIO3 becomes PIO2 etc.) on PMAC.
> 
> Problem reported by Mikael.
> 
> Cc: Mikael Pettersson <mikpe@it.uu.se>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ide/ppc/pmac.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: b/drivers/ide/ppc/pmac.c
> ===================================================================
> --- a/drivers/ide/ppc/pmac.c
> +++ b/drivers/ide/ppc/pmac.c
> @@ -1133,6 +1133,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
>  	hwif->drives[0].autotune = IDE_TUNE_AUTO;
>  	hwif->drives[1].autotune = IDE_TUNE_AUTO;
>  	hwif->host_flags = IDE_HFLAG_SET_PIO_MODE_KEEP_DMA |
> +			   IDE_HFLAG_PIO_NO_DOWNGRADE |
>  			   IDE_HFLAG_POST_SET_MODE;
>  	hwif->pio_mask = ATA_PIO4;
>  	hwif->set_pio_mode = pmac_ide_set_pio_mode;

