From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [-mm patch] cleanup drivers/ata/Kconfig
Date: Sun, 13 Aug 2006 23:46:19 +0100
Message-ID: <1155509179.24077.172.camel@localhost.localdomain>
References: <20060813012454.f1d52189.akpm@osdl.org>
	 <20060813210106.GO3543@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45280 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751682AbWHMW2G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Aug 2006 18:28:06 -0400
In-Reply-To: <20060813210106.GO3543@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Ar Sul, 2006-08-13 am 23:01 +0200, ysgrifennodd Adrian Bunk:
> One issue I noticed while creating this patch is that for the following 
> options the dependency and the prompt don't agree whether the option
> is EXPERIMENTAL:
> - SATA_SX4
> - PATA_AMD
> - PATA_HPT3X3
> - PATA_SC1200

HPT3x3, SC1200 are experimental
AMD is not intended to be any more.

Thanks for spotting these.

>  config ATA_JMICRON
>  	tristate "JMicron non-AHCI support (Experimental)"
> -	depends on ATA && PCI && EXPERIMENTAL
> +	depends on PCI && EXPERIMENTAL
>  	help
>  	  This option enables support for Jmicron ATA controllers
>  	  ports running in non-AHCI mode. Where possible you should
>  	  set the configuration for AHCI to get better performance

Actually I should mark this as non-experimental too but I'll do that and
push it the proper path.

>  config PATA_LEGACY
>  	tristate "Legacy ISA PATA support (Experimental)"
> -	depends on ATA && PCI && EXPERIMENTAL
> +	depends on PCI && EXPERIMENTAL

My fault I suspect - shouldn't have been && PCI originally



Acked-by: Alan Cox <alan@redhat.com>

