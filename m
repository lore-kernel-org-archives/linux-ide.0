From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [V6 PATCH 3/3] ata: ahci_platform: Add ACPI _CLS matching
Date: Thu, 26 Mar 2015 12:31:40 +0200
Message-ID: <20150326103140.GG1878@lahna.fi.intel.com>
References: <1427316368-20965-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1427316368-20965-4-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427316368-20965-4-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: rjw@rjwysocki.net, robert.moore@intel.com, lv.zheng@intel.com, lenb@kernel.org, hdegoede@redhat.com, tj@kernel.org, mjg59@srcf.ucam.org, gregkh@linuxfoundation.org, hanjun.guo@linaro.org, al.stone@linaro.org, graeme.gregory@linaro.org, leo.duran@amd.com, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-ide@vger.kernel.org

On Wed, Mar 25, 2015 at 03:46:08PM -0500, Suravee Suthikulpanit wrote:
> This patch adds ACPI supports for AHCI platform driver, which uses _CLS
> method to match the device.
> 
> The following is an example of ASL structure in DSDT for a SATA controller,
> which contains _CLS package to be matched by the ahci_platform driver:
> 
>   Device (AHC0) // AHCI Controller
>   {
>     Name(_HID, "AMDI0600")
>     Name (_CCA, 1)
>     Name (_CLS, Package (3)
>     {
>       0x01, // Base Class: Mass Storage
>       0x06, // Sub-Class: serial ATA
>       0x01, // Interface: AHCI
>     })
>     Name (_CRS, ResourceTemplate ()
>     {
>       Memory32Fixed (ReadWrite, 0xE0300000, 0x00010000)
>       Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive,,,) { 387 }
>     })
>   }
> 
> Also, since ATA driver should not require PCI support for ATA_ACPI,
> this patch removes dependency in the driver/ata/Kconfig.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

One minor comment, see below.

> ---
>  drivers/ata/Kconfig         | 2 +-
>  drivers/ata/ahci_platform.c | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 5f60155..50305e3 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -48,7 +48,7 @@ config ATA_VERBOSE_ERROR
>  
>  config ATA_ACPI
>  	bool "ATA ACPI Support"
> -	depends on ACPI && PCI
> +	depends on ACPI
>  	default y
>  	help
>  	  This option adds support for ATA-related ACPI objects.
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 78d6ae0..0536940 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -20,6 +20,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/libata.h>
>  #include <linux/ahci_platform.h>
> +#include <linux/acpi.h>
> +#include <linux/pci_ids.h>
>  #include "ahci.h"
>  
>  #define DRV_NAME "ahci"
> @@ -78,12 +80,19 @@ static const struct of_device_id ahci_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ahci_of_match);
>  
> +static const struct acpi_device_id ahci_acpi_match[] = {
> +	{ ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xFFFFFF) },
                                                         ^^^^^^^^
We typically write hex literals in lower case (0xffffff).

> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
> +
>  static struct platform_driver ahci_driver = {
>  	.probe = ahci_probe,
>  	.remove = ata_platform_remove_one,
>  	.driver = {
>  		.name = DRV_NAME,
>  		.of_match_table = ahci_of_match,
> +		.acpi_match_table = ahci_acpi_match,
>  		.pm = &ahci_pm_ops,
>  	},
>  };
> -- 
> 2.1.0
