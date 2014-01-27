From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v5 07/14] ahci-platform: "Library-ise" ahci_probe
 functionality
Date: Mon, 27 Jan 2014 12:39:52 +0200
Message-ID: <52E63778.5000509@ti.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
 <1390417489-5354-8-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1390417489-5354-8-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org, Oliver Schinagl <oliver@schinagl.nl>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-sunxi@googlegroups.com, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hi,

On 01/22/2014 09:04 PM, Hans de Goede wrote:
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
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/ata/ahci_platform.c   | 158 ++++++++++++++++++++++++------------------
>  include/linux/ahci_platform.h |  14 ++++
>  2 files changed, 106 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 1cce7a2..b260ebe 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -150,60 +150,31 @@ void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
>  EXPORT_SYMBOL_GPL(ahci_platform_disable_resources);
>  
>  
> -static void ahci_put_clks(struct ahci_host_priv *hpriv)
> -{
> -	int c;
> -
> -	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
> -		clk_put(hpriv->clks[c]);
> -}
> -
> -static int ahci_probe(struct platform_device *pdev)
> +struct ahci_host_priv *ahci_platform_get_resources(
> +	struct platform_device *pdev)
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
> -	int i, irq, max_clk, n_ports, rc;
> -
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!mem) {
> -		dev_err(dev, "no mmio space\n");
> -		return -EINVAL;
> -	}
> -
> -	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		dev_err(dev, "no irq\n");
> -		return -EINVAL;
> -	}
> -
> -	if (pdata && pdata->ata_port_info)
> -		pi = *pdata->ata_port_info;
> +	int i, max_clk, rc;
>  
>  	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
>  	if (!hpriv) {
>  		dev_err(dev, "can't alloc ahci_host_priv\n");
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	hpriv->flags |= (unsigned long)pi.private_data;
> -
> -	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
> +	hpriv->mmio = devm_ioremap_resource(dev,
> +			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
>  	if (!hpriv->mmio) {
> -		dev_err(dev, "can't map %pR\n", mem);
> -		return -ENOMEM;
> +		dev_err(dev, "no mmio space\n");
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	hpriv->target_pwr = devm_regulator_get_optional(dev, "target");
>  	if (IS_ERR(hpriv->target_pwr)) {
>  		if (PTR_ERR(hpriv->target_pwr) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> +			return ERR_PTR(-EPROBE_DEFER);
>  		hpriv->target_pwr = NULL;
>  	}
>  
> @@ -223,27 +194,48 @@ static int ahci_probe(struct platform_device *pdev)
>  		hpriv->clks[i] = clk;
>  	}
>  
> -	rc = ahci_platform_enable_resources(hpriv);
> -	if (rc)
> -		goto free_clk;
> +	return hpriv;
>  
> -	/*
> -	 * Some platforms might need to prepare for mmio region access,
> -	 * which could be done in the following init call. So, the mmio
> -	 * region shouldn't be accessed before init (if provided) has
> -	 * returned successfully.
> -	 */
> -	if (pdata && pdata->init) {
> -		rc = pdata->init(dev, hpriv);
> -		if (rc)
> -			goto disable_resources;
> -	}
> +free_clk:
> +	while (--i >= 0)
> +		clk_put(hpriv->clks[i]);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_get_resources);
> +
> +void ahci_platform_put_resources(struct ahci_host_priv *hpriv)
> +{
> +	int c;
> +
> +	for (c = 0; c < AHCI_MAX_CLKS && hpriv->clks[c]; c++)
> +		clk_put(hpriv->clks[c]);
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_put_resources);
> +
> +
> +int ahci_platform_init_host(struct platform_device *pdev,
> +			    struct ahci_host_priv *hpriv,
> +			    const struct ata_port_info *pi_template,
> +			    unsigned int force_port_map,
> +			    unsigned int mask_port_map)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ata_port_info pi = *pi_template;
> +	const struct ata_port_info *ppi[] = { &pi, NULL };
> +	struct ata_host *host;
> +	int i, irq, n_ports, rc;
>  
> -	ahci_save_initial_config(dev, hpriv,
> -		pdata ? pdata->force_port_map : 0,
> -		pdata ? pdata->mask_port_map  : 0);
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq <= 0) {
> +		dev_err(dev, "no irq\n");
> +		return -EINVAL;
> +	}
>  
>  	/* prepare host */
> +	hpriv->flags |= (unsigned long)pi.private_data;
> +
> +	ahci_save_initial_config(dev, hpriv, force_port_map, mask_port_map);
> +
>  	if (hpriv->cap & HOST_CAP_NCQ)
>  		pi.flags |= ATA_FLAG_NCQ;
>  
> @@ -260,10 +252,8 @@ static int ahci_probe(struct platform_device *pdev)
>  	n_ports = max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
>  
>  	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
> -	if (!host) {
> -		rc = -ENOMEM;
> -		goto pdata_exit;
> -	}
> +	if (!host)
> +		return -ENOMEM;
>  
>  	host->private_data = hpriv;
>  
> @@ -278,7 +268,8 @@ static int ahci_probe(struct platform_device *pdev)
>  	for (i = 0; i < host->n_ports; i++) {
>  		struct ata_port *ap = host->ports[i];
>  
> -		ata_port_desc(ap, "mmio %pR", mem);
> +		ata_port_desc(ap, "mmio %pR",
> +			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
>  		ata_port_desc(ap, "port 0x%x", 0x100 + ap->port_no * 0x80);
>  
>  		/* set enclosure management message type */
> @@ -292,13 +283,48 @@ static int ahci_probe(struct platform_device *pdev)
>  
>  	rc = ahci_reset_controller(host);
>  	if (rc)
> -		goto pdata_exit;
> +		return rc;
>  
>  	ahci_init_controller(host);
>  	ahci_print_info(host, "platform");
>  
> -	rc = ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
> -			       &ahci_platform_sht);
> +	return ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
> +				 &ahci_platform_sht);
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_init_host);
> +
> +static int ahci_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ahci_platform_data *pdata = dev_get_platdata(dev);
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
> +	struct ahci_host_priv *hpriv;
> +	int rc;
> +
> +	hpriv = ahci_platform_get_resources(pdev);
> +	if (IS_ERR(hpriv))
> +		return PTR_ERR(hpriv);
> +
> +	rc = ahci_platform_enable_resources(hpriv);
> +	if (rc)
> +		goto put_resources;
> +
> +	/*
> +	 * Some platforms might need to prepare for mmio region access,
> +	 * which could be done in the following init call. So, the mmio
> +	 * region shouldn't be accessed before init (if provided) has
> +	 * returned successfully.
> +	 */
> +	if (pdata && pdata->init) {
> +		rc = pdata->init(dev, hpriv);
> +		if (rc)
> +			goto disable_resources;
> +	}
> +
> +	rc = ahci_platform_init_host(pdev, hpriv,
> +				     &ahci_port_info[id ? id->driver_data : 0],
> +				     pdata ? pdata->force_port_map : 0,
> +				     pdata ? pdata->mask_port_map  : 0);
>  	if (rc)
>  		goto pdata_exit;
>  
> @@ -308,8 +334,8 @@ pdata_exit:
>  		pdata->exit(dev);
>  disable_resources:
>  	ahci_platform_disable_resources(hpriv);
> -free_clk:
> -	ahci_put_clks(hpriv);
> +put_resources:
> +	ahci_platform_put_resources(hpriv);
>  	return rc;
>  }
>  
> @@ -323,7 +349,7 @@ static void ahci_host_stop(struct ata_host *host)
>  		pdata->exit(dev);
>  
>  	ahci_platform_disable_resources(hpriv);
> -	ahci_put_clks(hpriv);
> +	ahci_platform_put_resources(hpriv);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index 5e5f85e..1dc7602 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -20,7 +20,13 @@
>  struct device;
>  struct ata_port_info;
>  struct ahci_host_priv;
> +struct platform_device;
>  
> +/*
> + * Note ahci_platform_data is deprecated. New drivers which need to override
> + * any of these, should instead declare there own platform_driver struct, and
> + * use ahci_platform* functions in their own probe, suspend and resume methods.
> + */
>  struct ahci_platform_data {
>  	int (*init)(struct device *dev, struct ahci_host_priv *hpriv);
>  	void (*exit)(struct device *dev);
> @@ -35,5 +41,13 @@ int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
>  void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
>  int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
>  void ahci_platform_disable_resources(struct ahci_host_priv *hpriv);
> +struct ahci_host_priv *ahci_platform_get_resources(
> +	struct platform_device *pdev);

Why not use 'struct device' as the argument?

> +void ahci_platform_put_resources(struct ahci_host_priv *hpriv);

Can we have 'struct device' as the argument? Else it becomes
impossible to get 'struct device' from 'hpriv' if we need to call e.g.
pm_runtime_*() APIs.

> +int ahci_platform_init_host(struct platform_device *pdev,
> +			    struct ahci_host_priv *hpriv,
> +			    const struct ata_port_info *pi_template,
> +			    unsigned int force_port_map,
> +			    unsigned int mask_port_map);
>  
>  #endif /* _AHCI_PLATFORM_H */
> 

cheers,
-roger
