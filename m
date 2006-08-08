From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/2] libata: implement to get tf's from _GTF and execute
 them
Date: Tue, 8 Aug 2006 12:19:02 -0700
Message-ID: <20060808121902.2771f60b.rdunlap@xenotime.net>
References: <1153899372.4957.61.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:40167 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964940AbWHHTQW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Aug 2006 15:16:22 -0400
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 8 Aug 2006 12:16:18 -0700
In-Reply-To: <1153899372.4957.61.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org

On Wed, 26 Jul 2006 15:36:12 +0800 zhao, forrest wrote:

> 1 update the Makefile, Kconfig, kernel-parameters.txt, and add
> definition of noacpi
> 2 implement core SATA-ACPI functions
> 3 implement the functions for getting tf's from _GTF and executing them
> 4 invoke ata_acpi_exec_tfs in appropriate places
> 
> 
> Signed-off-by: Zhao Forrest <forrest.zhao@intel.com>

Thanks for following up on this and sorry about my delay
in reviewing/commenting on them.

A few comments below.


> ---
> 
>  Documentation/kernel-parameters.txt |    5 
>  drivers/scsi/Kconfig                |   13 +
>  drivers/scsi/Makefile               |    1 
>  drivers/scsi/libata-acpi.c          |  654 +++++++++++++++++++++++++++++++++++
>  drivers/scsi/libata-core.c          |    7 
>  drivers/scsi/libata.h               |   28 +
>  include/linux/libata.h              |    6 
>  7 files changed, 714 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/scsi/libata-acpi.c
> 
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 96a81cd..364f171 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -619,6 +619,19 @@ config SCSI_SATA_INTEL_COMBINED
>  	depends on IDE=y && !BLK_DEV_IDE_SATA && (SCSI_SATA_AHCI || SCSI_ATA_PIIX)
>  	default y
>  
> +config SCSI_SATA_ACPI

When my patches had support for both SATA and PATA ACPI methods,
people wanted this config symbol to be SCSI_ATA_ACPI, which is
more generic...

> +	bool
> +	depends on SCSI_SATA && ACPI && PCI
> +	default y
> +	help
> +	  This option adds support for SATA-related ACPI objects.
> +	  These ACPI objects add the ability to retrieve taskfiles
> +	  from the ACPI BIOS and write them to the disk controller.
> +	  These objects may be related to performance, security,
> +	  power management, or other areas.
> +	  You can disable this at kernel boot time by using the
> +	  option 'libata.noacpi'.
> +
>  config SCSI_BUSLOGIC
>  	tristate "BusLogic SCSI support"
>  	depends on (PCI || ISA || MCA) && SCSI && ISA_DMA_API

> diff --git a/drivers/scsi/libata-acpi.c b/drivers/scsi/libata-acpi.c
> new file mode 100644
> index 0000000..cf7eeb1
> --- /dev/null
> +++ b/drivers/scsi/libata-acpi.c
> @@ -0,0 +1,654 @@
> +
> +#define DEBUGGING	1
> +/* note: adds function name and KERN_DEBUG */
> +#ifdef DEBUGGING
> +#define DEBPRINT(fmt, args...)	\
> +		printk(KERN_DEBUG "%s: " fmt, __FUNCTION__, ## args)
> +#else
> +#define DEBPRINT(fmt, args...)	do {} while (0)
> +#endif	/* DEBUGGING */

Drop the DEBUGGING and DEBPRINT() stuff.
(already done in my later patch, see below)


> +/**
> + * pata_get_dev_handle - finds acpi_handle and PCI device.function
> + * @dev: device to locate
> + * @handle: returned acpi_handle for @dev
> + * @pcidevfn: return PCI device.func for @dev
> + *
> + * The PATA and SATA versions of this function are different.
> + *
> + * Returns 0 on success, <0 on error.
> + */
> +static int pata_get_dev_handle(struct device *dev, acpi_handle *handle,
> +					acpi_integer *pcidevfn)
> +{
> +	unsigned int domain, bus, devnum, func;
> +	acpi_integer addr;
> +	acpi_handle dev_handle, parent_handle;
> +	int scanned;
> +	struct acpi_buffer buffer = {.length = ACPI_ALLOCATE_BUFFER,
> +					.pointer = NULL};
> +	acpi_status status;
> +	struct acpi_device_info	*dinfo = NULL;
> +	int ret = -ENODEV;
> +
> +	printk(KERN_DEBUG "%s: ENTER: dev->bus_id='%s'\n",
> +		__FUNCTION__,  dev->bus_id);
> +
> +	if ((scanned = sscanf(dev->bus_id, "%x:%x:%x.%x",
> +			&domain, &bus, &devnum, &func)) != 4) {
> +		printk("sscanf ret. %d\n", scanned);
> +		goto err;
> +	}

I had a later patch version that didn't use sscanf(), as
requested by reviewers on the mailing list.

I thought that you had the latest patch version, but I suppose
you didn't.  It was against 2.6.16-rc5-mm3 and I have put the
patch tarball at
http://www.xenotime.net/linux/SATA/2.6.16-rc5-mm3/ata-acpi-2616-rc5mm3.tgz

Patch also needs to be updated to use the "new" printk
macros with debug level support.


> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 386e5f2..cd4cf97 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -91,6 +91,10 @@ static int ata_probe_timeout = ATA_TMOUT
>  module_param(ata_probe_timeout, int, 0444);
>  MODULE_PARM_DESC(ata_probe_timeout, "Set ATA probing timeout (seconds)");
>  
> +int noacpi = 0;

Drop the "= 0".  It will be init. to 0 anyway.
(Yes, I know my patch had that. :)

> +module_param(noacpi, int, 0444);
> +MODULE_PARM_DESC(noacpi, "Disables use of ACPI in suspend/resume when set");
> +
>  MODULE_AUTHOR("Jeff Garzik");
>  MODULE_DESCRIPTION("Library module for ATA devices");
>  MODULE_LICENSE("GPL");


---
~Randy
