From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] drivers/ata/Kconfig: PATA_SCC depends on wrong platform
Date: Mon, 19 Mar 2007 12:04:13 -0400
Message-ID: <45FEB47D.1090906@garzik.org>
References: <200703150530.l2F5Uwel024855@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53771 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030300AbXCSQER (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 12:04:17 -0400
In-Reply-To: <200703150530.l2F5Uwel024855@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp

Akira Iguchi wrote:
> PATA_SCC depends on PPC_CELLEB. (not PPC_IBM_CELL_BLADE)
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
> ---
> 
> diff -Nrpu -X linux-2.6.21-rc3/Documentation/dontdiff linux-2.6.21-rc3/drivers/ata/Kconfig linux-2.6.21-rc3.mod/drivers/ata/Kconfig
> --- linux-2.6.21-rc3/drivers/ata/Kconfig	2007-03-07 13:41:20.000000000 +0900
> +++ linux-2.6.21-rc3.mod/drivers/ata/Kconfig	2007-03-15 23:04:14.000000000 +0900
> @@ -564,7 +564,7 @@ config PATA_IXP4XX_CF
>  
>  config PATA_SCC
>  	tristate "Toshiba's Cell Reference Set IDE support"
> -	depends on PCI && PPC_IBM_CELL_BLADE
> +	depends on PCI && PPC_CELLEB
>  	help
>  	  This option enables support for the built-in IDE controller on

aplied


