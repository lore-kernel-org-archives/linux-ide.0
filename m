From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/5] pata_sis: Implement MWDMA for the UDMA 133 capable chips
Date: Tue, 17 Nov 2009 18:27:29 +0100
Message-ID: <200911171827.29891.bzolnier@gmail.com>
References: <20091117144450.15430.83450.stgit@localhost.localdomain> <20091117145111.15430.67106.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43221 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbZKQR2i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Nov 2009 12:28:38 -0500
In-Reply-To: <20091117145111.15430.67106.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 17 November 2009 15:51:17 Alan Cox wrote:
> Bartlomiej pointed out that while this got fixed in the old driver whoever
> did it didn't port it across.

Please add ',' before 'whoever' and change 'the old driver' to 'sis5513'
so it is at least passable as 'information manipulation' on what I really
said instead of just being a 'straight lie'..  Thanks!

> +/**
> + *	mwdma_clip_to_pio		-	clip MWDMA mode
> + *	@adev: device
> + *
> + *	As the SiS shared MWDMA and PIO timings we must program the equivalent
> + *	PIO timing for the MWDMA mode but we must not program one higher than
> + *	the permitted PIO timing of the device.
> + */
> +
> +static int mwdma_clip_to_pio(struct ata_device *adev)
> +{
> +	const int mwdma_to_pio[3] = {
> +		XFER_PIO_0, XFER_PIO_3, XFER_PIO_4
> +	};
> +	return min(mwdma_to_pio[adev->dma_mode - XFER_MW_DMA_0],
> +				adev->pio_mode - XFER_PIO_0);
> +}

This wants to be in the generic libata code.

-- 
Bartlomiej Zolnierkiewicz
