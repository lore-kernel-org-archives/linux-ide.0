From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH] ata: dwc: add DMADEVICES dependency
Date: Wed, 11 May 2016 13:57:08 +0100
Message-ID: <yw1xh9e4hhwb.fsf@unicorn.mansr.com>
References: <1462970683-451525-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:34312 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106AbcEKM5R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 May 2016 08:57:17 -0400
In-Reply-To: <1462970683-451525-1-git-send-email-arnd@arndb.de> (Arnd
	Bergmann's message of "Wed, 11 May 2016 14:44:16 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The dwc_460ex SATA driver has become available on non-powerpc archite=
ctures
> and may cause randconfig build errors when CONFIG_DMADEVICES is not s=
et:
>
> warning: (SATA_DWC_OLD_DMA) selects DW_DMAC_CORE which has unmet dire=
ct dependencies (DMADEVICES)
> ERROR: "dw_dma_probe" [drivers/ata/sata_dwc_460ex.ko] undefined!
> ERROR: "dw_dma_remove" [drivers/ata/sata_dwc_460ex.ko] undefined!
>
> This adds an explcit Kconfig dependency so we can only build
> configurations that build without warnings.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 50b433753df6 ("ata: sata_dwc_460ex: use "dmas" DT property to =
find dma channel")
> ---
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 41b0725e58ad..8f7a4a4d2566 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -322,7 +322,7 @@ config SATA_DWC
>
>  config SATA_DWC_OLD_DMA
>  	bool "Support old device trees"
> -	depends on SATA_DWC
> +	depends on SATA_DWC && DMADEVICES
>  	select DW_DMAC_CORE
>  	default y if 460EX
>  	help
> --=20

Isn't the proper fix here to have DW_DMAC_CORE select DMADEVICES?

--=20
M=E5ns Rullg=E5rd
