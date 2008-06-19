From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch 1/2] LIBATA: Add HAVE_PATA_PLATFORM to select PATA_PLATFORM
 driver
Date: Wed, 18 Jun 2008 20:30:07 -0400
Message-ID: <4859A88F.5030709@pobox.com>
References: <20080616111625.145158959@fluff.org.uk> <20080616112452.786570267@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58760 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757627AbYFSAaK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 20:30:10 -0400
In-Reply-To: <20080616112452.786570267@fluff.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Ben Dooks wrote:
> Add HAVE_PATA_PLATFORM to select the pata platform driver
> to ensure that we do not end up with a long 'depends on' list
> when other users of this driver turn up.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> Index: linux-2.6.26-rc3-quilt1/drivers/ata/Kconfig
> ===================================================================
> --- linux-2.6.26-rc3-quilt1.orig/drivers/ata/Kconfig	2008-05-19 23:04:01.000000000 +0100
> +++ linux-2.6.26-rc3-quilt1/drivers/ata/Kconfig	2008-05-19 23:39:47.000000000 +0100
> @@ -651,9 +651,17 @@ config PATA_WINBOND_VLB
>  	  Support for the Winbond W83759A controller on Vesa Local Bus
>  	  systems.
>  
> +config HAVE_PATA_PLATFORM
> +	bool
> +	help
> +	  This is an internal configuration node for any machine that
> +	  uses pata-platform driver to enable the relevant driver in the
> +	  configuration structure without having to submit endless patches
> +	  to update the PATA_PLATFORM entry.
> +
>  config PATA_PLATFORM
>  	tristate "Generic platform device PATA support"
> -	depends on EMBEDDED || ARCH_RPC || PPC
> +	depends on EMBEDDED || ARCH_RPC || PPC || HAVE_PATA_PLATFORM
>  	help

applied


