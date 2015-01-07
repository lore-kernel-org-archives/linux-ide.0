From: Feng Kan <fkan@apm.com>
Subject: Re: [PATCH] sata: xgene: add ACPI support for APM X-Gene SATA ports
Date: Wed, 7 Jan 2015 09:32:56 -0800
Message-ID: <CAL85gmAHLk9XCbr-1+USmOKxd5O7iCxWX0vqSRf74Brn2pzESg@mail.gmail.com>
References: <1418337070-17644-1-git-send-email-fkan@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418337070-17644-1-git-send-email-fkan@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: patches <patches@apm.com>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Salter <msalter@redhat.com>, tj@kernel.org, hdegoede@redhat.com
Cc: Feng Kan <fkan@apm.com>
List-Id: linux-ide@vger.kernel.org

Just want to ping this again.

Happy new year

On Thu, Dec 11, 2014 at 2:31 PM, Feng Kan <fkan@apm.com> wrote:
> This adds ACPI support for the APM X-Gene SATA ports. When the system
> boots using ACPI table, the SATA ports are able to configure using the
> values supplied by the ACPI table rather than the DTS.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> ---
>  drivers/ata/ahci_xgene.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index d0c851a..4951392 100644
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
> @@ -521,6 +522,14 @@ disable_resources:
>         return rc;
>  }
>
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id xgene_ahci_acpi_match[] = {
> +       { "APMC0D0D", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, xgene_ahci_acpi_match);
> +#endif
> +
>  static const struct of_device_id xgene_ahci_of_match[] = {
>         {.compatible = "apm,xgene-ahci"},
>         {},
> @@ -534,6 +543,7 @@ static struct platform_driver xgene_ahci_driver = {
>                 .name = "xgene-ahci",
>                 .owner = THIS_MODULE,
>                 .of_match_table = xgene_ahci_of_match,
> +               .acpi_match_table = ACPI_PTR(xgene_ahci_acpi_match),
>         },
>  };
>
> --
> 1.9.1
>
