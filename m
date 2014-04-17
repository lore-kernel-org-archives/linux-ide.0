From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH RFC 2/5] ata: ahci_imx: avoid reprobing ahci_imx driver
 when using DT
Date: Thu, 17 Apr 2014 16:45:44 +0800
Message-ID: <20140417084543.GB22160@dragon>
References: <20140416084227.GD24070@n2100.arm.linux.org.uk>
 <E1WaLRK-0002yJ-T1@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:38554
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755107AbaDQIp4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Apr 2014 04:45:56 -0400
Content-Disposition: inline
In-Reply-To: <E1WaLRK-0002yJ-T1@rmk-PC.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Wed, Apr 16, 2014 at 09:43:30AM +0100, Russell King wrote:
> Avoid matching our child platform device, which can happen as we copy the
> DT node to the child device.  This allows the child platform device to be
> matched against the ahci-imx driver and should this happen, it will cause
> another platform device to be allocated, resulting in failure.

This is not the case anymore, since commit 90870d7 (ahci-imx: Port to
library-ised ahci_platform) is merged into v3.15-rc1.

Shawn

> 
> Ideally, we shouldn't be copying the of_node, but this is unavoidable as
> prevents ahci_platform() obtaining its resources.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/ata/ahci_imx.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 6a56a561a80b..26ee412127b3 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -213,6 +213,10 @@ static int imx_ahci_probe(struct platform_device *pdev)
>  	unsigned int reg_val;
>  	int ret;
>  
> +	/* Prevent our child ahci device coming back to us */
> +	if (!strcmp(dev_name(&pdev->dev), "ahci"))
> +		return -ENODEV;
> +
>  	of_id = of_match_device(imx_ahci_of_match, dev);
>  	if (!of_id)
>  		return -EINVAL;
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 

