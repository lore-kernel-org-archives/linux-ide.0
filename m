From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_ns87410: cable detect method
Date: Fri, 09 Mar 2007 07:25:49 -0500
Message-ID: <45F1524D.40705@pobox.com>
References: <20070307162207.049af79d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55430 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422959AbXCIMZw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:25:52 -0500
In-Reply-To: <20070307162207.049af79d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_ns87410.c linux-2.6.21-rc2-mm2/drivers/ata/pata_ns87410.c
> --- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_ns87410.c	2007-03-06 23:09:46.000000000 +0000
> +++ linux-2.6.21-rc2-mm2/drivers/ata/pata_ns87410.c	2007-03-06 23:36:02.000000000 +0000
> @@ -28,13 +28,13 @@
>  #include <linux/libata.h>
>  
>  #define DRV_NAME "pata_ns87410"
> -#define DRV_VERSION "0.4.3"
> +#define DRV_VERSION "0.4.6"
>  
>  /**
>   *	ns87410_pre_reset		-	probe begin
>   *	@ap: ATA port
>   *
> - *	Set up cable type and use generic probe init
> + *	Check enabled ports
>   */
>  
>  static int ns87410_pre_reset(struct ata_port *ap)
> @@ -47,7 +47,6 @@
>  
>  	if (!pci_test_config_bits(pdev, &ns87410_enable_bits[ap->port_no]))
>  		return -ENOENT;
> -	ap->cbl = ATA_CBL_PATA40;
>  	return ata_std_prereset(ap);
>  }
>  
> @@ -177,6 +176,7 @@
>  	.thaw		= ata_bmdma_thaw,
>  	.error_handler	= ns87410_error_handler,
>  	.post_internal_cmd = ata_bmdma_post_internal_cmd,
> +	.cable_detect	= ata_cable_40wire,
>  
>  	.qc_prep 	= ata_qc_prep,
>  	.qc_issue	= ns87410_qc_issue_prot,

applied, as part of a jumbo ->cable_detect patch, since this patch 
contained changes highly similar to others it was applied alongside.


