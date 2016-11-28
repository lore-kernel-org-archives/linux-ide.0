From: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [v2,2/3] ata: ahci_tegra: Add support to disable features
Date: Mon, 28 Nov 2016 14:38:43 +0200
Message-ID: <bb810105-4196-0594-d378-3c6a7a94b475@nvidia.com>
References: <1479973418-21351-3-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479973418-21351-3-git-send-email-pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: PREETHAM RAMACHANDRA <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 24.11.2016 09:43, PREETHAM RAMACHANDRA wrote:
> From: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> Add support to disable DIPM, HIPM, DevSlp, partial, slumber and NCQ
> features from DT. By default these features are enabled.
>

Why are these features disabled? Are they broken on all Tegra210 chips, 
broken on specific boards or do they require some support from the 
driver that is not there?

Most likely we should hardcode the disabled features into the driver 
instead of reading them from the device tree.

> Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v2:
> * This change was created by seperating
>    "ata: ahci_tegra: add support for tegra210" from v1
>
>  drivers/ata/ahci_tegra.c | 107 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 82 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index d12e2a9..443c3e8 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -329,7 +329,7 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
>  	return ret;
>  }
>
> -static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
> +static void tegra_ahci_controller_deinit(struct ahci_host_priv *hpriv)
>  {
>  	struct tegra_ahci_priv *tegra = hpriv->plat_data;
>
> @@ -345,6 +345,85 @@ static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
>  	regulator_bulk_disable(tegra->soc_data->num_supplies, tegra->supplies);
>  }
>
> +static void tegra_ahci_host_stop(struct ata_host *host)
> +{
> +	struct ahci_host_priv *hpriv = host->private_data;
> +
> +	tegra_ahci_controller_deinit(hpriv);
> +}
> +
> +static struct ata_port_operations ahci_tegra_port_ops = {
> +	.inherits = &ahci_ops,
> +	.host_stop = tegra_ahci_host_stop,
> +};
> +
> +static struct ata_port_info ahci_tegra_port_info = {
> +	.flags = AHCI_FLAG_COMMON,
> +	.pio_mask = ATA_PIO4,
> +	.udma_mask = ATA_UDMA6,
> +	.port_ops = &ahci_tegra_port_ops,
> +};
> +
> +static void tegra_ahci_disable_devslp(struct tegra_ahci_priv *tegra)
> +{
> +	tegra_ahci_aux_update(tegra, 0, SDS_SUPPORT, SATA_AUX_MISC_CNTL_1_0);
> +}
> +
> +static void tegra_ahci_disable_hipm(struct tegra_ahci_priv *tegra)
> +{
> +	tegra_ahci_scfg_update(tegra, 0, T_SATA0_AHCI_HBA_CAP_BKDR_SALP,
> +			       T_SATA0_AHCI_HBA_CAP_BKDR);
> +}
> +
> +static void tegra_ahci_disable_partial(struct tegra_ahci_priv *tegra)
> +{
> +	tegra_ahci_scfg_update(tegra, 0,
> +			       T_SATA0_AHCI_HBA_CAP_BKDR_PARTIAL_ST_CAP,
> +			       T_SATA0_AHCI_HBA_CAP_BKDR);
> +}
> +
> +static void tegra_ahci_disable_slumber(struct tegra_ahci_priv *tegra)
> +{
> +	tegra_ahci_scfg_update(tegra, 0,
> +			       T_SATA0_AHCI_HBA_CAP_BKDR_SLUMBER_ST_CAP,
> +			       T_SATA0_AHCI_HBA_CAP_BKDR);
> +}
> +
> +static void tegra_ahci_disable_ncq(struct tegra_ahci_priv *tegra)
> +{
> +	tegra_ahci_scfg_update(tegra, 0, T_SATA0_AHCI_HBA_CAP_BKDR_SNCQ,
> +			       T_SATA0_AHCI_HBA_CAP_BKDR);
> +}

These probably don't need their own functions.

> +
> +static void tegra_ahci_disable_features(struct ahci_host_priv *hpriv)
> +{
> +	struct tegra_ahci_priv *tegra = hpriv->plat_data;
> +	struct platform_device *pdev = tegra->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct property *prop;
> +	const char *feature;
> +
> +	if (of_property_count_strings(np, "nvidia,disable-features") <= 0)
> +		return;
> +
> +	of_property_for_each_string(np, "nvidia,disable-features", prop,
> +				    feature) {
> +		if (!strcmp(feature, "devslp"))
> +			tegra_ahci_disable_devslp(tegra);
> +		else if (!strcmp(feature, "hipm"))
> +			tegra_ahci_disable_hipm(tegra);
> +		else if (!strcmp(feature, "ncq"))
> +			tegra_ahci_disable_ncq(tegra);
> +		else if (!strcmp(feature, "dipm"))
> +			ahci_tegra_port_info.flags |= ATA_FLAG_NO_DIPM;
> +		else if (!strcmp(feature, "partial"))
> +			tegra_ahci_disable_partial(tegra);
> +		else if (!strcmp(feature, "slumber"))
> +			tegra_ahci_disable_slumber(tegra);
> +	}
> +}
> +
>  static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
>  {
>  	struct tegra_ahci_priv *tegra = hpriv->plat_data;
> @@ -458,36 +537,14 @@ static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
>  	tegra_ahci_sata_update(tegra, 0, SATA_CONFIGURATION_CLK_OVERRIDE,
>  			       SATA_CONFIGURATION_0);
>
> +	tegra_ahci_disable_features(hpriv);
> +
>  	tegra_ahci_sata_update(tegra, IP_INT_MASK, IP_INT_MASK,
>  			       SATA_INTR_MASK_0);
>
>  	return 0;
>  }
>
> -static void tegra_ahci_controller_deinit(struct ahci_host_priv *hpriv)
> -{
> -	tegra_ahci_power_off(hpriv);
> -}
> -
> -static void tegra_ahci_host_stop(struct ata_host *host)
> -{
> -	struct ahci_host_priv *hpriv = host->private_data;
> -
> -	tegra_ahci_controller_deinit(hpriv);
> -}
> -
> -static struct ata_port_operations ahci_tegra_port_ops = {
> -	.inherits = &ahci_ops,
> -	.host_stop = tegra_ahci_host_stop,
> -};
> -
> -static const struct ata_port_info ahci_tegra_port_info = {
> -	.flags = AHCI_FLAG_COMMON,
> -	.pio_mask = ATA_PIO4,
> -	.udma_mask = ATA_UDMA6,
> -	.port_ops = &ahci_tegra_port_ops,
> -};
> -
>  static const struct of_device_id tegra_ahci_of_match[] = {
>  	{
>  	 .compatible = "nvidia,tegra124-ahci",
>
>

Thanks,
Mikko.
