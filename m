From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_cs5536: ATA driver for Geode companion chip
Date: Mon, 15 Oct 2007 15:41:22 -0400
Message-ID: <4713C262.7010401@garzik.org>
References: <yq1y7eahzis.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35094 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069AbXJOTlY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Oct 2007 15:41:24 -0400
In-Reply-To: <yq1y7eahzis.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, jordan.crouse@amd.com

Martin K. Petersen wrote:
> This is a driver for the ATA controller on the Geode CS5536 companion
> chip.  The PCI device ID for this device was previously claimed by
> pata_amd.c but the PIO timings were not correct.  This driver also
> works around a bug in some BIOSes that handle unaligned access to the
> PCI config registers poorly.  Finally, the driver allows fallback to
> using MSR registers for configuration on BIOSes that are truly
> broken.
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> ---
> 
> diff -r 79f0ea1e0e70 drivers/ata/Kconfig
> --- a/drivers/ata/Kconfig	Tue Oct 09 21:00:40 2007 +0000
> +++ b/drivers/ata/Kconfig	Thu Oct 11 03:26:40 2007 -0400
> @@ -254,6 +254,15 @@ config PATA_CS5535
>  
>  	  If unsure, say N.
>  
> +config PATA_CS5536
> +	tristate "CS5536 PATA support (Experimental)"
> +	depends on PCI && X86 && !X86_64 && EXPERIMENTAL
> +	help
> +	  This option enables support for the AMD CS5536
> +	  companion chip used with the Geode LX processor family.
> +
> +	  If unsure, say N.
> +
>  config PATA_CYPRESS
>  	tristate "Cypress CY82C693 PATA support (Very Experimental)"
>  	depends on PCI && EXPERIMENTAL
> diff -r 79f0ea1e0e70 drivers/ata/Makefile
> --- a/drivers/ata/Makefile	Tue Oct 09 21:00:40 2007 +0000
> +++ b/drivers/ata/Makefile	Thu Oct 11 03:26:40 2007 -0400
> @@ -27,6 +27,7 @@ obj-$(CONFIG_PATA_CS5520)	+= pata_cs5520
>  obj-$(CONFIG_PATA_CS5520)	+= pata_cs5520.o
>  obj-$(CONFIG_PATA_CS5530)	+= pata_cs5530.o
>  obj-$(CONFIG_PATA_CS5535)	+= pata_cs5535.o
> +obj-$(CONFIG_PATA_CS5536)	+= pata_cs5536.o
>  obj-$(CONFIG_PATA_CYPRESS)	+= pata_cypress.o
>  obj-$(CONFIG_PATA_EFAR)		+= pata_efar.o
>  obj-$(CONFIG_PATA_HPT366)	+= pata_hpt366.o
> diff -r 79f0ea1e0e70 drivers/ata/pata_amd.c
> --- a/drivers/ata/pata_amd.c	Tue Oct 09 21:00:40 2007 +0000
> +++ b/drivers/ata/pata_amd.c	Thu Oct 11 03:26:40 2007 -0400
> @@ -693,7 +693,10 @@ static const struct pci_device_id amd[] 
>  	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE),	8 },
>  	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE),	8 },
>  	{ PCI_VDEVICE(NVIDIA,	PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE),	8 },
> +/* Temporary */
> +#if !defined(CONFIG_PATA_CS5536) && !defined(CONFIG_PATA_CS5536_MODULE)
>  	{ PCI_VDEVICE(AMD,	PCI_DEVICE_ID_AMD_CS5536_IDE),		9 },
> +#endif
>  
>  	{ },
>  };

applied, after removing the pata_amd patch

I don't typically apply things marked temporary :) but moreover, this is 
a bit unusual to do in a driver.  Any opinions on simply removing the 
PCI ID?  what's the installed base like today?  do we need to keep the 
PCI ID in both drivers?


