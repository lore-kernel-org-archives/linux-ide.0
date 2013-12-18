From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 3/4] SATA: MV: Add support for the optional PHYs
Date: Wed, 18 Dec 2013 12:00:10 +0530
Message-ID: <52B140F2.8070900@ti.com>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
 <1387311713-1926-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1387311713-1926-3-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tejun Heo <tj@kernel.org>
Cc: Gregory Clement <gregory.clement@free-electrons.com>, devicetree@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Tejun,

On Wednesday 18 December 2013 01:51 AM, Andrew Lunn wrote:
> Some Marvell SoCs have a SATA PHY which can be powered off, in order
> to save power. Make use of the generic phy framework to control these
> phys.

I can queue this patch along with the other patches in this series if you don't
expect any merge issues. If you want to take this patch by yourself, you can add my
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Either ways let me know.

Cheers
Kishon

> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2->v3
> Look for phys using name "port0", "port1", etc.
> ---
>  drivers/ata/sata_mv.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 56be31819897..896725bb5e34 100644
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
> @@ -4097,6 +4109,10 @@ static int mv_platform_probe(struct platform_device *pdev)
>  		hpriv->port_clks[port] = clk_get(&pdev->dev, port_number);
>  		if (!IS_ERR(hpriv->port_clks[port]))
>  			clk_prepare_enable(hpriv->port_clks[port]);
> +		sprintf(port_number, "port%d", port);
> +		hpriv->port_phys[port] = devm_phy_get(&pdev->dev, port_number);
> +		if (!IS_ERR(hpriv->port_phys[port]))
> +			phy_power_on(hpriv->port_phys[port]);
>  	}
>  
>  	/*
> @@ -4132,6 +4148,8 @@ err:
>  			clk_disable_unprepare(hpriv->port_clks[port]);
>  			clk_put(hpriv->port_clks[port]);
>  		}
> +		if (!IS_ERR(hpriv->port_phys[port]))
> +			phy_power_off(hpriv->port_phys[port]);
>  	}
>  
>  	return rc;
> @@ -4161,6 +4179,8 @@ static int mv_platform_remove(struct platform_device *pdev)
>  			clk_disable_unprepare(hpriv->port_clks[port]);
>  			clk_put(hpriv->port_clks[port]);
>  		}
> +		if (!IS_ERR(hpriv->port_phys[port]))
> +			phy_power_off(hpriv->port_phys[port]);
>  	}
>  	return 0;
>  }
> 
