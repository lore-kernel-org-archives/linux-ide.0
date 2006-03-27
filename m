From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: [2.6 patch] always enable CONFIG_PDC202XX_FORCE
Date: Mon, 27 Mar 2006 18:25:43 +0400
Message-ID: <4427F5E7.1000108@ru.mvista.com>
References: <20060122171239.GD10003@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:5059 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1751023AbWC0O1g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Mar 2006 09:27:36 -0500
In-Reply-To: <20060122171239.GD10003@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello.

Adrian Bunk wrote:

> This patch removes the CONFIG_PDC202XX_FORCE=n case.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

> ---
> 
> This patch was already sent on:
> - 14 Jan 2006
> 
>  drivers/ide/Kconfig            |    7 -------
>  drivers/ide/pci/pdc202xx_new.c |    6 ------
>  drivers/ide/pci/pdc202xx_old.c |   15 ---------------
>  3 files changed, 28 deletions(-)

[skipped]

> --- linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_old.c.old	2006-01-14 20:44:01.000000000 +0100
> +++ linux-2.6.15-mm4-full/drivers/ide/pci/pdc202xx_old.c	2006-01-14 20:44:21.000000000 +0100
> @@ -786,9 +786,6 @@
>  		.init_dma	= init_dma_pdc202xx,
>  		.channels	= 2,
>  		.autodma	= AUTODMA,
> -#ifndef CONFIG_PDC202XX_FORCE
> -		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> -#endif
>  		.bootable	= OFF_BOARD,
>  		.extra		= 16,
>  	},{	/* 1 */
> @@ -799,9 +796,6 @@
>  		.init_dma	= init_dma_pdc202xx,
>  		.channels	= 2,
>  		.autodma	= AUTODMA,
> -#ifndef CONFIG_PDC202XX_FORCE
> -		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> -#endif
>  		.bootable	= OFF_BOARD,
>  		.extra		= 48,
>  		.flags		= IDEPCI_FLAG_FORCE_PDC,

    A late question: wasn't that IDEPCI_FLAG_FORCE_PDC flag there for the same 
purpose -- to bypass enablebits check? Wasn't it enough?

> @@ -813,9 +807,6 @@
>  		.init_dma	= init_dma_pdc202xx,
>  		.channels	= 2,
>  		.autodma	= AUTODMA,
> -#ifndef CONFIG_PDC202XX_FORCE
> -		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> -#endif
>  		.bootable	= OFF_BOARD,
>  		.extra		= 48,
>  	},{	/* 3 */
> @@ -826,9 +817,6 @@
>  		.init_dma	= init_dma_pdc202xx,
>  		.channels	= 2,
>  		.autodma	= AUTODMA,
> -#ifndef CONFIG_PDC202XX_FORCE
> -		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> -#endif
>  		.bootable	= OFF_BOARD,
>  		.extra		= 48,
>  		.flags		= IDEPCI_FLAG_FORCE_PDC,
> @@ -840,9 +828,6 @@
>  		.init_dma	= init_dma_pdc202xx,
>  		.channels	= 2,
>  		.autodma	= AUTODMA,
> -#ifndef CONFIG_PDC202XX_FORCE
> -		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
> -#endif
>  		.bootable	= OFF_BOARD,
>  		.extra		= 48,
>  	}

WBR, Sergei
