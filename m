From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/6] ide: remove chipset type fixup from ide_host_register()
Date: Thu, 13 Nov 2008 01:50:12 +0300
Message-ID: <491B5DA4.3020405@ru.mvista.com>
References: <200811122215.15671.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:4197 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752469AbYKLWuT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Nov 2008 17:50:19 -0500
In-Reply-To: <200811122215.15671.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Set chipset type explicitly in tx4938ide and tx4939ide host drivers
>   (all other host drivers were updated already).
>
> * Remove no longer used chipset type fixup from ide_host_register().
>
> CC: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   
[...]
> Index: b/drivers/ide/tx4938ide.c
> ===================================================================
> --- a/drivers/ide/tx4938ide.c
> +++ b/drivers/ide/tx4938ide.c
> @@ -226,6 +226,7 @@ static const struct ide_port_info tx4938
>  #endif
>  	.host_flags		= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
>  	.pio_mask		= ATA_PIO5,
> +	.chipset		= ide_generic,
>  };
>  
>  static int __init tx4938ide_probe(struct platform_device *pdev)
> Index: b/drivers/ide/tx4939ide.c
> ===================================================================
> --- a/drivers/ide/tx4939ide.c
> +++ b/drivers/ide/tx4939ide.c
> @@ -644,6 +644,7 @@ static const struct ide_port_info tx4939
>  	.pio_mask		= ATA_PIO4,
>  	.mwdma_mask		= ATA_MWDMA2,
>  	.udma_mask		= ATA_UDMA5,
> +	.chipset		= ide_generic,
>   

   I'm not really sure those are "generic".

MBR, Sergei


