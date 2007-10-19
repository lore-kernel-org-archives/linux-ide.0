From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] ide/pci/sis5513.c: add missing "else"
Date: Fri, 19 Oct 2007 23:00:57 +0200
Message-ID: <200710192300.58051.bzolnier@gmail.com>
References: <20071019140419.GC3778@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966800AbXJSVZH@vger.kernel.org>
In-Reply-To: <20071019140419.GC3778@stusta.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Friday 19 October 2007, Adrian Bunk wrote:
> This patch adds a missing "else" that was missing in
> commit c77a89cd98d99819f23a4a08e5e17ee1f13f6e4d.
> 
> Spotted by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied, thanks!

> ---
> 2e4b8d4f58ea45e55c87ba5563b0d0e135cac2b4 
> diff --git a/drivers/ide/pci/sis5513.c b/drivers/ide/pci/sis5513.c
> index c1d280b..1680926 100644
> --- a/drivers/ide/pci/sis5513.c
> +++ b/drivers/ide/pci/sis5513.c
> @@ -264,7 +264,7 @@ static void sis_ata133_program_timings(ide_drive_t *drive, const u8 mode)
>  	if (mode >= XFER_MW_DMA_0) {
>  		t1 &= ~0x04;	/* disable UDMA */
>  		idx = mode - XFER_MW_DMA_0 + 5;
> -	}
> +	} else
>  		idx = mode - XFER_PIO_0;
>  	t1 |= ini_time_value[clk][idx] << 12;
>  	t1 |= act_time_value[clk][idx] << 16;
