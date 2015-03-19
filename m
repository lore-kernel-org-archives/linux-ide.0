From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH RESEND] sata: xgene: add ACPI support for APM X-Gene SATA
 ports
Date: Thu, 19 Mar 2015 11:58:50 +0200
Message-ID: <20150319095850.GO2165@lahna.fi.intel.com>
References: <1426723435-22378-1-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:14986 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbbCSJ6z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Mar 2015 05:58:55 -0400
Content-Disposition: inline
In-Reply-To: <1426723435-22378-1-git-send-email-fkan@apm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Feng Kan <fkan@apm.com>
Cc: patches@apm.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tj@kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Wed, Mar 18, 2015 at 05:03:55PM -0700, Feng Kan wrote:
> This adds ACPI support for the APM X-Gene SATA ports. When the system
> boots using ACPI table, the SATA ports are able to configure using the
> values supplied by the ACPI table rather than the DTS.
> 
> Signed-off-by: Feng Kan <fkan@apm.com>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

One minor comment, see below. Other than that this looks good to me:

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
>  drivers/ata/ahci_xgene.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index 2e8bb60..2b78510 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -22,6 +22,7 @@
>   * NOTE: PM support is not currently available.
>   *
>   */
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/ahci_platform.h>
> @@ -718,6 +719,14 @@ disable_resources:
>  	return rc;
>  }
>  
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id xgene_ahci_acpi_match[] = {
> +	{ "APMC0D0D", },

I think writing the above without comma would look better:

	{ "APMC0D0D" },


> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, xgene_ahci_acpi_match);
> +#endif
> +
>  static const struct of_device_id xgene_ahci_of_match[] = {
>  	{.compatible = "apm,xgene-ahci"},
>  	{},
> @@ -730,6 +739,7 @@ static struct platform_driver xgene_ahci_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
>  		.of_match_table = xgene_ahci_of_match,
> +		.acpi_match_table = ACPI_PTR(xgene_ahci_acpi_match),
>  	},
>  };
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
