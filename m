From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_via: Add Armia W730-K8 and other rebadgings
Date: Thu, 23 Aug 2007 05:32:42 -0400
Message-ID: <46CD543A.1030103@garzik.org>
References: <20070822225748.65c7d7e6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48558 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758709AbXHWJcp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Aug 2007 05:32:45 -0400
In-Reply-To: <20070822225748.65c7d7e6@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> More cable funnies
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_via.c linux-2.6.23rc3-mm1/drivers/ata/pata_via.c
> --- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_via.c	2007-08-22 17:23:00.000000000 +0100
> +++ linux-2.6.23rc3-mm1/drivers/ata/pata_via.c	2007-08-22 17:46:53.000000000 +0100
> @@ -63,7 +63,7 @@
>  #include <linux/dmi.h>
>  
>  #define DRV_NAME "pata_via"
> -#define DRV_VERSION "0.3.1"
> +#define DRV_VERSION "0.3.2"
>  
>  /*
>   *	The following comes directly from Vojtech Pavlik's ide/pci/via82cxxx
> @@ -144,6 +144,9 @@
>  	/* Systems by DMI */
>  	if (dmi_check_system(cable_dmi_table))
>  		return 1;
> +	/* Armia W730-K8/Targa Visionary 811/... */
> +	if (pdev->subsystem_vendor == 0x161F && pdev->subsystem_device == 0x2032)
> +		return 1;
>  	return 0;

applied with s/Armia/Arima/ as Mikael suggested


