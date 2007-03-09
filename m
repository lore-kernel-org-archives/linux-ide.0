From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_oldpiix: cable detect
Date: Fri, 09 Mar 2007 07:26:58 -0500
Message-ID: <45F15292.8000306@pobox.com>
References: <20070307162303.01620a7b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55439 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767206AbXCIM1B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:27:01 -0500
In-Reply-To: <20070307162303.01620a7b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_oldpiix.c linux-2.6.21-rc2-mm2/drivers/ata/pata_oldpiix.c
> --- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_oldpiix.c	2007-03-06 23:09:46.000000000 +0000
> +++ linux-2.6.21-rc2-mm2/drivers/ata/pata_oldpiix.c	2007-03-06 23:36:02.000000000 +0000
> @@ -25,7 +25,7 @@
>  #include <linux/ata.h>
>  
>  #define DRV_NAME	"pata_oldpiix"
> -#define DRV_VERSION	"0.5.4"
> +#define DRV_VERSION	"0.5.5"
>  
>  /**
>   *	oldpiix_pre_reset		-	probe begin
> @@ -44,7 +44,6 @@
>  
>  	if (!pci_test_config_bits(pdev, &oldpiix_enable_bits[ap->port_no]))
>  		return -ENOENT;
> -	ap->cbl = ATA_CBL_PATA40;
>  	return ata_std_prereset(ap);
>  }
>  
> @@ -65,7 +64,7 @@
>  /**
>   *	oldpiix_set_piomode - Initialize host controller PATA PIO timings
>   *	@ap: Port whose timings we are configuring
> - *	@adev: um
> + *	@adev: Device whose timings we are configuring
>   *
>   *	Set PIO mode for device, in host controller PCI config space.
>   *
> @@ -255,6 +254,7 @@
>  	.thaw			= ata_bmdma_thaw,
>  	.error_handler		= oldpiix_pata_error_handler,
>  	.post_internal_cmd 	= ata_bmdma_post_internal_cmd,
> +	.cable_detect		= ata_cable_40wire,
>  
>  	.bmdma_setup		= ata_bmdma_setup,
>  	.bmdma_start		= ata_bmdma_start,

applied, as part of a jumbo ->cable_detect patch, since this patch 
contained changes highly similar to others it was applied alongside.

and ditto for the following ->cable_detect patches sent on 03/07/2007: 
pata_opti, pata_pcmcia, pata_pdc202xx_old, pata_sil680, pata_triflex, 
sata_via, pata_serverworks


