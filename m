From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] avoid releasing twice the same region on ide_release_iomio_dma()
Date: Mon, 24 Jul 2006 23:58:05 +0400
Message-ID: <44C5264D.4040609@ru.mvista.com>
References: <20060724193031.GA18463@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:9288 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1751418AbWGXT7V
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 15:59:21 -0400
In-Reply-To: <20060724193031.GA18463@cathedrallabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: linux-ide@vger.kernel.org

Hello.

Aristeu Sergio Rozanski Filho wrote:

> In ide_release_iomio_dma() it's possible to release twice
> hwif->dma_base if hwif->dma_base2 is not null and never releasing
> hwif->dma_base2:
> int ide_release_iomio_dma (ide_hwif_t *hwif)
> {
>         if ((hwif->dma_extra) && (hwif->channel == 0))
>                 release_region((hwif->dma_base + 16), hwif->dma_extra);
>         release_region(hwif->dma_base, 8);
>         if (hwif->dma_base2)
>                 release_region(hwif->dma_base, 8);
>                                      ^^^^^^^^^
>         return 1;
> }
> This patch fixes this typo.

> Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>
> 
> Index: ppc-2.6/drivers/ide/ide-dma.c
> ===================================================================
> --- ppc-2.6.orig/drivers/ide/ide-dma.c	2006-07-24 12:25:20.000000000 -0300
> +++ ppc-2.6/drivers/ide/ide-dma.c	2006-07-24 12:26:26.000000000 -0300
> @@ -802,7 +802,7 @@
>  		release_region((hwif->dma_base + 16), hwif->dma_extra);
>  	release_region(hwif->dma_base, 8);
>  	if (hwif->dma_base2)
> -		release_region(hwif->dma_base, 8);
> +		release_region(hwif->dma_base2, 8);
>  	return 1;
>  }

    dma_base2 should go away altogether -- this is the IDE maintainer's opinion:

http://marc.theaimsgroup.com/?l=linux-ide&m=114345699807546&w=2

    I have posted this patch doing this back in March:

http://marc.theaimsgroup.com/?l=linux-ide&m=114357441529834&w=2

and it was in the -mm tree for some months but has been removed recently -- I 
still need to coordinate it with SGI.

WBR, Sergei
