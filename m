From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver
 for CF	interface
Date: Wed, 25 Jul 2007 12:29:23 -0500
Message-ID: <46A78873.6010107@freescale.com>
References: <20070725165318.5331.23795.stgit@localhost.localdomain> <20070725165326.5331.19920.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw01.freescale.net ([192.88.158.102]:59105 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529AbXGYR3h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jul 2007 13:29:37 -0400
In-Reply-To: <20070725165326.5331.19920.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org

Vitaly Bordug wrote:
> diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
> index db0d003..f8f0e8a 100644
> --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
> @@ -37,6 +37,15 @@
>  		reg = <00000000 10000000>;
>  	};
>  
> +	ide@f0000000 {
> +		compatible = "mmio-ide";
> +		device_type = "ide";
> +		reg = <f0000000 10 f000020c 4>;
> +		ioport_shift = <1>;
> +		interrupts = <17 8>;
> +		interrupt-parent = < &ipic >;
> +	};
> +

Is this binding documented anywhere?  If it's a new binding, could we 
use reg-shift instead of ioport_shift?  This is what ns16550 uses, and 
in general dashes are preferable to underscores in device trees 
(device_type is an ugly, historical exception).

> diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> index 40a0194..d63a104 100644
> --- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
> +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/seq_file.h>
>  #include <linux/root_dev.h>
> +#include <linux/pata_platform.h>
>  
>  #include <asm/system.h>
>  #include <asm/atomic.h>
> @@ -43,6 +44,75 @@ unsigned long isa_io_base = 0;
>  unsigned long isa_mem_base = 0;
>  #endif
>  
> +static int __init mmio_ide_of_init(void)
> +{
> +	struct device_node *np;
> +	unsigned int i;
> +
> +	for (np = NULL, i = 0;
> +	     (np = of_find_compatible_node(np, "ide", "mmio-ide")) != NULL;
> +	     i++) {
> +		int ret = 0;
> +		struct resource res[3];
> +		struct platform_device *pdev = NULL;
> +		static struct pata_platform_info pdata;

We really don't want code like this for every board with an MMIO IDE 
controller.  At the very least, make it a generic function in sysdev; 
better would be to make the driver also support of_platform devices.

-Scott
