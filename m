From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 3/9] drivers: ata: ahci_tegra: use
 devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 10:04:45 +0000
Message-ID: <c16b35f1-0c0a-707b-d097-bb0440454cbb@nvidia.com>
References: <1552382374-28789-1-git-send-email-info@metux.net>
 <1552382374-28789-3-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552382374-28789-3-git-send-email-info@metux.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com, linus.walleij@linaro.org, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On 12/03/2019 09:19, Enrico Weigelt, metux IT consult wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/ata/ahci_tegra.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index 004f260..88748ca 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -490,7 +490,6 @@ static int tegra_ahci_probe(struct platform_device *pdev)
>  {
>  	struct ahci_host_priv *hpriv;
>  	struct tegra_ahci_priv *tegra;
> -	struct resource *res;
>  	int ret;
>  	unsigned int i;
>  
> @@ -507,19 +506,17 @@ static int tegra_ahci_probe(struct platform_device *pdev)
>  	tegra->pdev = pdev;
>  	tegra->soc = of_device_get_match_data(&pdev->dev);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	tegra->sata_regs = devm_ioremap_resource(&pdev->dev, res);
> +	tegra->sata_regs = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(tegra->sata_regs))
>  		return PTR_ERR(tegra->sata_regs);
>  
>  	/*
>  	 * AUX registers is optional.
>  	 */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> -	if (res) {
> -		tegra->sata_aux_regs = devm_ioremap_resource(&pdev->dev, res);
> -		if (IS_ERR(tegra->sata_aux_regs))
> -			return PTR_ERR(tegra->sata_aux_regs);
> +	tegra->sata_aux_regs = devm_platform_ioremap_resource(pdev, 2);
> +	if (IS_ERR(tegra->sata_aux_regs)) {
> +		dev_info(&pdev->dev, "Cant get aux registers (optional)");

dev_err?

> +		tegra->sata_aux_regs = NULL;

This bit does not look right, because although the AUX registers are
optional, now we don't know if it failed because they are not supported
for a given device or something else failed. So I am not sure we can do
this here.

Cheers
Jon

-- 
nvpublic
