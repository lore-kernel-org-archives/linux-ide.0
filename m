From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] winbond IDE depends on IDEDMA
Date: Thu, 30 Nov 2006 18:26:19 +0100
Message-ID: <58cb370e0611300926k61bd806ahdbf6e5f399729f5a@mail.gmail.com>
References: <20061130143803.GA22451@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:64430 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030835AbWK3R0U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Nov 2006 12:26:20 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2181728uga
        for <linux-ide@vger.kernel.org>; Thu, 30 Nov 2006 09:26:19 -0800 (PST)
In-Reply-To: <20061130143803.GA22451@aepfle.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On 11/30/06, Olaf Hering <olaf@aepfle.de> wrote:
>
> winbond ide depends on idedma.
>
> drivers/built-in.o: In function `.sl82c105_ide_dma_timeout':
> sl82c105.c:(.text+0x624d0): undefined reference to `.__ide_dma_timeout'
> drivers/built-in.o: In function `.sl82c105_ide_dma_off_quietly':
> sl82c105.c:(.text+0x6274c): undefined reference to `.__ide_dma_off_quietly'
> drivers/built-in.o: In function `.sl82c105_ide_dma_on':
> sl82c105.c:(.text+0x6284c): undefined reference to `.__ide_dma_on'
> drivers/built-in.o: In function `.sl82c105_check_drive':
> sl82c105.c:(.text+0x628ec): undefined reference to `.__ide_dma_bad_drive'
> sl82c105.c:(.text+0x62934): undefined reference to `.__ide_dma_good_drive'
> drivers/built-in.o: In function `.sl82c105_ide_dma_start':
> sl82c105.c:(.text+0x62c24): undefined reference to `.ide_dma_start'
> make[1]: *** [.tmp_vmlinux1] Error 1
>
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
>
> ---
>  drivers/ide/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-2.6.19/drivers/ide/Kconfig
> ===================================================================
> --- linux-2.6.19.orig/drivers/ide/Kconfig
> +++ linux-2.6.19/drivers/ide/Kconfig
> @@ -391,7 +391,7 @@ config BLK_DEV_RZ1000
>
>  config BLK_DEV_SL82C105
>         tristate "Winbond SL82c105 support"
> -       depends on PCI && (PPC || ARM) && BLK_DEV_IDEPCI
> +       depends on PCI && (PPC || ARM) && BLK_DEV_IDEPCI && BLK_DEV_IDEDMA_PCI
>         help
>           If you have a Winbond SL82c105 IDE controller, say Y here to enable
>           special configuration for this chip. This is common on various CHRP
