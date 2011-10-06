From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH V9 2/5] ahci_plt Add the board_ids and pi refer to different
 features
Date: Thu, 06 Oct 2011 02:22:01 -0400
Message-ID: <4E8D4909.9030603@pobox.com>
References: <1317195717-21174-1-git-send-email-richard.zhu@linaro.org> <1317195717-21174-3-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55828 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935288Ab1JFGWF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2011 02:22:05 -0400
Received: by qadb15 with SMTP id b15so1744721qad.19
        for <linux-ide@vger.kernel.org>; Wed, 05 Oct 2011 23:22:04 -0700 (PDT)
In-Reply-To: <1317195717-21174-3-git-send-email-richard.zhu@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhu@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-ide@vger.kernel.org, avorontsov@ru.mvista.com, eric@eukrea.com, eric.miao@linaro.org

On 09/28/2011 03:41 AM, Richard Zhu wrote:
> On imx53 AHCI, soft reset fails with IPMS set when PMP
> is enabled but SATA HDD/ODD is connected to SATA port,
> do soft reset again to port 0.
> So the 'ahci_pmp_retry_srst_ops' is required when imx53
> ahci is present.
>
> Signed-off-by: Richard Zhu<richard.zhu@linaro.org>
> Acked-by: Eric Miao<eric.miao@linaro.org>
> ---
>   drivers/ata/ahci_platform.c |   44 +++++++++++++++++++++++++++++++++++++-----
>   1 files changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 6fef1fa..c03277d 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -23,6 +23,41 @@
>   #include<linux/ahci_platform.h>
>   #include "ahci.h"
>
> +enum ahci_type {
> +	AHCI,		/* standard platform ahci */
> +	IMX53_AHCI,	/* ahci on i.mx53 */
> +};
> +
> +static struct platform_device_id ahci_devtype[] = {
> +	{
> +		.name = "ahci",
> +		.driver_data = AHCI,
> +	}, {
> +		.name = "imx53-ahci",
> +		.driver_data = IMX53_AHCI,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(platform, ahci_devtype);
> +
> +
> +static const struct ata_port_info ahci_port_info[] = {
> +	/* by features */
> +	[AHCI] = {
> +		.flags		= AHCI_FLAG_COMMON,
> +		.pio_mask	= ATA_PIO4,
> +		.udma_mask	= ATA_UDMA6,
> +		.port_ops	=&ahci_ops,
> +	},
> +	[IMX53_AHCI] = {
> +		.flags		= AHCI_FLAG_COMMON,
> +		.pio_mask	= ATA_PIO4,
> +		.udma_mask	= ATA_UDMA6,
> +		.port_ops	=&ahci_pmp_retry_srst_ops,
> +	},
> +};
> +
>   static struct scsi_host_template ahci_platform_sht = {
>   	AHCI_SHT("ahci_platform"),
>   };
> @@ -31,12 +66,8 @@ static int __init ahci_probe(struct platform_device *pdev)
>   {
>   	struct device *dev =&pdev->dev;
>   	struct ahci_platform_data *pdata = dev->platform_data;
> -	struct ata_port_info pi = {
> -		.flags		= AHCI_FLAG_COMMON,
> -		.pio_mask	= ATA_PIO4,
> -		.udma_mask	= ATA_UDMA6,
> -		.port_ops	=&ahci_ops,
> -	};
> +	const struct platform_device_id *id = platform_get_device_id(pdev);
> +	struct ata_port_info pi = ahci_port_info[id->driver_data];
>   	const struct ata_port_info *ppi[] = {&pi, NULL };
>   	struct ahci_host_priv *hpriv;
>   	struct ata_host *host;
> @@ -177,6 +208,7 @@ static struct platform_driver ahci_driver = {
>   		.name = "ahci",
>   		.owner = THIS_MODULE,
>   	},
> +	.id_table	= ahci_devtype,
>   };

Looks good...  I queued this one.

	Jeff




