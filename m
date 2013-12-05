From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 3/5] SATA: MV: Add support for the optional PHYs
Date: Thu, 5 Dec 2013 11:45:32 +0530
Message-ID: <52A01A04.7040306@ti.com>
References: <1386177364-10164-1-git-send-email-andrew@lunn.ch> <1386177364-10164-4-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43163 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab3LEGPm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Dec 2013 01:15:42 -0500
In-Reply-To: <1386177364-10164-4-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

Hi,

On Wednesday 04 December 2013 10:46 PM, Andrew Lunn wrote:
> Some Marvell SoCs have a SATA PHY which can be powered off, in order
> to save power. Make use of the generic phy framework to control these
> phys.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/ata/sata_mv.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 56be31819897..9a728bcfbb9a 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -60,6 +60,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/device.h>
>  #include <linux/clk.h>
> +#include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/ata_platform.h>
>  #include <linux/mbus.h>
> @@ -563,6 +564,12 @@ struct mv_host_priv {
>  	struct clk		*clk;
>  	struct clk              **port_clks;
>  	/*
> +	 * Some devices have a SATA PHY which can be enabled/disabled
> +	 * in order to save power. These are optional: if the platform
> +	 * devices does not have any phy, they won't be used.
> +	 */
> +	struct phy		**port_phys;
> +	/*
>  	 * These consistent DMA memory pools give us guaranteed
>  	 * alignment for hardware-accessed data structures,
>  	 * and less memory waste in accomplishing the alignment.
> @@ -4076,6 +4083,11 @@ static int mv_platform_probe(struct platform_device *pdev)
>  					GFP_KERNEL);
>  	if (!hpriv->port_clks)
>  		return -ENOMEM;
> +	hpriv->port_phys = devm_kzalloc(&pdev->dev,
> +					sizeof(struct phy *) * n_ports,
> +					GFP_KERNEL);
> +	if (!hpriv->port_phys)
> +		return -ENOMEM;
>  	host->private_data = hpriv;
>  	hpriv->n_ports = n_ports;
>  	hpriv->board_idx = chip_soc;
> @@ -4097,6 +4109,9 @@ static int mv_platform_probe(struct platform_device *pdev)
>  		hpriv->port_clks[port] = clk_get(&pdev->dev, port_number);
>  		if (!IS_ERR(hpriv->port_clks[port]))
>  			clk_prepare_enable(hpriv->port_clks[port]);
> +		hpriv->port_phys[port] = devm_phy_get(&pdev->dev, port_number);

once you change the phy-names in dt data, corresponding change should be done
here too.
> +		if (!IS_ERR(hpriv->port_phys[port]))
> +			phy_power_on(hpriv->port_phys[port]);
>  	}
>  
>  	/*
> @@ -4132,6 +4147,8 @@ err:
>  			clk_disable_unprepare(hpriv->port_clks[port]);
>  			clk_put(hpriv->port_clks[port]);
>  		}
> +		if (!IS_ERR(hpriv->port_phys[port]))
> +			phy_power_off(hpriv->port_phys[port]);
>  	}
>  
>  	return rc;
> @@ -4161,6 +4178,8 @@ static int mv_platform_remove(struct platform_device *pdev)
>  			clk_disable_unprepare(hpriv->port_clks[port]);
>  			clk_put(hpriv->port_clks[port]);
>  		}
> +		if (!IS_ERR(hpriv->port_phys[port]))
> +			phy_power_off(hpriv->port_phys[port]);
>  	}
>  	return 0;
>  }
> 
Apart from that comment this patch looks good.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
