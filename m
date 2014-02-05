From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [Patch v4 3/3] ata: sata_mv: Fix probe failures with optional
 phys
Date: Wed, 5 Feb 2014 11:00:24 +0530
Message-ID: <52F1CC70.4080605@ti.com>
References: <1391535193-24165-1-git-send-email-andrew@lunn.ch> <1391535193-24165-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51964 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbaBEFag (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Feb 2014 00:30:36 -0500
In-Reply-To: <1391535193-24165-3-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, tj@kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Gregory Clement <gregory.clement@free-electrons.com>, linux-ide@vger.kernel.org

On Tuesday 04 February 2014 11:03 PM, Andrew Lunn wrote:
> Make use of devm_phy_optional_get() in order to fix probe failures on
> Armada 370, XP and others, when there is no phy driver available.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> v2
>  No change
> v3
>  Fix commit log devm_get_optional->devm_option_get.
> v4
>  Add Tested-by: & Acked-by:
>  Fix comment again.
> ---
>  drivers/ata/sata_mv.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 20a7517bd339..52b8181ddafd 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -4126,12 +4126,14 @@ static int mv_platform_probe(struct platform_device *pdev)
>  			clk_prepare_enable(hpriv->port_clks[port]);
>  
>  		sprintf(port_number, "port%d", port);
> -		hpriv->port_phys[port] = devm_phy_get(&pdev->dev, port_number);
> +		hpriv->port_phys[port] = devm_phy_optional_get(&pdev->dev,
> +							       port_number);
>  		if (IS_ERR(hpriv->port_phys[port])) {
>  			rc = PTR_ERR(hpriv->port_phys[port]);
>  			hpriv->port_phys[port] = NULL;
> -			if ((rc != -EPROBE_DEFER) && (rc != -ENODEV))
> -				dev_warn(&pdev->dev, "error getting phy");
> +			if (rc != -EPROBE_DEFER)
> +				dev_warn(&pdev->dev, "error getting phy %d",
> +					rc);
>  			goto err;
>  		} else
>  			phy_power_on(hpriv->port_phys[port]);
> 

