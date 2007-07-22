From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/11] ide-pmac: remove pmac_ide_{m,u}dma_enable()
Date: Mon, 23 Jul 2007 09:47:33 +1000
Message-ID: <1185148054.5439.77.camel@localhost.localdomain>
References: <200707222024.14736.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:37210 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754885AbXGVXrk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jul 2007 19:47:40 -0400
In-Reply-To: <200707222024.14736.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org


>  static int
>  pmac_ide_dma_check(ide_drive_t *drive)
>  {
> -	struct hd_driveid *id = drive->id;

Actually, this one breaks compile, "id" is used a bit further below in
that function.

Cheers,
Ben.

> -	ide_hwif_t *hwif = HWIF(drive);
> -	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)hwif->hwif_data;
>  	int enable = 1;
> -	int map;
>  	drive->using_dma = 0;
>  	
>  	if (drive->media == ide_floppy)
> @@ -1780,13 +1688,8 @@ pmac_ide_dma_check(ide_drive_t *drive)
>  	if (enable) {
>  		u8 mode = ide_max_dma_mode(drive);
>  
> -		if (mode >= XFER_UDMA_0)
> -			drive->using_dma = pmac_ide_udma_enable(drive, mode);
> -		else if (mode >= XFER_MW_DMA_0)
> -			drive->using_dma = pmac_ide_mdma_enable(drive, mode);
> -
> -		/* Apply settings to controller */
> -		pmac_ide_do_update_timings(drive);
> +		if (mode && pmac_ide_tune_chipset(drive, mode) == 0)
> +			drive->using_dma = 1;
>  	}
>  	return 0;
>  }

