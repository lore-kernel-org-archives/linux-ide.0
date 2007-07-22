From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/11] ide-pmac: remove control register messing from
	pmac_ide_dma_check()
Date: Mon, 23 Jul 2007 07:58:33 +1000
Message-ID: <1185141513.5439.65.camel@localhost.localdomain>
References: <200707222023.29972.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48318 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764700AbXGVV6i (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jul 2007 17:58:38 -0400
In-Reply-To: <200707222023.29972.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 2007-07-22 at 20:23 +0200, Bartlomiej Zolnierkiewicz wrote:
> pmac_ide_do_setfeature() contains matching nIEN setting/clearing so this
> Device Control register messing in pmac_ide_dma_check() is totally unnecessary.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

NAK for now. There was a reason for that, I need to remember, but I
think I have a weirdo case with the media-bay removable CD drive on
wallstreet that locks up the bus if you don't do something along the
sequence in there.

I have one of those machines in the office, so I should be able to give
it a go today to check, in the meantime, keep that patch on hold.

Ben.


>  drivers/ide/ppc/pmac.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/drivers/ide/ppc/pmac.c
> ===================================================================
> --- a/drivers/ide/ppc/pmac.c
> +++ b/drivers/ide/ppc/pmac.c
> @@ -1784,7 +1784,7 @@ pmac_ide_dma_check(ide_drive_t *drive)
>  			drive->using_dma = pmac_ide_udma_enable(drive, mode);
>  		else if (mode >= XFER_MW_DMA_0)
>  			drive->using_dma = pmac_ide_mdma_enable(drive, mode);
> -		hwif->OUTB(0, IDE_CONTROL_REG);
> +
>  		/* Apply settings to controller */
>  		pmac_ide_do_update_timings(drive);
>  	}

