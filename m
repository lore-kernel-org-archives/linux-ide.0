From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ata: Disable AHCI ALPM feature for Ampere Computing eMAG
 SATA
Date: Mon, 27 Aug 2018 21:08:35 +0200
Message-ID: <d3cef828-6c18-f061-0fe8-1579bcf602c5@redhat.com>
References: <1535395673-30649-1-git-send-email-stripathi@amperecomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535395673-30649-1-git-send-email-stripathi@amperecomputing.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Tripathi <stripathi@amperecomputing.com>, tj@kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, joe@perches.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: patches@amperecomputing.com, Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>, Jens Axboe <axboe@kernel.dk>
List-Id: linux-ide@vger.kernel.org

Hi,

On 27-08-18 20:47, Suman Tripathi wrote:
> Due to hardware errata, Ampere Computing eMAG SATA can't support
> AHCI ALPM feature. This patch disables the AHCI ALPM feature for
> eMAG SATA.
> 
> Signed-off-by: Suman Tripathi <stripathi@amperecomputing.com>
> Signed-off-by: Rameshwar Prasad Sahu <rameshwar.sahu@amperecomputing.com>

Thank you for the patch. 2 remarks:

1) The ata code is maintained by Jens Axboe (added to the Cc) now, this
is a very recent change, which still has to hit MAINTAINERS

2) See below


> ---
>   drivers/ata/ahci_platform.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 99f9a89..0d0233e 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -26,7 +26,7 @@
> 
>   #define DRV_NAME "ahci"
> 
> -static const struct ata_port_info ahci_port_info = {
> +static struct ata_port_info ahci_port_info = {
>   	.flags		= AHCI_FLAG_COMMON,
>   	.pio_mask	= ATA_PIO4,
>   	.udma_mask	= ATA_UDMA6,

Please do not remove const here, if you need to make a shared info struct
like this non const you are usually doing something wrong (see below).

> @@ -41,6 +41,8 @@ static int ahci_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct ahci_host_priv *hpriv;
> +	struct acpi_device_info *info;
> +	acpi_status status;
>   	int rc;
> 
>   	hpriv = ahci_platform_get_resources(pdev);
> @@ -57,6 +59,15 @@ static int ahci_probe(struct platform_device *pdev)
>   	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>   		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
> 
> +	status = acpi_get_object_info(ACPI_HANDLE(dev), &info);
> +	if (ACPI_SUCCESS(status)) {
> +		if (info->valid & ACPI_VALID_HID) {
> +			if (!strcmp("APMC0D33", info->hardware_id.string))
> +				ahci_port_info.flags |= ATA_FLAG_NO_LPM;
> +		}
> +		ACPI_FREE(info);
> +	}
> +
>   	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
>   				     &ahci_platform_sht);
>   	if (rc)

The normal way to get specific behavior for a specific ACPI HID is
to put the HID in the ahci_acpi_match table and use the acpi_device_id
field to pass some flags (or a pointer).

So the proper way to fix this is to do something like this:

1) Add:

static const struct ata_port_info ahci_port_info_nolpm = {
         .flags          = AHCI_FLAG_COMMON | ATA_FLAG_NO_LPM,
         .pio_mask       = ATA_PIO4,
         .udma_mask      = ATA_UDMA6,
         .port_ops       = &ahci_platform_ops,
};

2) Modify ahci_acpi_match table to:

static const struct acpi_device_id ahci_acpi_match[] = {
	{ "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
         { ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
         {},
};

3) In ahci_probe() do:

	const struct ata_port_info *port;

	...

	port = acpi_device_get_match_data(dev);
	if (!port)
		port = &ahci_port_info;

	rc = ahci_platform_init_host(pdev, hpriv, port, &ahci_platform_sht);


Regards,

Hans
