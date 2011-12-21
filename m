From: Rob Herring <robherring2@gmail.com>
Subject: Re: pata_of_platform.c cannot build on sparc
Date: Wed, 21 Dec 2011 17:25:15 -0600
Message-ID: <4EF26ADB.2040504@gmail.com>
References: <20111221.173810.971054965060472866.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56944 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab1LUXZR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Dec 2011 18:25:17 -0500
Received: by yhr47 with SMTP id 47so5666110yhr.19
        for <linux-ide@vger.kernel.org>; Wed, 21 Dec 2011 15:25:17 -0800 (PST)
In-Reply-To: <20111221.173810.971054965060472866.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: pawel.moll@arm.com, linux-ide@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, jgarzik@redhat.com, rob.herring@calxeda.com

On 12/21/2011 04:38 PM, David Miller wrote:
> 
> It depends upon CONFIG_OF_IRQ which not all CONFIG_OF platforms support,
> in particular sparc does not support CONFIG_OF_PLATFORM because it
> precomputes all IRQs at boot time when it scans the device tree so all
> of the CONFIG_OF_IRQ infrastructure to probe and resolve IRQs at driver
> probe time is wrong and completely unnecessary.
> 
> Add the proper dependencies so that pata_of_platform.c doesn't get
> built on sparc.
> 
> CONFIG_OF_IRQ was severely misdesigned, it should just NOP out on
> platforms where the architecture has the final IRQ values already like
> sparc does.  But that's not how it was implemented at all, and now
> we're starting to have all of these drivers get hard dependencies on
> this mechanism and it's datastructures, and the resulting sparc build
> failures from time to time.
> 
> Jeff, please push something like the following to Linus so that
> sparc's allmodconfig builds again.  Thanks.
> 

Really, drivers should no longer use of_irq_to_resource (or
of_address_to_resource for that matter). The resources are setup by the
core OF code. The patch I sent does this.

Rob

> --------------------
> pata_of_platform: Add missing CONFIG_OF_IRQ dependency.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 6bdedd7..cf047c4 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -820,7 +820,7 @@ config PATA_PLATFORM
>  
>  config PATA_OF_PLATFORM
>  	tristate "OpenFirmware platform device PATA support"
> -	depends on PATA_PLATFORM && OF
> +	depends on PATA_PLATFORM && OF && OF_IRQ
>  	help
>  	  This option enables support for generic directly connected ATA
>  	  devices commonly found on embedded systems with OpenFirmware
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

