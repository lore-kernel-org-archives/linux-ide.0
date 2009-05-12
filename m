From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: libata depends on HAS_DMA
Date: Mon, 11 May 2009 20:58:40 -0400
Message-ID: <4A08C9C0.6040202@pobox.com>
References: <20090511222702.352192505@arndb.de>> <200905112238.55404.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50366 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756784AbZELA6n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 May 2009 20:58:43 -0400
In-Reply-To: <200905112238.55404.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Arnd Bergmann wrote:
> libata uses the DMA mapping API, so it cannot be built
> on architectures that don't have DMA support.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/ata/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 9120717..f076268 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -4,7 +4,7 @@
>  
>  menuconfig ATA
>  	tristate "Serial ATA (prod) and Parallel ATA (experimental) drivers"
> -	depends on HAS_IOMEM
> +	depends on HAS_IOMEM && HAS_DMA
>  	depends on BLOCK
>  	depends on !(M32R || M68K) || BROKEN

What specifically is breaking?

Ideally we should be able to work with PIO-only...

	JEff




