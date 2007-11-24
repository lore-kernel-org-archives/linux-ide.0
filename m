From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_hpt37x: Fix cable detect bug spotted by Sergei
Date: Fri, 23 Nov 2007 19:36:09 -0500
Message-ID: <474771F9.1000507@garzik.org>
References: <20071119143913.078738ed@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34164 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbXKXAgN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 19:36:13 -0500
In-Reply-To: <20071119143913.078738ed@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_hpt37x.c linux-2.6.24-rc2-mm1/drivers/ata/pata_hpt37x.c
> --- linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_hpt37x.c	2007-11-16 17:55:11.000000000 +0000
> +++ linux-2.6.24-rc2-mm1/drivers/ata/pata_hpt37x.c	2007-11-16 18:14:19.000000000 +0000
> @@ -329,7 +329,7 @@
>  	/* Restore state */
>  	pci_write_config_byte(pdev, 0x5B, scr2);
>  
> -	if (ata66 & (1 << ap->port_no))
> +	if (ata66 & (2 >> ap->port_no))
>  		ap->cbl = ATA_CBL_PATA40;

applied #upstream-fixes


