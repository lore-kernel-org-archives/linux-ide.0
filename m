From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] aec62xx: always tune PIO
Date: Mon, 06 Aug 2007 20:16:49 +0400
Message-ID: <46B74971.6080500@ru.mvista.com>
References: <200708012239.44013.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:10261 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758140AbXHFQOq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 12:14:46 -0400
In-Reply-To: <200708012239.44013.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/pci/aec62xx.c
> ===================================================================
> --- a/drivers/ide/pci/aec62xx.c
> +++ b/drivers/ide/pci/aec62xx.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/ide/pci/aec62xx.c		Version 0.24	May 24, 2007
> + * linux/drivers/ide/pci/aec62xx.c		Version 0.25	Aug 1, 2007
>   *
>   * Copyright (C) 1999-2002	Andre Hedrick <andre@linux-ide.org>
>   * Copyright (C) 2007		MontaVista Software, Inc. <source@mvista.com>
> @@ -207,10 +207,10 @@ static void __devinit init_hwif_aec62xx(
>  	} else
>  		hwif->set_dma_mode = &aec6260_set_mode;
>  
> -	if (!hwif->dma_base) {
> -		hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
> +	hwif->drives[0].autotune = hwif->drives[1].autotune = 1;
> +
> +	if (hwif->dma_base == 0)
>  		return;
> -	}
>  
>  	hwif->ultra_mask = hwif->cds->udma_mask;
>  	hwif->mwdma_mask = 0x07;

    Ugh, I really need to complete the patch de-uglifying the speedproc() 
methods in this driver...

MBR, Sergei
