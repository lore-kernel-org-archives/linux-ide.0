From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/6] pata_sis: Implement MWDMA for the UDMA 133 capable
 chips
Date: Mon, 07 Dec 2009 16:26:00 +0300
Message-ID: <4B1D0268.4090508@ru.mvista.com>
References: <20091130132005.27236.77890.stgit@localhost.localdomain> <20091130132248.27236.35287.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:26809 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1757901AbZLGNYk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 08:24:40 -0500
In-Reply-To: <20091130132248.27236.35287.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org, davem@davemloft.net

Hello.

Alan Cox wrote:

> Bartlomiej pointed out that while this got fixed in the old driver whoever
> did it didn't port it across.

> Signed-off-by: Alan Cox <alan@linux.intel.com>

[...]

> +static int mwdma_clip_to_pio(struct ata_device *adev)
> +{
> +	const int mwdma_to_pio[3] = {
> +		XFER_PIO_0, XFER_PIO_3, XFER_PIO_4
> +	};
> +	return min(mwdma_to_pio[adev->dma_mode - XFER_MW_DMA_0],
> +				adev->pio_mode - XFER_PIO_0);
> +}

    You call min() on uncomparables, i.e. mwdma_to_pio[] contains XFER_PIO_* 
and adev->pio_mode - XFER_PIO_0 yields you a mode number. Thus the second 
argument will always "win" as a minimal one.

MBR, Sergei
