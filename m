From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_acpi: Use ata_sff_port_start
Date: Thu, 20 Sep 2007 15:47:05 -0400
Message-ID: <46F2CE39.6090403@garzik.org>
References: <20070920150415.542a3f49@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39553 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbXITTrL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Sep 2007 15:47:11 -0400
In-Reply-To: <20070920150415.542a3f49@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Purely a stylistic issue currently but best done while I notice it.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc6-mm1/drivers/ata/pata_acpi.c linux-2.6.23rc6-mm1/drivers/ata/pata_acpi.c
> --- linux.vanilla-2.6.23rc6-mm1/drivers/ata/pata_acpi.c	2007-09-18 15:32:51.000000000 +0100
> +++ linux-2.6.23rc6-mm1/drivers/ata/pata_acpi.c	2007-09-18 16:18:12.000000000 +0100
> @@ -270,7 +270,7 @@
>  	acpi->mask[0] = pacpi_discover_modes(ap, &ap->device[0]);
>  	acpi->mask[1] = pacpi_discover_modes(ap, &ap->device[1]);
>  
> -	ret = ata_port_start(ap);
> +	ret = ata_sff_port_start(ap);
>  	if (ret < 0)

I request that somebody send me the pata_acpi driver against 
netdev-2.6.git#upstream as an "add driver" patch, complete with all the 
changes so far rolled into a single patch...


