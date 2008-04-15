From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [patch 2/2] ARM/RPC: Use HAVE_PATA_PLATFORM to select pata platform driver
Date: Tue, 15 Apr 2008 20:56:50 +0100
Message-ID: <20080415195650.GA32097@flint.arm.linux.org.uk>
References: <20080415144325.363175912@fluff.org.uk> <20080415144512.009318607@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37189 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbYDOT5O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2008 15:57:14 -0400
Content-Disposition: inline
In-Reply-To: <20080415144512.009318607@fluff.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Linux IDE List <linux-ide@vger.kernel.org>, Linux ARM Kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Tue, Apr 15, 2008 at 03:43:27PM +0100, Ben Dooks wrote:
> Use HAVE_PATA_PLATFORM for ARCH_RPC 
> 
> Cc: Linux ARM Kernel <linux-arm-kernel@lists.arm.linux.org.uk>
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> PATCH FOLLOWS
> KernelVersion: 2.6.24-git12
> 
> Index: linux-2.6.25-rc9-ata1/arch/arm/Kconfig
> ===================================================================
> --- linux-2.6.25-rc9-ata1.orig/arch/arm/Kconfig	2008-04-15 12:10:02.000000000 +0100
> +++ linux-2.6.25-rc9-ata1/arch/arm/Kconfig	2008-04-15 15:27:53.000000000 +0100
> @@ -411,6 +411,7 @@ config ARCH_RPC
>  	select FIQ
>  	select TIMER_ACORN
>  	select ARCH_MAY_HAVE_PC_FDC
> +	select HAVE_PATA_PLATFORM
>  	select ISA_DMA_API
>  	select NO_IOPORT
>  	select HAVE_IDE
> Index: linux-2.6.25-rc9-ata1/drivers/ata/Kconfig
> ===================================================================
> --- linux-2.6.25-rc9-ata1.orig/drivers/ata/Kconfig	2008-04-15 15:27:48.000000000 +0100
> +++ linux-2.6.25-rc9-ata1/drivers/ata/Kconfig	2008-04-15 15:27:53.000000000 +0100
> @@ -634,7 +634,7 @@ config HAVE_PATA_PLATFORM
>  
>  config PATA_PLATFORM
>  	tristate "Generic platform device PATA support"
> -	depends on EMBEDDED || ARCH_RPC || PPC || HAVE_PATA_PLATFORM
> +	depends on EMBEDDED || PPC || HAVE_PATA_PLATFORM
>  	help
>  	  This option enables support for generic directly connected ATA
>  	  devices commonly found on embedded systems.
> 
> -- 
> Ben (ben@fluff.org, http://www.fluff.org/)
> 
>   'a smiley only costs 4 bytes'
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
