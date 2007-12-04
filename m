From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 3/4] [POWERPC] MPC8349E-mITX: introduce localbus and
	pata nodes
Date: Tue, 4 Dec 2007 13:16:57 -0600
Message-ID: <20071204191657.GB5758@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain> <20071204170726.GC15599@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:60228 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbXLDTMz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 14:12:55 -0500
Content-Disposition: inline
In-Reply-To: <20071204170726.GC15599@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>, Paul Mundt <lethal@linux-sh.org>

Hi,

On Tue, Dec 04, 2007 at 08:07:26PM +0300, Anton Vorontsov wrote:
> diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
> index 5072f6d..c459b0a 100644
> --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
> @@ -249,6 +249,22 @@
>  		device_type = "pci";
>  	};
>  
> +	localbus@e0005000 {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8349emitx-localbus",
> +			     "fsl,mpc8349e-localbus",
> +			     "fsl,pq2pro-localbus";
> +		reg = <e0005000 d8>;
> +		ranges = <3 0 f0000000 210>;
>  
> -
> +		pata@3,0 {

What's the ,0 for?

> +			compatible = "fsl,mpc8349emitx-pata", "ata-generic";
> +			reg = <3 0 10 3 20c 4>;
> +			reg-shift = <1>;
> +			pio-mode = <6>;
> +			interrupts = <17 8>;
> +			interrupt-parent = <&ipic>;
> +		};
> +	};
>  };
> diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> index aa76819..ea5f176 100644
> --- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
> +++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/seq_file.h>
>  #include <linux/root_dev.h>
> +#include <linux/of_platform.h>
>  
>  #include <asm/system.h>
>  #include <asm/atomic.h>
> @@ -37,6 +38,22 @@
>  
>  #include "mpc83xx.h"
>  
> +static struct of_device_id mpc834x_itx_ids[] = {
> +	{ .name = "localbus", },
> +	{},
> +};

Please add the "compatible" field here (fsl,pq2pro-localbus should do
just fine), instead of the name.

(Sorry for not spotting this sooner)


-Olof

