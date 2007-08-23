From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] pata_via: Add Armia W730-K8 and other rebadgings
Date: Thu, 23 Aug 2007 10:04:37 +0200 (MEST)
Message-ID: <200708230804.l7N84bmk005429@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:50119 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755311AbXHWIEy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Aug 2007 04:04:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, jeff@garzik.org, linux-ide@vger.kernel.org

On Wed, 22 Aug 2007 22:57:48 +0100, Alan Cox wrote:
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
>  }

s/Armia/Arima/

Apart from that it works fine on my '811.

Tested-by: Mikael Pettersson <mikpe@it.uu.se>
