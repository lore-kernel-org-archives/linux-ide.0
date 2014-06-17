From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH RESEND] libahci_platform: Fail when PHY required but PHY
 support disabled
Date: Tue, 17 Jun 2014 14:33:58 +0200
Message-ID: <1661226.KiZhVLZAOz@amdc1032>
References: <1403006875-22556-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54379 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281AbaFQMfW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2014 08:35:22 -0400
In-reply-to: <1403006875-22556-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, June 17, 2014 03:07:55 PM Mikko Perttunen wrote:
> ahci_platform_get_resources handles resource management for
> platform AHCI drivers, including getting a possible PHY
> from the device tree. Since not all drivers need a PHY, it
> ignores -ENODEV and -ENOSYS from devm_get_phy. However, when
> the PHY subsystem is mistakenly disabled, -ENOSYS can be
> returned even when a PHY is needed.
> 
> This patch modifies the -ENOSYS case to check if a "phys"
> device tree node exists. If it exists, then clearly the PHY
> subsystem is mistakenly disabled and the driver cannot work,
> ahci_platform_get_resources will fail and propagate the error.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  drivers/ata/libahci_platform.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 3a5b4ed..b007758 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -250,8 +250,13 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
>  	if (IS_ERR(hpriv->phy)) {
>  		rc = PTR_ERR(hpriv->phy);
>  		switch (rc) {
> -		case -ENODEV:
>  		case -ENOSYS:
> +			/* No PHY support. Check if PHY is required. */
> +			if (of_find_property(dev->of_node, "phys", NULL)) {
> +				dev_err(dev, "couldn't get sata-phy: ENOSYS\n");
> +				goto err_out;
> +			}
> +		case -ENODEV:
>  			/* continue normally */
>  			hpriv->phy = NULL;
>  			break;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

