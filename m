From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 28/30] libata Kconfig: Update the various experimentality
 levels
Date: Tue, 06 Mar 2007 06:50:43 -0500
Message-ID: <45ED5593.6090108@garzik.org>
References: <200703061038.l26AcCtO019550@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53636 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964969AbXCFLup (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 06:50:45 -0500
In-Reply-To: <200703061038.l26AcCtO019550@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

akpm@linux-foundation.org wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/Kconfig |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff -puN drivers/ata/Kconfig~libata-kconfig-update-the-various-experimentality-levels drivers/ata/Kconfig
> --- a/drivers/ata/Kconfig~libata-kconfig-update-the-various-experimentality-levels
> +++ a/drivers/ata/Kconfig
> @@ -193,7 +193,7 @@ config PATA_ALI
>  	  If unsure, say N.
>  
>  config PATA_AMD
> -	tristate "AMD/NVidia PATA support (Experimental)"
> +	tristate "AMD/NVidia PATA support"
>  	depends on PCI
>  	help
>  	  This option enables support for the AMD and NVidia PATA
> @@ -292,7 +292,7 @@ config ATA_GENERIC
>  	  If unsure, say N.
>  
>  config PATA_HPT366
> -	tristate "HPT 366/368 PATA support (Very Experimental)"
> +	tristate "HPT 366/368 PATA support (Experimental)"
>  	depends on PCI && EXPERIMENTAL

Awaiting revision:  CONFIG_EXPERIMENTAL dependencies should match text


