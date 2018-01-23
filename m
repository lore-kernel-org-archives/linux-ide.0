From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH V6 7/7] ata: ahci_tegra: Add AHCI support for tegra210
Date: Tue, 23 Jan 2018 17:56:13 +0200
Message-ID: <00e96e38-8194-33a0-0057-31718ebce62f@kapsi.fi>
References: <1515482234-24716-1-git-send-email-pchandru@nvidia.com>
 <1515482234-24716-8-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([91.232.154.25]:50654 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbeAWP4P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 23 Jan 2018 10:56:15 -0500
In-Reply-To: <1515482234-24716-8-git-send-email-pchandru@nvidia.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Preetham Chandru Ramchandra <pchandru@nvidia.com>, thierry.reding@gmail.com, tj@kernel.org
Cc: preetham260@gmail.com, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com

Tegra210 should be capitalized in the subject, and a commit message is 
needed.

   Add support for the AHCI-compliant Serial ATA host controller on the
   Tegra210 system-on-chip.

Otherwise,
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

Mikko

On 01/09/2018 09:17 AM, Preetham Chandru Ramchandra wrote:
> From: Preetham Ramchandra <pchandru@nvidia.com>
> 
> Signed-off-by: Preetham Chandru R <pchandru@nvidia.com>
> ---
>   drivers/ata/ahci_tegra.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
> index 013880de6412..3f00dfa3760d 100644
> --- a/drivers/ata/ahci_tegra.c
> +++ b/drivers/ata/ahci_tegra.c
> @@ -256,6 +256,10 @@ static const struct tegra_ahci_soc tegra124_ahci_soc_data = {
>   	},
>   };
>   
> +static const struct tegra_ahci_soc tegra210_ahci_soc_data = {
> +	.quirks = NO_DEVSLP,
> +};
> +

Nit, I'd prefer this to be directly above the of_device_id table.

>   static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
>   {
>   	struct tegra_ahci_priv *tegra = hpriv->plat_data;
> @@ -471,6 +475,10 @@ static const struct of_device_id tegra_ahci_of_match[] = {
>   		.compatible = "nvidia,tegra124-ahci",
>   		.data = &tegra124_ahci_soc_data
>   	},
> +	{
> +		.compatible = "nvidia,tegra210-ahci",
> +		.data = &tegra210_ahci_soc_data
> +	},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, tegra_ahci_of_match);
> @@ -585,5 +593,5 @@ static struct platform_driver tegra_ahci_driver = {
>   module_platform_driver(tegra_ahci_driver);
>   
>   MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
> -MODULE_DESCRIPTION("Tegra124 AHCI SATA driver");
> +MODULE_DESCRIPTION("Tegra AHCI SATA driver");
>   MODULE_LICENSE("GPL v2");
> 
