From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 2/3] ata: ahci_platform: Manage SATA PHY
Date: Wed, 8 Jan 2014 15:29:18 +0530
Message-ID: <52CD2176.6050102@ti.com>
References: <1389174428-31414-1-git-send-email-rogerq@ti.com> <1389174428-31414-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389174428-31414-3-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Hi Roger,

On Wednesday 08 January 2014 03:17 PM, Roger Quadros wrote:
> From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> 
> Some platforms have a PHY hooked up to the
> SATA controller. The PHY needs to be initialized
> and powered up for SATA to work. We do that
> using the PHY framework.
> 
> [Roger Q] Cleaned up.
> 
> CC: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/ata/ahci.h          |  2 ++
>  drivers/ata/ahci_platform.c | 28 +++++++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 2289efd..f9bbada 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -37,6 +37,7 @@
>  
>  #include <linux/clk.h>
>  #include <linux/libata.h>
> +#include <linux/phy/phy.h>
>  
>  /* Enclosure Management Control */
>  #define EM_CTRL_MSG_TYPE              0x000f0000
> @@ -322,6 +323,7 @@ struct ahci_host_priv {
>  	u32			em_buf_sz;	/* EM buffer size in byte */
>  	u32			em_msg_type;	/* EM message type */
>  	struct clk		*clk;		/* Only for platforms supporting clk */
> +	struct phy		*phy;		/* If platform uses phy */
>  	void			*plat_data;	/* Other platform data */
>  };
>  
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index d5ced13..f61093b 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -142,6 +142,21 @@ static int ahci_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	hpriv->phy = devm_phy_get(dev, "sata-phy");
> +	if (IS_ERR(hpriv->phy)) {
> +		dev_dbg(dev, "can't get sata-phy\n");
> +		/* return only if -EPROBE_DEFER */
> +		if (PTR_ERR(hpriv->phy) == -EPROBE_DEFER) {
> +			rc = -EPROBE_DEFER;
> +			goto disable_unprepare_clk;
> +		}
> +	}
> +
> +	if (!IS_ERR(hpriv->phy)) {
> +		phy_init(hpriv->phy);

Don't we have to check the return values of phy_init and phy_power_on? Is it
not needed because it is an optional phy?

Thanks
Kishon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
