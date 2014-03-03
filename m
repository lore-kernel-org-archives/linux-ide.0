From: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v7 05/15] ahci-platform: "Library-ise"
 ahci_probe functionality
Date: Mon, 03 Mar 2014 19:38:46 +0100
Message-ID: <5595487.lrvcOAaluO@amdc1032>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com>
 <1393084424-31099-6-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDMLN5HOIYIMHGGTTACRUBBVQ57MM-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-reply-to: <1393084424-31099-6-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Saturday, February 22, 2014 04:53:34 PM Hans de Goede wrote:
> ahci_probe consists of 3 steps:
> 1) Get resources (get mmio, clks, regulator)
> 2) Enable resources, handled by ahci_platform_enable_resouces
> 3) The more or less standard ahci-host controller init sequence
> 
> This commit refactors step 1 and 3 into separate functions, so the platform
> drivers for AHCI implementations which need a specific order in step 2,
> and / or need to do some custom register poking at some time, can re-use
> ahci-platform.c code without needing to copy and paste it.
> 
> Note that ahci_platform_init_host's prototype takes the 3 non function
> members of ahci_platform_data as arguments, the idea is that drivers using
> the new exported utility functions will not use ahci_platform_data at all,
> and hopefully in the future ahci_platform_data can go away entirely.
> 
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/ata/ahci_platform.c   | 195 ++++++++++++++++++++++++++++--------------
>  include/linux/ahci_platform.h |  14 +++
>  2 files changed, 144 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 6ebbc17..7f3f2ac 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -201,64 +201,64 @@ void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
>  }
>  EXPORT_SYMBOL_GPL(ahci_platform_disable_resources);
>  
> -static void ahci_put_clks(struct ahci_host_priv *hpriv)
> +static void ahci_platform_put_resources(struct device *dev, void *res)
>  {
> +	struct ahci_host_priv *hpriv = res;
>  	int c;
>  
>  	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
>  		clk_put(hpriv->clks[c]);
>  }
>  
> -static int ahci_probe(struct platform_device *pdev)
> +/**
> + *	ahci_platform_get_resources - Get platform resources
> + *	@pdev: platform device to get resources for
> + *
> + *	This function allocates an ahci_host_priv struct, and gets the
> + *	following resources, storing a reference to them inside the returned
> + *	struct:
> + *
> + *	1) mmio registers (IORESOURCE_MEM 0, mandatory)
> + *	2) regulator for controlling the targets power (optional)
> + *	3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
> + *	   or for non devicetree enabled platforms a single clock
> + *
> + *	LOCKING:
> + *	None.
> + *
> + *	RETURNS:
> + *	The allocated ahci_host_priv on success, otherwise an ERR_PTR value
> + */
> +struct ahci_host_priv *ahci_platform_get_resources(
> +	struct platform_device *pdev)

It would be better if these two lines were merged:

struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)

>  {
>  	struct device *dev = &pdev->dev;
> -	struct ahci_platform_data *pdata = dev_get_platdata(dev);
> -	const struct platform_device_id *id = platform_get_device_id(pdev);
> -	struct ata_port_info pi = ahci_port_info[id ? id->driver_data : 0];
> -	const struct ata_port_info *ppi[] = { &pi, NULL };
>  	struct ahci_host_priv *hpriv;
> -	struct ata_host *host;
> -	struct resource *mem;
>  	struct clk *clk;
> -	int irq;
> -	int n_ports;
> -	int i;
> -	int rc;
> +	int i, rc = -ENOMEM;
>  
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!mem) {
> -		dev_err(dev, "no mmio space\n");
> -		return -EINVAL;
> -	}
> +	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> +		return ERR_PTR(-ENOMEM);
>  
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		dev_err(dev, "no irq\n");
> -		return -EINVAL;
> -	}
> +	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
> +			     GFP_KERNEL);
> +	if (!hpriv)
> +		goto err_out;
>  
> -	if (pdata && pdata->ata_port_info)
> -		pi = *pdata->ata_port_info;
> +	devres_add(dev, hpriv);
>  
> -	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
> -	if (!hpriv) {
> -		dev_err(dev, "can't alloc ahci_host_priv\n");
> -		return -ENOMEM;
> -	}
> -
> -	hpriv->flags |= (unsigned long)pi.private_data;
> -
> -	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
> +	hpriv->mmio = devm_ioremap_resource(dev,
> +			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
>  	if (!hpriv->mmio) {

This should use IS_ERR() as devm_ioremap_resource() returns a pointer
to the remapped memory or an ERR_PTR() encoded error code on failure.

> -		dev_err(dev, "can't map %pR\n", mem);
> -		return -ENOMEM;
> +		dev_err(dev, "no mmio space\n");

Not needed, devm_ioremap_resource() prints an error message on error.

> +		goto err_out;

This should set rc to an error value from devm_ioremap_resource()
instead of returning -ENOMEM.

>  	}
>  
>  	hpriv->target_pwr = devm_regulator_get_optional(dev, "target");
>  	if (IS_ERR(hpriv->target_pwr)) {
>  		rc = PTR_ERR(hpriv->target_pwr);
>  		if (rc == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> +			goto err_out;
>  		hpriv->target_pwr = NULL;
>  	}
>  
> @@ -277,33 +277,62 @@ static int ahci_probe(struct platform_device *pdev)
>  		if (IS_ERR(clk)) {
>  			rc = PTR_ERR(clk);
>  			if (rc == -EPROBE_DEFER)
> -				goto free_clk;
> +				goto err_out;
>  			break;
>  		}
>  		hpriv->clks[i] = clk;
>  	}
>  
> -	rc = ahci_platform_enable_resources(hpriv);
> -	if (rc)
> -		goto free_clk;
> +	devres_remove_group(dev, NULL);
> +	return hpriv;
>  
> -	/*
> -	 * Some platforms might need to prepare for mmio region access,
> -	 * which could be done in the following init call. So, the mmio
> -	 * region shouldn't be accessed before init (if provided) has
> -	 * returned successfully.
> -	 */
> -	if (pdata && pdata->init) {
> -		rc = pdata->init(dev, hpriv->mmio);
> -		if (rc)
> -			goto disable_resources;
> -	}
> +err_out:
> +	devres_release_group(dev, NULL);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_get_resources);

[...]

The rest of the patch looks OK.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
