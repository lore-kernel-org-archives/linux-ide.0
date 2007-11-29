From: "Sonic Zhang" <sonic.adi@gmail.com>
Subject: Re: [PATCH] [libata] Set proper ATA UDMA mode for bf548 according to system clock.
Date: Thu, 29 Nov 2007 15:18:24 +0800
Message-ID: <4e5ebad50711282318k3d99d0cei42b97d51f8aac7f2@mail.gmail.com>
References: <1196138859.6974.2.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:26170 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbXK2HS0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 02:18:26 -0500
Received: by mu-out-0910.google.com with SMTP id i10so2058627mue
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 23:18:24 -0800 (PST)
In-Reply-To: <1196138859.6974.2.camel@eight.analog.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Any comment?

Thanks

Sonic

On Nov 27, 2007 12:47 PM, sonic zhang <sonic.adi@gmail.com> wrote:
> UDMA Mode - Frequency compatibility
>
> UDMA5 - 100 MB/s   - SCLK  = 133 MHz
> UDMA4 - 66 MB/s    - SCLK >=  80 MHz
> UDMA3 - 44.4 MB/s  - SCLK >=  50 MHz
> UDMA2 - 33 MB/s    - SCLK >=  40 MHz
>
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  drivers/ata/pata_bf54x.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
> index 81db405..088a41f 100644
> --- a/drivers/ata/pata_bf54x.c
> +++ b/drivers/ata/pata_bf54x.c
> @@ -1489,6 +1489,8 @@ static int __devinit bfin_atapi_probe(st
>         int board_idx = 0;
>         struct resource *res;
>         struct ata_host *host;
> +       unsigned int fsclk = get_sclk();
> +       int udma_mode = 5;
>         const struct ata_port_info *ppi[] =
>                 { &bfin_port_info[board_idx], NULL };
>
> @@ -1507,6 +1509,11 @@ static int __devinit bfin_atapi_probe(st
>         if (res == NULL)
>                 return -EINVAL;
>
> +       while (bfin_port_info[board_idx].udma_mask>0 && udma_fsclk[udma_mode] > fsclk) {
> +               udma_mode--;
> +               bfin_port_info[board_idx].udma_mask >>= 1;
> +       }
> +
>         /*
>          * Now that that's out of the way, wire up the port..
>          */
> --
> 1.4.3.4
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
