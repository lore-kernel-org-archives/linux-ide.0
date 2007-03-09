From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_mpc52xx: Cable detect
Date: Fri, 09 Mar 2007 07:25:34 -0500
Message-ID: <45F1523E.70603@pobox.com>
References: <20070307162005.197d4cc4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55408 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422959AbXCIMZg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:25:36 -0500
In-Reply-To: <20070307162005.197d4cc4@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_mpc52xx.c linux-2.6.21-rc2-mm2/drivers/ata/pata_mpc52xx.c
> --- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/pata_mpc52xx.c	2007-03-06 23:09:46.000000000 +0000
> +++ linux-2.6.21-rc2-mm2/drivers/ata/pata_mpc52xx.c	2007-03-06 23:35:28.000000000 +0000
> @@ -24,7 +24,7 @@
>  
>  
>  #define DRV_NAME	"mpc52xx_ata"
> -#define DRV_VERSION	"0.1.0"
> +#define DRV_VERSION	"0.1.0ac2"
>  
>  
>  /* Private structures used by the driver */
> @@ -297,6 +297,7 @@
>  	.freeze			= ata_bmdma_freeze,
>  	.thaw			= ata_bmdma_thaw,
>  	.error_handler		= mpc52xx_ata_error_handler,
> +	.cable_detect		= ata_cable_40wire,
>  	.qc_prep		= ata_qc_prep,
>  	.qc_issue		= ata_qc_issue_prot,
>  	.data_xfer		= ata_data_xfer,

applied, as part of a jumbo ->cable_detect patch, since this patch 
contained changes highly similar to others it was applied alongside.


