From: Mikko Perttunen <cyndis-/1wQRMveznE@public.gmane.org>
Subject: Re: [PATCH V6 5/7] ata: ahci_tegra: disable devslp for t124
Date: Tue, 23 Jan 2018 17:51:37 +0200
Message-ID: <9a6cc02c-0a1b-ef03-5c20-a95f421cffc4@kapsi.fi>
References: <1515482234-24716-1-git-send-email-pchandru@nvidia.com>
 <1515482234-24716-6-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515482234-24716-6-git-send-email-pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Preetham Chandru Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Reviewed-by: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

On 01/09/2018 09:17 AM, Preetham Chandru Ramchandra wrote:
> From: Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> t124 does not support devslp and it should be
> disabled.
> 
> Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/ata/ahci_tegra.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index 90dfa803607e..a59a97b1b2e5 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -145,6 +145,10 @@
>   #define FUSE_SATA_CALIB					0x124
>   #define FUSE_SATA_CALIB_MASK				0x3
>   
> +enum {
> +	NO_DEVSLP	= (1 << 0),
> +};
> +
>   struct sata_pad_calibration {
>   	u8 gen1_tx_amp;
>   	u8 gen1_tx_peak;
> @@ -166,12 +170,14 @@ struct tegra_ahci_ops {
>   struct tegra_ahci_soc {
>   	const char *const	*supply_names;
>   	u32			num_supplies;
> +	u32			quirks;
>   	struct tegra_ahci_ops	ops;
>   };
>   
>   struct tegra_ahci_priv {
>   	struct platform_device	   *pdev;
>   	void __iomem		   *sata_regs;
> +	void __iomem		   *sata_aux_regs;
>   	struct reset_control	   *sata_rst;
>   	struct reset_control	   *sata_oob_rst;
>   	struct reset_control	   *sata_cold_rst;
> @@ -185,6 +191,18 @@ static const char *const tegra124_supply_names[] = {
>   	"avdd", "hvdd", "vddio", "target-5v", "target-12v"
>   };
>   
> +static void tegra_ahci_handle_quirks(struct ahci_host_priv *hpriv)
> +{
> +	struct tegra_ahci_priv *tegra = hpriv->plat_data;
> +	u32 val;
> +
> +	if (tegra->sata_aux_regs && (tegra->soc_data->quirks & NO_DEVSLP)) {
> +		val = readl(tegra->sata_aux_regs + SATA_AUX_MISC_CNTL_1_0);
> +		val &= ~SATA_AUX_MISC_CNTL_1_0_SDS_SUPPORT;
> +		writel(val, tegra->sata_aux_regs + SATA_AUX_MISC_CNTL_1_0);
> +	}
> +}
> +
>   static int tegra124_ahci_init(struct ahci_host_priv *hpriv)
>   {
>   	struct tegra_ahci_priv *tegra = hpriv->plat_data;
> @@ -232,6 +250,7 @@ static int tegra124_ahci_init(struct ahci_host_priv *hpriv)
>   static const struct tegra_ahci_soc tegra124_ahci_soc_data = {
>   	.supply_names = tegra124_supply_names,
>   	.num_supplies = ARRAY_SIZE(tegra124_supply_names),
> +	.quirks = NO_DEVSLP,
>   	.ops = {
>   		.init = tegra124_ahci_init,
>   	},
> @@ -412,6 +431,7 @@ static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
>   	val &= ~SATA_CONFIGURATION_0_CLK_OVERRIDE;
>   	writel(val, tegra->sata_regs + SATA_CONFIGURATION_0);
>   
> +	tegra_ahci_handle_quirks(hpriv);
>   
>   	/* Unmask SATA interrupts */
>   
> @@ -485,6 +505,15 @@ static int tegra_ahci_probe(struct platform_device *pdev)
>   	tegra->sata_regs = devm_ioremap_resource(&pdev->dev, res);
>   	if (IS_ERR(tegra->sata_regs))
>   		return PTR_ERR(tegra->sata_regs);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	/*
> +	 * Aux register is optional.
> +	 */
> +	if (res) {
> +		tegra->sata_aux_regs = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(tegra->sata_aux_regs))
> +			return PTR_ERR(tegra->sata_aux_regs);
> +	}
>   
>   	tegra->sata_rst = devm_reset_control_get(&pdev->dev, "sata");
>   	if (IS_ERR(tegra->sata_rst)) {
> 
