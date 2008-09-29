From: Jeff Garzik <jeff@garzik.org>
Subject: Re: PATA: RPC now selects HAVE_PATA_PLATFORM for pata platform driver
Date: Mon, 29 Sep 2008 00:33:57 -0400
Message-ID: <48E05AB5.8070106@garzik.org>
References: <20080926171251.731613895@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40923 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbYI2EeB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 00:34:01 -0400
In-Reply-To: <20080926171251.731613895@fluff.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

Ben Dooks wrote:
> The RPC machine type now selects HAVE_PATA_PLATFORM so we can remove
> the special case in the PATA_PLATFORM configuration code.
> 
> Cc: Russell King <rmk@arm.linux.org.uk>
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> Index: linux-2.6.26-rc5-quilt1/drivers/ata/Kconfig
> ===================================================================
> --- linux-2.6.26-rc5-quilt1.orig/drivers/ata/Kconfig	2008-06-10 12:38:03.000000000 +0100
> +++ linux-2.6.26-rc5-quilt1/drivers/ata/Kconfig	2008-06-10 12:38:03.000000000 +0100
> @@ -661,7 +661,7 @@ config HAVE_PATA_PLATFORM
>  
>  config PATA_PLATFORM
>  	tristate "Generic platform device PATA support"
> -	depends on EMBEDDED || ARCH_RPC || PPC || HAVE_PATA_PLATFORM
> +	depends on EMBEDDED || PPC || HAVE_PATA_PLATFORM
>  	help
>  	  This option enables support for generic directly connected ATA
>  	  devices commonly found on embedded systems.

applied


