From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 09/64] pata_cmd64x: fix handling of address setup timings
Date: Mon, 18 Jan 2010 21:46:19 +0300
Message-ID: <4B54AC7B.4030903@ru.mvista.com>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171504.14623.11688.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755907Ab0ARSsM@vger.kernel.org>
In-Reply-To: <20100118171504.14623.11688.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_cmd64x: fix handling of address setup timings
>
> Account for the requirements of the DMA mode currently used
> by the pair device.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>  drivers/ata/pata_cmd64x.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> Index: b/drivers/ata/pata_cmd64x.c
> ===================================================================
> --- a/drivers/ata/pata_cmd64x.c
> +++ b/drivers/ata/pata_cmd64x.c
> @@ -165,8 +165,14 @@ static void cmd64x_set_timing(struct ata
>  
>  		if (pair) {
>  			struct ata_timing tp;
> +
>  			ata_timing_compute(pair, pair->pio_mode, &tp, T, 0);
>  			ata_timing_merge(&t, &tp, &t, ATA_TIMING_SETUP);
> +			if (pair->dma_mode) {
> +				ata_timing_compute(pair, pair->dma_mode,
> +						&tp, T, 0);
> +				ata_timing_merge(&tp, &t, &t, ATA_TIMING_SETUP);
>   

   I wonder where Jeff has got the address setup timings for the DMA 
modes...

MBR, Sergei
